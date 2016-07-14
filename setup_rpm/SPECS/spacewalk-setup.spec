# required definitions
%define company_shortname      example
%define company_propername     Example
%define company_domainname     example.com
%define localmirror_shortname  exmplmir
%define localmirror_propername Example Mirror
%define localmirror_hostname   exmplmir.%{company_domainname}

# Search for other ACTION sections when creating multiple environment areas
# ACTION: duplicate these definitions for each spacewalk sever/proxy in your environment
%define area1_shortname        site1dc
%define area1_propername       Site1 DC
%define area1_hostname         s1dc-spcw-00.%{company_domainname}
%define area2_shortname        site1dmz
%define area2_propername       Site1 DMZ
%define area2_hostname         s1dmz-spcw-00.%{company_domainname}
%define area3_shortname        site2dc
%define area3_propername       Site2 DC
%define area3_hostname         s2dc-spcw-00.%{company_domainname}

Name:           %{company_shortname}-spacewalk-setup
Version:        7
Release:        1
Summary:        %{company_proper} Spacewalk GPG Keys
Group:          System Environment/Base
License:        GPLv2

URL:            http://%{localmirror_hostname}/mirrors/spcw-setup
# yum repository templates
Source0:        localmirror-spcw-2.5-setup-el7.repo
Source1:        area-spcw-2.5-setup-el7.repo

# repository public keys
Source10:       https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
Source11:       http://www.jpackage.org/jpackage.asc
Source12:       http://yum.spacewalkproject.org/RPM-GPG-KEY-spacewalk-2015

# proprietary public keys
#Source20:       RPM-GPG-KEY-EXAMPLE.COM

BuildArch:      noarch
Requires:       redhat-release >=  %{version}

%description
This package contains the GPG keys needed for clients to be able to successfully
install packages when connected the %{company_proper} Spacewalk repositories.

%package %{localmirror_shortname}
Summary:        %{company_proper} Spacewalk Yum Repository Files for %{localmirror_hostname}
Group:          System Environment/Base
License:        GPLv2
Requires:       %{name} = %{version}-%{release}
%description %{localmirror_shortname}
This package contains the %localmirror_propername} yum repository configuration files
for access to packages needed for initial client configuration.

# ACTION: duplicate this section for each spacewalk server/proxy in your environment
%package %{area1_shortname}
Summary:        %{company_proper} Spacewalk Yum Repository Files for %{area1_hostname}
Group:          System Environment/Base
License:        GPLv2
Requires:       %{name} = %{version}-%{release}
%description %{area1_shortname}
This package contains the %{area1_propername} yum repository configuration files
for access to packages needed for initial client configuration.
%package %{area2_shortname}
Summary:        %{company_proper} Spacewalk Yum Repository Files for %{area2_hostname}
Group:          System Environment/Base
License:        GPLv2
Requires:       %{name} = %{version}-%{release}
%description %{area2_shortname}
This package contains the %{area2_propername} yum repository configuration files
for access to packages needed for initial client configuration.
%package %{area3_shortname}
Summary:        %{company_proper} Spacewalk Yum Repository Files for %{area3_hostname}
Group:          System Environment/Base
License:        GPLv2
Requires:       %{name} = %{version}-%{release}
%description %{area3_shortname}
This package contains the %{area3_propername} yum repository configuration files
for access to packages needed for initial client configuration.

%prep
%setup -q  -c -T

# yum repository templates
%{__sed} -e 's/MIRRORSHORTNAME/%{localmirror_shortname}/g' \
         -e 's/MIRRORPROPERNAME/%{localmirror_propername}/g' \
         -e 's/MIRRORHOSTNAME/%{localmirror_hostname}/g' \
         %{SOURCE0} > ./%{localmirror_shortname}-spcw-2.5-setup-el7.repo
# ACTION: duplicate this section for each spacewalk server/proxy in your environment
%{__sed} -e 's/AREASHORTNAME/%{area1_shortname}/g' \
         -e 's/AREAPROPERNAME/%{area1_propername}/g' \
         -e 's/AREAHOSTNAME/%{area1_hostname}/g' \
         %{SOURCE1} > ./%{area1_shortname}-spcw-2.5-setup-el7.repo
%{__sed} -e 's/AREASHORTNAME/%{area2_shortname}/g' \
         -e 's/AREAPROPERNAME/%{area2_propername}/g' \
         -e 's/AREAHOSTNAME/%{area2_hostname}/g' \
         %{SOURCE1} > ./%{area2_shortname}-spcw-2.5-setup-el7.repo
%{__sed} -e 's/AREASHORTNAME/%{area3_shortname}/g' \
         -e 's/AREAPROPERNAME/%{area3_propername}/g' \
         -e 's/AREAHOSTNAME/%{area3_hostname}/g' \
         %{SOURCE1} > ./%{area3_shortname}-spcw-2.5-setup-el7.repo

# repository public keys
mkdir -p ./pubkeys/
%{__install} -Dpm 644 %{SOURCE10} %{SOURCE12} ./pubkeys/
%{__install} -pm 644 %{SOURCE11} ./pubkeys/RPM-GPG-KEY-jpackage

%build

%install
%{__rm} -rf $RPM_BUILD_ROOT

#GPG public key files
%{__mkdir} -p $RPM_BUILD_ROOT%{_sysconfdir}/pki/rpm-gpg/
%{__install} -Dpm 644 ./pubkeys/* $RPM_BUILD_ROOT%{_sysconfdir}/pki/rpm-gpg/

#yum repo files
%{__install} -dm 755 $RPM_BUILD_ROOT%{_sysconfdir}/yum.repos.d
%{__install} -Dpm 644 ./*.repo $RPM_BUILD_ROOT%{_sysconfdir}/yum.repos.d/

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%{_sysconfdir}/pki/rpm-gpg/*

%files %{localmirror_shortname}
%defattr(-,root,root,-)
%config(noreplace) %{_sysconfdir}/yum.repos.d/%{localmirror_shortname}-spcw-2.5-setup-el7.repo

# ACTION: duplicate this section for each spacewalk server/proxy in your environment
%files %{area1_shortname}
%defattr(-,root,root,-)
%config(noreplace) %{_sysconfdir}/yum.repos.d/%{area1_shortname}-spcw-2.5-setup-el7.repo
%files %{area2_shortname}
%defattr(-,root,root,-)
%config(noreplace) %{_sysconfdir}/yum.repos.d/%{area2_shortname}-spcw-2.5-setup-el7.repo
%files %{area3_shortname}
%defattr(-,root,root,-)
%config(noreplace) %{_sysconfdir}/yum.repos.d/%{area3_shortname}-spcw-2.5-setup-el7.repo

%changelog
* Thu Jul 14 2016 Danny Schuh <danny.schuh@gmail.com> - 7-1
- initial build

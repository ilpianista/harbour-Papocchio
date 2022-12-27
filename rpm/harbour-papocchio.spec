# 
# Do NOT Edit the Auto-generated Part!
# Generated by: spectacle version 0.32
# 

Name:       harbour-papocchio

# >> macros
# << macros

%{!?qtc_qmake:%define qtc_qmake %qmake}
%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}
Summary:    Paint using your finger
Version:    1.3.4
Release:    1
Group:      Qt/Qt
License:    GPLv3
URL:        https://scarpino.dev
Source0:    %{name}-%{version}.tar.bz2
Source100:  harbour-papocchio.yaml
Requires:   sailfishsilica-qt5 >= 0.10.9
BuildRequires:  pkgconfig(sailfishapp) >= 1.0.2
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  desktop-file-utils

%description
An application to paint using your finger!

%if "%{?vendor}" == "chum"
PackageName: Papocchio
Type: desktop-application
DeveloperName: Andrea Scarpino
Categories:
 - Graphics
Custom:
  Repo: https://github.com/ilpianista/harbour-Papocchio
Icon: https://raw.githubusercontent.com/ilpianista/harbour-Papocchio/master/icons/harbour-papocchio.svg
Screenshots:
 - https://raw.githubusercontent.com/ilpianista/harbour-Papocchio/master/screenshots/screenshot_1.png
 - https://raw.githubusercontent.com/ilpianista/harbour-Papocchio/master/screenshots/screenshot_2.png
Url:
  Homepage: https://github.com/ilpianista/harbour-Papocchio
  Bugtracker: https://github.com/ilpianista/harbour-Papocchio/issues
  Donation: https://liberapay.com/ilpianista
%endif


%prep
%setup -q -n %{name}-%{version}

# >> setup
# << setup

%build
# >> build pre
# << build pre

%qtc_qmake5 

%qtc_make %{?_smp_mflags}

# >> build post
# << build post

%install
rm -rf %{buildroot}
# >> install pre
# << install pre
%qmake5_install

# >> install post
# << install post

desktop-file-install --delete-original       \
  --dir %{buildroot}%{_datadir}/applications             \
   %{buildroot}%{_datadir}/applications/*.desktop

%files
%defattr(-,root,root,-)
%{_bindir}/%{name}
%{_datadir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/icons/hicolor/*/apps/%{name}.png
# >> files
# << files

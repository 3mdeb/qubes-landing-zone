Name:		landing-zone
Version:	0.3.0
Release:	1%{?dist}
Summary:	An open source implementation of an AMD-V Secure Loader. 

Group:		System
License:	GPL
URL:		https://github.com/TrenchBoot/landing-zone

BuildRequires:	gcc

%description
An open source implementation of an AMD-V Secure Loader. 

%prep
cd %_builddir/
git clone https://github.com/3mdeb/landing-zone.git -b multiboot2

%build
cd %_builddir/landing-zone
make

%install
mkdir -p %buildroot/boot
cp %_builddir/landing-zone/lz_header.bin %buildroot/boot/lz_header

%files
/boot/lz_header

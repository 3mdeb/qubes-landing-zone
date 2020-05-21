# qubes-landing-zone

Qubes component description for TrenchBoot Landing-Zone

## How to build

1. Clone [qubes-builder](https://github.com/QubesOS/qubes-builder)

```
git clone https://github.com/QubesOS/qubes-builder.git
cd qubes-builder
```

2. Download sources used to build Qubes:

```
make get-sources
```

3. Install dependencies:

```
make install-deps
```

4. Clone the qubes-landing-zone into qubes-src directory:

```
git clone https://github.com/3mdeb/qubes-landing-zone.git qubes-src/landing-zone
```

5. Build the landing-zone RPM package:

```
make get-sources -C qubes-src/landing-zone
make verify-sources -C qubes-src/landing-zone
make landing-zone
```

6. The result will be placed as RPM package in:
   `qubes-builder/qubes-src/landing-zone/pkgs/dom0-fc31/x86_64`. It may be
   transferred to Dom0 and installed.

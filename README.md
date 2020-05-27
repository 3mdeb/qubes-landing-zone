# qubes-landing-zone

[![Build Status](https://travis-ci.com/3mdeb/qubes-landing-zone.svg?branch=master)](https://travis-ci.com/3mdeb/qubes-landing-zone)

Qubes component description for TrenchBoot Landing-Zone

## How to build

1. Clone [qubes-builder](https://github.com/QubesOS/qubes-builder)

```
git clone https://github.com/QubesOS/qubes-builder.git
cd qubes-builder
```

2. Use your desired `builder.conf` file from `example-configs` directory.

3. Edit the `builder.conf` by adding:

```
NO_SIGN ?= 1
NO_CHECK ?=

GIT_URL_landing_zone=https://github.com/3mdeb/qubes-landing-zone

...

COMPONENTS = ...
        builder-debian \
        builder-rpm \
        landing-zone
```

4. Download sources used to build Qubes:

```
make get-sources
```

5. Install dependencies:

```
make install-deps
```

6. Build the landing-zone RPM package:

```
make get-sources -C qubes-src/landing-zone
make verify-sources -C qubes-src/landing-zone
make landing-zone
```

7. The result will be placed as RPM package in:
   `qubes-builder/qubes-src/landing-zone/pkgs/dom0-fc31/x86_64`. It may be
   transferred to Dom0 and installed.

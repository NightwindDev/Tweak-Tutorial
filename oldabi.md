# How Do You Create a Tweak?

## What is the old ABI?
The ABI that was used by versions of Xcode 11.7 and older, commonly known as "OldABI," is what was used to compile tweaks prior to iOS 14 releasing. Upon the release of iOS 14 and Xcode 12.0, Apple decided to switch to the new "unstable" arm64e ABI when a binary is compiled for arm64e.

Tweak developers were advised to compile with the old ABI, however. The reason for this was the fact that the new ABI broke support for arm64e (iPhone Xs and newer) on iOS 13, while the old ABI still worked fine. Apple broke support for the old ABI in iOS 14.5 onward.

## The issue with the old ABI on modern iOS
The [Taurine](https://taurine.app) and [XinaA15](https://github.com/NotDarkn/XinaA15) jailbreaks have an embedded version of patches that mitigate the need to recompile tweaks with the new ABI. The [Dopamine](https://ellekit.space/Dopamine) jailbreak does not have an embedded patch. However, it has an additional package called "Legacy arm64e Support" that is able to be installed via the [ElleKit Repo](https://ellekit.space).

On iOS 14.5-14.8.1, the patches needed to support the old ABI are minimal and are implemented on the jailbeak's end. Starting with iOS 15, though, arm64e jailbreaks need a more robust solution to support the old ABI, which causes system instability.

The "Legacy arm64e Support" package has been known to cause general system instability, also increasing the chance of spinlock panics, [explained here](https://github.com/opa334/Dopamine/issues/274#issuecomment-1821038203).

## How do I use the new ABI in my tweaks?
There are several ways to use the new ABI in your tweaks. We'll go through them from most to least desirable. Do note that if you would like to support iOS 13 as well as iOS 15+, you will need to compile with the old ABI for "rootful" builds of your tweak and with the new ABI for "rootless" builds.
### Compiling via macOS
The best way to make sure the tweak works completely with the new ABI is compiling on a macOS machine. The new ABI has not been open sourced yet as of the time of writing (24 November 2023), therefore it can only be used to compile tweaks on macOS.
### Compiling via [GitHub Actions](https://github.com/features/actions)
If you do not have access to a macOS machine but would still like to compile with the new ABI, you can use GitHub Actions to do so. GitHub Actions is freely available to any public repository hosted on GitHub and paid for private repositories.

To get started, make a folder in your tweak directory called `.github` and then a folder called `workflows` inside of that. Within that folder, create a file ending with the `.yml` extension. It can be called anything. For instance, the path for the file could be `.github/workflows/build.yml`. Then, paste the following to the file, graciously provided by [@L1ghtmann](https://github.com/L1ghtmann):
```yml
name: Build CI

on:
  push:
  workflow_dispatch:

jobs:
  build:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@main

      - name: Checkout theos/theos
        uses: actions/checkout@main
        with:
          repository: theos/theos
          ref: master
          submodules: recursive
          path: theos

      - name: Checkout theos/sdks
        uses: actions/checkout@main
        with:
          repository: theos/sdks
          sparse-checkout: iPhoneOS14.5.sdk
          path: theos/sdks

      - name: Build Package
        run: |
          brew install make xz ldid
          export THEOS=theos
          gmake clean package FINALPACKAGE=1
          gmake clean package FINALPACKAGE=1 THEOS_PACKAGE_SCHEME=rootless

      - name: Upload a Build Artifact
        uses: actions/upload-artifact@v3
        with:
          path: packages/*.deb
```
This is a basic template that should work for most simple tweaks. The tweak has dependencies, you will need to install them as well.

After pushing the changes, you may or may not have to manually enable GitHub Actions in your repository.

## Using Allemand(e)
Another method that can be used to avoid relying on the "Legacy arm64e Support" package is using a static patcher on the binary. There are currently two available: [Allemand](https://github.com/evelyneee/Allemand) and [Allemande](https://github.com/p0358/allemande). Allemand supports iOS and macOS, while Allemande is a "port of allemand to C++," which is cross-platform.

- Allemand
  - The compiled binaries for Allemand, as well as the instructions for it, can be found in the [r/jailbreak](https://discord.com/jb) Discord server's `#dopamine` channel. The direct link to the macOS instructions can be found [here](https://discord.com/channels/349243932447604736/688126462066163756/1109535067493122198) and the iOS instructions, [here](https://discord.com/channels/349243932447604736/688126462066163756/1109533605392285836).
  - Note: when using Allemand, you will have to manually unpack and repack the .deb of your tweak and run Allemand on each binary contained within the tweak. More in-depth instructions for macOS can be found [here](https://gist.github.com/NightwindDev/1c05464475b597231e0c6855d959d144) alongside information about "derootifying" tweaks.
- Allemande
  - [p0358](https://github.com/p0358)'s port of Allemand has built-in integration with Theos.
  - You will have to compile Allemande via the instructions found in the GitHub repo's [readme file](https://github.com/p0358/allemande/blob/master/README.md).

Quick note about static patchers: they are not perfect and may not work 100% of the time. In particular, there are issues with function blocks, so things like animation blocks in `UIView` will cause the device to crash.
## Relying on `Legacy arm64e Support`
If all else fails, then you can add a dependency on `Legacy arm64e Support` in your tweak. This is not recommended and should be used as a last resort, because as mentioned previously, the `Legacy arm64e Support` package causes system instability. The proper way to depend on this is:
```
Depends: firmware (<< 15.0) | cy+cpu.arm64v8 | oldabi
```
Note: if you want to support the XinaA15 jailbreak, you will have to remove these dependenices from the "rootful" version of your package and keep them only for rootless.

[Previous Page (Adapting for rootless)](./rootless.md)

[Next Page (`%hookf`)](./hookf.md)
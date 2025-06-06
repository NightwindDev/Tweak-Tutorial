# How Do You Create a Tweak?

## Setting Up The Tweak

1. Ensure that you have [**Theos**](https://theos.dev) set up. The instructions to set up Theos can be found [here](https://theos.dev/docs/installation). Please choose the appropriate operating system in the wiki and install it.

2. Ensure you have some kind of text editor, some good ones being [Visual Studio Code](https://code.visualstudio.com), [Sublime Text](https://www.sublimetext.com), and more! Feel free to use your preferred text editor, however note that **Visual Studio Code** has an **extension** for **Logos**, which can be found [here](https://marketplace.visualstudio.com/items?itemName=tale.logos-vscode).

3. For easier "view-finding," download a flipboard explorer such as FLEXing ([rootful version](https://github.com/NSExceptional/FLEXing/releases/tag/1.2.0)/[rootless version](https://github.com/PoomSmart/FLEXing/releases/tag/1.5.0)).

4. To begin creating a tweak, run the command `$THEOS/bin/nic.pl`. If this does not work, you have probably set up Theos incorrectly. Please go back to step 1 and fix your installation.
      - This should show different options, one of them being `iphone/tweak`. This option will have a number next to it, which you type in to select that option.

      - After that, the terminal will prompt you with `Project Name (required):`. This is asking what you want your tweak to be called. Please type the name that you want to call the tweak in this space.

      - After *that*, the terminal will prompt you with `Package Name [com.yourcompany.testtweak]:`, This is asking what you want the [Bundle ID](https://developer.apple.com/documentation/appstoreconnectapi/bundle_ids) of your tweak to be. Most likely it will be `com.yourname.yourtweakname`. *Note that it cannot contain any uppercase letters.*

      - Next, it will ask you `Author/Maintainer Name [yourname]:`. Please put whatever you want your "developer name" to be if/when you publish the tweak.

      - Furthermore, the terminal will ask you `[iphone/tweak] MobileSubstrate Bundle filter [com.apple.springboard]:`. This is asking what you want to hook into. (Examples: Twitter tweak: `com.atebits.Tweetie2`, Settings tweak: `com.apple.Preferences`, SpringBoard: `com.apple.springboard`). We will hook SpringBoard for our example tweak, so use `com.apple.springboard`.

      - Then, it will ask `[iphone/tweak] List of applications to terminate upon installation (space-separated, '-' for none) [SpringBoard]:`, just press enter for now on this one.

      - After this, Theos will create a folder with the tweak files inside of it.

[Next Page (Exploring The Tweak Files)](./explore_files.md)

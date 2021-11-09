# How Do You Create a Tweak?

Starting out can certainly be a challenge, but if you put your mind to it, you'll be able to grasp the concepts.

## Setting Up The Tweak

1. Assure that you have <a href="https://github.com/theos/theos">**Theos**</a> set up. The instructions to set up Theos can be found <a href="https://github.com/theos/theos/wiki/Installation">here</a>. Please choose the appropriate operating system in the wiki and install it.

2. Assure you have some kind of text editor, some good ones being <a href="https://code.visualstudio.com">Visual Studio Code</a>, <a href="https://www.sublimetext.com">Sublime Text</a>, <a href="https://atom.io">Atom</a>, and more! Feel free to use your preferred text editor, however note that **Visual Studio Code** has an **extension** for **Logos**, which can be found <a href="https://marketplace.visualstudio.com/items?itemName=tale.logos-vscode">here</a>.

3. For easier "view-finding," download a flipboard explorer such as <a href="https://github.com/NSExceptional/FLEXing/releases/tag/1.2.0">FLEXing</a> or <a href="https://DGh0st.github.io/">FLEXall</a>.

4. To begin creating a tweak, run the command `$THEOS/bin/nic.pl`. If this does not work, you have probably set up Theos incorrectly. Please go back to step 1 and fix your installation.
      - This should show different options, one of them being `iphone/tweak`. This option will have a number next to it, which you type in to select that option.

      - After that, the terminal will prompt you with `Project Name (required):`, meaning "what is going to be the name of your tweak?" Please type the name that you want to call the tweak in this space.

      - After *that*, the terminal will prompt you with `Package Name [com.yourcompany.testtweak]:`, meaning "what is going to be the <a href="https://developer.apple.com/documentation/appstoreconnectapi/bundle_ids">Bundle ID</a> of your tweak? Most likely it will be `com.yourname.yourtweakname`.

      - Next, it will ask you `Author/Maintainer Name [yourname]:`. Please put whatever you want your "developer name" to be if/when you publish the tweak.

      - Furthermore, the terminal will ask you `[iphone/tweak] MobileSubstrate Bundle filter [com.apple.springboard]:`. This essentially means "what do you want your tweak to hook?" (Examples: Twitter tweak: `com.atebits.Tweetie2`, Settings tweak: `com.apple.Preferences`, SpringBoard: `com.apple.springboard`). We will hook SpringBoard for our example tweak, so use `com.apple.springboard`.

      - Then, it will ask `[iphone/tweak] List of applications to terminate upon installation (space-separated, '-' for none) [SpringBoard]:`, just press enter for now on this one.

      - After this, Theos will create a folder with the tweak files inside of it.

<a href="https://github.com/NightwindDev/Tweak-Tutorial/blob/main/p1_explore_files.md">Next Page (Exploring The Tweak Files)</a>

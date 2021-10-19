# How Do You Create a Tweak?

1. Assure that you have <a href="https://github.com/theos/theos">**Theos**</a> set up. The instructions to set up Theos can be found <a href="https://github.com/theos/theos/wiki/Installation">here</a>. Please choose the appropriate operating system in the wiki and install it.

2. Assure you have some kind of text editor, some good ones being <a href="https://code.visualstudio.com">Visual Studio Code</a>, <a href="https://www.sublimetext.com">Sublime Text</a>, <a href="https://atom.io">Atom</a>, and more! Feel free to use your preferred text editor, however note that **Visual Studio Code** has an **extension** for **Logos**, which can be found <a href="https://marketplace.visualstudio.com/items?itemName=tale.logos-vscode">here</a>.

3. To begin creating a tweak, run the command `$THEOS/bin/nic.pl`. If this does not work, you have probably set up Theos incorrectly. Please go back to step 1 and fix your installation.
      - This should show different options, one of them being `iphone/tweak`. This option will have a number next to it, which you type in to select that option.
      - After that, the terminal will prompt you with `Project Name (required):`, meaning "what is going to be the name of your tweak?" Please type the name that you want to call the tweak in this space.
      - After *that*, the terminal will promt you with `Package Name [com.yourcompany.testtweak]:`, meaning "what is going to be the <a href="https://developer.apple.com/documentation/appstoreconnectapi/bundle_ids">bundle ID</a> of your tweak?

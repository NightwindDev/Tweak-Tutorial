# How Do You Create a Tweak?

## Let's make a preference bundle!

Tweaks are interesting because there are many, many things you can do. Having preference bundles is important for tweaks, as the user will be able to configure your tweak to their liking.

## How do we use preference bundles?

There is a universal way to make preference bundles for tweaks, although how you utilize them may be different. You could either make respringless preferences or ones that require a respring (easier to make).

## How do we start?

1) Open up your terminal and navigate to your tweak folder.
2) Type in `$THEOS/bin/nic.pl` so we can make a subproject.
3) Choose `iphone/preference_bundle_modern`.
4) Choose the project name for your preference bundle, a good standard by which to name it would be `YourTweak` + `Prefs`, so for example: `ExampleTweakPrefs`.
5) Obviously choose your bundle ID, `com.yourcompany.exampletweakprefs`.
6) Same as in when we were setting up the tweak, enter your `Author/Maintainer Name`.
7) Next, you will see: `[iphone/preference_bundle_modern] Class name prefix (three or more characters unique to this project) [XXX]`.
    - What is this? It is basically the unique prefix for your "classes," so for example, let's say you have a UIViewController and you want it's name to be unique so that when you press the tweak name in the settings app, your tweak shows up.
    - Let's say you choose the class name prefix to be `EXM`, your Root List Controller would be called `EXMRootListController.m`. It is __important__ that this is unique to your tweak.

## What are all these files?

```
.
├── EXMRootListController.h
├── EXMRootListController.m
├── Makefile
├── Resources
│   ├── Info.plist
│   └── Root.plist
└── layout
    └── Library
        └── PreferenceLoader
            └── Preferences
                └── ExampleTweakPrefs.plist
```

This is the file tree of the preference bundle, let's look at each file closely.

- `EXMRootListController.h`
    - This is the headers file, we technically don't _need_ it, although it's useful to clean up our code. It is where all the interfaces, imports, and variables are placed.
- `EXMRootListController.m`
    - This is our view controller file, it is the thing that helps display the `Root.plist` when the tweak page is opened in the settings app.
- `Makefile`
    - This makefile performs the same function as the makefile in the tweak project.
- `Resources` folder
    - This folder is where all the assets and `.plist`s are placed, it will be used a lot.
- `Info.plist`
    - This is the file that holds all the "technical" stuff, you will likely not touch it.
- `Root.plist`
    - This is an important file, it holds the cells that are displayed when you open the tweak page.
- `ExampleTweakPrefs.plist`
    - This is also a file that holds "technical" stuff, you will likely not touch it either.




<a href="https://github.com/NightwindDev/Tweak-Tutorial/blob/main/p4_headers.md">Previous Page (Finding Headers)</a>

<a href="https://github.com/NightwindDev/Tweak-Tutorial/blob/main/p6_prefbundlept2.md">Next Page (Preference Bundles cont.)</a>

# How Do You Create a Tweak?

## Exploring The Tweak Files

Please open your text editor of choice to your tweak folder.

```
.
├── Makefile
├── Tweak.x
├── control
└── testtweak.plist
```

This is what your file structure in the folder should look like. The `.plist` file may have a different name depending on the tweak name you chose, but the rest should be the same. Let's take a deeper dive into what each file is.

## `Makefile`

This file essentially has information about how to build or rebuild the protocol.  `TARGET`, for example, contains the target operating system that you can choose. Another example would be `ARCHS` which have a dozen or so values you can choose from, but you will most likely use `arm64`, (every iPhone before the Xs series and after iOS 6) and `arm64e`, (every iPhone after and including the Xs series).

`ARCHS` would be written like this: `ARCHS = arm64 arm64e`

## `Tweak.x`

This file is the most "important" out of these four. This is where you write all your code. This code will be written in the language called [Objective-C](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html), however you could use [Orion](https://orion.theos.dev) to utilize [Swift](https://developer.apple.com/swift/) instead.

## `control`

This file contains the information about your tweak. Things like the name of the developer, what iOS version it supprorts, etc. Some DPKG managers display bits and pieces of it when the user looks at the tweak depiction.

## `testtweak.plist`

This file contains what the tweak will be hooking/injecting into. This won't be touched much, compared to the other files, but it does exist and is also important.

[Previous Page (Setting Up The Tweak)](./p0_starting_off.md)

[Next Page (Code For The Tweak)](./p2_syntax.md)

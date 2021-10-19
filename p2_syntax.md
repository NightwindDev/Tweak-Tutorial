# How Do You Create a Tweak?

## But how do we actually write code for the tweak?

Great question! Let's begin writing some code! As said previously, we will be writing this code in Objective-C. We will not be using "pure" Objective-C however, we will be using something called <a href="https://iphonedev.wiki/index.php/Logos">Logos</a> which is a "tool" made to make hooking easier.

Let's go step by step.

We will make a tweak to hide the status bar!

First, go to your `tweak.x` file. There will be a huge block of comments made there when the tweak was made by Theos. Feel free to read this, it is actually **_reccomended_** to get a first glance on what the syntax is like.

Will first import UIKit. UIKit is used for the UI in iOS. This can be done like so:
```objc
#import <UIKit/UIKit.h>
```
or like so:
```objc
@import UIKit;
```
This is needed for pretty much all tweaks.

Then we will use the FLEX tweak to find the correct view to hook. How do we get it? Well let's see! ***Make sure you're doing this on the HomeScreen as we are hooking the SpringBoard.***
     - Trigger the FLEX menu (the instructions to this are likely in the tweak description.)
     - Press the `select` button on the FLEX menu.
     - Then press the status bar.
     - After that, press the `views` button. FLEX will automatically scroll down to the selected view.
     - Press the (i) button next to the view.
     - This is where we will find all the properties, ivars, methods, etc. pertaining to the view. In this case, we want to modify the `hidden` property of the view.
     - Find where it says `@property BOOL hidden`, press the (i) button next to it, and then flip the switch. Press done and you should see (or rather not see!) the hidden status bar!

Great! Now how do we write this in code?

[TO DO]


<a href="https://github.com/NightwindDev/Tweak-Tutorial/blob/main/p1_explore_files.md">Previous Page (Exploring The Tweak Files)</a>

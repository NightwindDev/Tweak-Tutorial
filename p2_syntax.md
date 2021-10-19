# How Do You Create a Tweak?

## But how do we actually write code for the tweak?

Great question! Let's begin writing some code! As said previously, we will be writing this code in Objective-C. We will not be using "pure" Objective-C however, we will be using something called <a href="https://iphonedev.wiki/index.php/Logos">Logos</a> which is a "tool" made to make hooking easier.

Let's go step by step.

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

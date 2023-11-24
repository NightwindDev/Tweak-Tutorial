# How Do You Create a Tweak?

## But how do we actually write code for the tweak?

Great question! Let's begin writing some code! As said previously, we will be writing this code in Objective-C. We will not be using "pure" Objective-C however, we will be using something called [Logos](https://theos.dev/docs/logos-syntax) which is a "tool" made to make hooking easier.

Let's go step by step.

We will make a tweak to hide the status bar!

First, go to your `Tweak.x` file. There will be a huge block of comments made there when the tweak was made by Theos. Feel free to read this, it is actually **_recommended_** to get a first glance on what the syntax is like.

We will first import UIKit. UIKit is a framework containing all the basic UI elements you see in an iOS app, such as buttons, switches, sliders, etc. This can be done like so:

```objc
#import <UIKit/UIKit.h>
```

or like so:

```objc
@import UIKit;
```

This is needed for pretty much all tweaks.

Then we will use the FLEX tweak to find the correct view to hook. How do we get it? Well let's see! ***Make sure you're doing this on the HomeScreen as we are hooking the SpringBoard.***

1. Trigger the FLEX menu (the instructions to this are likely in the tweak description.)
2. Press the `select` button on the FLEX menu.
3. Then press the status bar somewhere that there is no text.
4. After that, press the `views` button. FLEX will automatically scroll down to the selected view.
5. Press the (i) button next to the view.
6. This is where we will find all the properties, ivars, methods, etc. pertaining to the view. In this case, we want to modify the `hidden` property of the view.
7. Find where it says `@property BOOL hidden`, press the (i) button next to it, and then flip the switch. Press done and you should see (or rather not see!) the hidden status bar!

Great! Now how do we write this in code?

First, we will find the view we are hooking. In our case, it is called `_UIStatusBarForegroundView`. This view _inherits_ from UIView. You can check what a view *inherits* its properties from in FLEX by clicking on the (i) button next to the view and then looking at the top bar, where it should say `_UIStatusBarForegroundView`, then `UIView`, then `UIResponder`, and then finally `NSObject`. This means that `_UIStatusBarForegroundView` is inheriting its properties from `UIView` which is inheriting them from `UIResponder`, and so forth. So say UIView has a "hidden" property... `_UIStatusBarForegroundView` would also have a "hidden" property because it inherits from UIView.

UIKit only recognizes simple classes such as UIView, UIViewController, etc. so we will have to "interface" the view that we are hooking. This can be done like so:

```objc
@interface _UIStatusBarForegroundView : UIView // _UIStatusBarForegroundView inherits from UIView
@end
```

Alright, good! We've learned how to interface a view! Now it's time to hook it!

Logos provides an easy way to hook, it's as simple as... `%hook`!
Basically, this is what we do.

```objc
%hook _UIStatusBarForegroundView
%end
```

`%end` is used to _end_ the hook, so you could add a new one.

Now we need to override a method which is _called_ by the view. Basically, a method is a "function" which gets called when a certain condition is met. So let's take as an example `didMoveToWindow`. As seen on its [documentation page](https://developer.apple.com/documentation/uikit/uiview/1622527-didmovetowindow?language=objc), the view is called when its "window object" changes.

How do we override it though? Well, it is easy to do. On the its documentation page, you can copy the code seen. It is the code for the method.

```objc
-(void)didMoveToWindow;
```

We need to change its function though, and it can be done by changing the semi-colon (;) to brackets, and then adding your new code there. Let's just say we want to print "Hello world!" to the console, for this we would use a function called `NSLog`. This can be done like so:

```objc
-(void)didMoveToWindow {
    NSLog(@"Hello world!");
}
```

If you need to initiate (call) the code that was written there originally, you can use `%orig;` to do that. So, looking at our previous example, we could do:

```objc
-(void)didMoveToWindow {
    %orig;
    NSLog(@"Hello world!");
}
```

You can put `%orig;` before OR after your code, or not put it at all. If you want the original code to run AFTER your code, then put the `%orig;` AFTER your code, if you want it BEFORE, then BEFORE.

Okay, but how do we hide it? Well, we know that `hidden` is a property of UIView, which `_UIStatusBarForegroundView` inherits from, so we could do: `self.hidden = YES;` (Note: you do not have to use YES, you could use true instead, or even 1 [true] and 0 [false]). `self` is referring to the object that we are hooking. So if we were to combine all this together, we would have something like this:

```objc
#import <UIKit/UIKit.h>

@interface _UIStatusBarForegroundView : UIView // _UIStatusBarForegroundView inherits from UIView
@end

%hook _UIStatusBarForegroundView

-(void)didMoveToWindow {
    %orig;
    self.hidden = YES;
}

%end

```

## Compiling the tweak

There are two commands to compile the tweak. The command to compile for rootless is:

```bash
make package THEOS_PACKAGE_SCHEME=rootless
```

And the command to compile for rootful (unofficial terminology for a non-rootless jailbreak) is:

```bash
make package
```

#### Quick note
These commands will output a `.deb` file of your tweak in `./Packages` directory, without automatically installing the `.deb` onto the device. If you wish to install the `.deb` on device, `make do` is the better choice. It is essentially a shorter version of `make package install`, which makes the `.deb` and then installs it to the device using SSH.

Here is how to set up the automatic installation of the `.deb` via SSH over Wi-Fi onto the device:

- Install `openssh` on device
- Add the root password on device if it was not already added
- Find your local ip address in `Settings > Wi-Fi > <current network name> (i) > IP Address`
- In your compile command, add an argument at the end `THEOS_DEVICE_IP=<your ip>`

In order to not have to input your password every time, do this in your desktop terminal:
```bash
ssh-keygen
ssh-copy-id root@<your ip>
```

If you would like to use SSH over USB instead, there is a [page on The Apple Wiki](https://theapplewiki.com/wiki/Dev:SSH_Over_USB) with information regarding that.

[Previous Page (Exploring The Tweak Files)](./explore_files.md)

[Next Page (Delving Into Views)](./views.md)

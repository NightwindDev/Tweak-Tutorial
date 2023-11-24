# How Do You Create a Tweak?

## What is `layoutSubviews`?

`- (void)layoutSubviews;` is a method that exists in classes inherited from `UIView`.

`layoutSubviews`, just like other methods gets called at some point in the lifecycle of a class. What sets `layoutSubviews` apart from others, though, is that it gets called many times, and that poses some risks when using it to override certain things in a class.

## Let's See How it Gets Called

The code chunk below will log `LAYOUT_SUBVIEWS CALLED` when the method is called.

```objc
@import UIKit;

@interface SBIconImageView : UIView
@end

%hook SBIconImageView

- (void)layoutSubviews {
    %orig;
    NSLog(@"LAYOUT_SUBVIEWS CALLED");
}

%end
```

Result of this:

![Screenshot of Console Showing NSLog of layoutSubviews](https://i.imgur.com/MkSwLHO.png)

**1,210 messages in 2 minutes!** If one were to use `addSubview` in `layoutSubviews`, the result will likely be a memory leak or worse because there would be too many views on the screen at once and that would cause freezes, crashes, etc.

If possible, avoid it at all costs and use different methods instead.

## Personal Experiences

> "I remember once I was writing April v1 and completely broke the lock screen and everything was slow and laggy. Learned it the hard way. Never again." \- **[cstanze](https://github.com/cstanze)**

[Previous Page (`MSHookIvar`)](./mshookivar.md)

[Next Page (FLEX Explained)](./flex_explained.md)

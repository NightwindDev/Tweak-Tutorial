# How Do You Create a Tweak?

## Challenge 1

Convert this piece of Substrate code to Logos.

```objc
#import <UIKit/UIKit.h>
#import <substrate.h>

@interface SBIconImageView : UIView
@end

@interface SBHomeScreenBackdropView : UIView
@end

void orig_SBIconImageView_didMoveToWindow(SBIconImageView *self, SEL _cmd);

void new_SBIconImageView_didMoveToWindow(SBIconImageView *self, SEL _cmd) {
    self.alpha = 0.5;
    orig_didMoveToWindow(self, _cmd);
}

void orig_SBHomeScreenBackdropView_didMoveToSuperview(SBHomeScreenBackdropView *self, SEL _cmd);

void new_SBHomeScreenBackdropView_didMoveToSuperview(SBHomeScreenBackdropView *self, SEL _cmd) {
    self.hidden = true;
    orig_SBHomeScreenBackdropView_didMoveToSuperview(self, _cmd);
}

__attribute__((constructor)) static void initialize() {
    MSHookMessageEx(
        NSClassFromString(@"SBIconImageView"),
        @selector(didMoveToWindow),
        (IMP) &new_SBIconImageView_didMoveToWindow,
        (IMP *) &orig_SBIconImageView_didMoveToWindow
    );
    MSHookMessageEx(
        NSClassFromString(@"SBHomeScreenBackdropView"),
        @selector(didMoveToSuperview),
        (IMP) &new_SBHomeScreenBackdropView_didMoveToSuperview,
        (IMP *) &orig_SBHomeScreenBackdropView_didMoveToSuperview
    );
}
```

## // TODO: Challenge 2


#### Solutions to the challenges can be found <a href="https://github.com/NightwindDev/Tweak-Tutorial/tree/main/Solutions">here</a>.

[Previous Page (Building Tweaks Without Logos)](./p13_substratetweaks.md)

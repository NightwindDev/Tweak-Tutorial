# How Do You Create a Tweak?

## Why?

Logos is great to use, however sometimes there are scenarios when using no Logos (or just Substrate-hooking) is better to use.

## Difference between Logos and Substrate

* `%hook` - This specific syntax does not exist without Logos, although there is an equivalent: `MSHookMessageEx`.
* `%hookf` - This specific syntax (to hook C functions) does not exist without Logos either, it's equivalent is `MSHookFunction`.
* `%ctor` - This specific syntax again does not exist in Substrate, however its equivalant is `__attribute__((constructor))`.
* `%dtor` - This specific syntax does not exist in Substrate, its equivalent is `__attribute__ ((destructor))`.
* `%init` - It's equivalent in Substrate is a group of `MSHook` calls.
* `%c` - This is somewhat different from its **Objective-C** syntax, but it essentially performs the same function. It's "equivalent" is `objc_getClass` or `NSClassFromString`.
* `%orig` - This does not have an equivalent in Substrate, it is used when utilizing `MSHookMessageEx` and `MSHookFunction` to "exchange" functions.

More information is available here: https://iphonedev.wiki/index.php/Logos

## Converting from Logos to Substrate

Let's say we have some easy tweak to set a view's opacity to 50% written in Logos.

```objc
#import <UIKit/UIKit.h>

@interface SomeView : UIView
@end

%hook SomeView

-(void)didMoveToSuperview {
  self.alpha = 0.5;
  %orig;
}

%end
```

Firstly we would have to add an import for substrate.

```objc
#import <UIKit/UIKit.h>
#import <substrate.h>

@interface SomeView : UIView
@end

%hook SomeView

-(void)didMoveToSuperview {
  self.alpha = 0.5;
  %orig;
}

%end
```

Then we will add the equivalent of a `%ctor`, a.k.a. `__attribute__((constructor))` at the bottom.

```objc
#import <UIKit/UIKit.h>
#import <substrate.h>

@interface SomeView : UIView
@end

%hook SomeView

-(void)didMoveToSuperview {
  self.alpha = 0.5;
  %orig;
}

%end

__attribute__((constructor)) static void initialize() {

}
```

Then we would convert the `%hook` and `%orig` to `MSHookMessageEx`.

```objc
#import <UIKit/UIKit.h>
#import <substrate.h>

@interface SomeView : UIView
@end

-(void)didMoveToSuperview {
  self.alpha = 0.50;
}

__attribute__((constructor)) static void initialize() {
    MSHookMessageEx(
      NSClassFromString(@"SomeView"), // this is what we're hooking
                        @selector(didMoveToSuperview), // this is the method we're modifying
                        (IMP) // shortened version of "implementation"
                        &override_didMoveToSuperview, // this is the name of the new function of which we would swap the implementations with didMoveToSuperview. It could be named anything, although including the original name in there somewhere would be useful. 
                        (IMP *) // again, shortened version of "implementation"
                        &orig_didMoveToSuperview // original implentation of the function, again can be named anything
    );
}
```

Then finally, we would have to convert the function to the "Substrate-way" of Functions.

```objc
#import <UIKit/UIKit.h>
#import <substrate.h>

@interface SomeView : UIView
@end

void (*orig_didMoveToSuperview)(SomeView *self, SEL _cmd);

void override_didMoveToSuperview(SomeView *self, SEL _cmd) {
    self.alpha = 0.50;

    orig_didMoveToSuperview(self, _cmd);
}

__attribute__((constructor)) static void initialize() {
    MSHookMessageEx(NSClassFromString(@"SomeView"), @selector(didMoveToSuperview), (IMP)&override_didMoveToSuperview, (IMP *) &orig_didMoveToSuperview);
}

```

## What are the parameters in the functions?

* `self` - The thing or object that the function is called on, same thing as using `self` in Logos.
* `SEL _cmd` - The selector (or function, the real name for it is selector) that we are hooking.

Normal method arguments are passed after this, so for example:

```objc
// let's say we're hooking _UIBarBackground (just a random class)

-(void)setBackgroundAlpha:(CGFloat)alpha;

// would become

void setBackgroundColor(_UIBarBackground *self, SEL _cmd, CGFloat alpha);
```

This is definitely not an all-inclusive overview of Substrate-hooking, but it is a great starting place.

More information about it can be found <a href="https://iphonedev.wiki/index.php/Cydia_Substrate">here</a> and <a href="http://www.cydiasubstrate.com/api/c/MSHookMessageEx/">here</a>.



<a href="https://github.com/NightwindDev/Tweak-Tutorial/blob/main/p6_prefbundlept2.md">Previous Page (Preference Bundles cont.)</a>

<a href="https://github.com/NightwindDev/Tweak-Tutorial/blob/main/p8_challenges.md">Next Page (Challenges)</a>

# How Do You Create a Tweak?

## Why?

* Logos is great to use, however sometimes there are scenarios when using no Logos (or just Substrate-hooking) is better to use.

## A bit of history

* Did you know that after all you're writing "Substrate" tweaks all the time? "But how? I literally use Logos syntax". That's true, but Theos does not. If you have stared at the theos compilation process before for whatever reason while waiting for it to compile, you may have noticed that it starts with `==> Preprocessing Tweak.x…`, this is because Logos is exactly that. A preprocessor written in Perl to make Objective-C hooking feel easier and snappier. *But what is Logos actually doing?* Well, if you dig into the folder theos generates after the preprocessing is done (.theos/), you'll see that's it's just a wrapper for the MobileSubstrate API, the one Saurik (the creator of Cydia) made a looong time ago to make it possible to create tweaks in a safer way than the original, unsafe one, back then (called swizzling). It's very interesting actually, since you're swapping methods' implementations at runtime, basically hijacking the original one and replacing it with your own. More information about this will be linked at the end. <br>
The Theos team made quite an impressive job so that you don't have to write usually "verbose" code and the burden is taken out of you. "But is writing tweaks with the MobileSubstrate API that hard?" No actually, not at all. However, there are some concepts you need to understand first, and as mentioned above, benefits will arise by writing tweaks this way.

# Benefits

- "What are all of these 'benefits' you keep mentioning?"

* The preprocessing before compiling is no longer needed so it's skipped, thus speeding noticeably the compilation process, specially for larger projects.

* You'll have native syntax highlighting for .m (Objective-C) files in almost all editors without the need to install additional plugins, since it's a native language, as well as the editor's native vanilla autocompletion.

* By default, all Logos hooks are initialized in a constructor which you can either create or not, you may be familiarized with this if you ever wrote a `%ctor {}` block. However, with MobileSubstrate, you can *control* where and when your hooks are initialized. Useful e.g if you need to load your tweak before another tweak and/or process is loaded.

* You can have almost a native xcode like autocompletion if you wanted to. "Really?" Yes, really. Theos has a "secret" command named `make commands` that will automatically generate a `compile_commands.json` file which will do all the magic as long as you have `clangd` with LSP (Language Server Protocol) installed, which is what enables autocompletion for a specific language. There's support for C, C++, Objective-C and Swift files.
For instructions on how to install this for your editor please go [here](https://github.com/apple/sourcekit-lsp). <br>
Cheers to Kabir for making this (Theos maintainer and creator of [Orion](https://github.com/theos/orion)). At the time of writing this (Feb. 11 2022), it still doesn't work for Logos files, hence why this is a major advantage if not the "best", of writing Substrate tweaks.


## Preparation

* Since we will not be using Logos at all, we will rename the `Tweak.xm` file to `Tweak.m`. The `Tweak.xm` in the Makefile also needs to be renamed to `Tweak.m` so the file can be compiled properly.

## Differences between Logos and Substrate

* All of the keywords you see below, preeceded by the `%` symbol are exclusive to Logos, which are all wrappers for different parts of the MobileSubstrate API.

* `%hook` - Wrapper for `MSHookMessageEx`.
* `%new` - Wrapper for `class_addMethod`.
* `%property`- Wrapper for [a powerful Objective-C 2.0 runtime feature: associated objects](https://nshipster.com/associated-objects/).
* `%hookf` - a wrapper for `MSHookFunction`. (Used to hook C functions).
* `%ctor` - wrapper for `__attribute__((constructor))`.
* `%dtor` - wrapper for `__attribute__((destructor))`.
* `%init` - It's equivalent in Substrate is a group of `MSHook` calls.
* `%c` - very useful wrapper for `objc_getClass()`, however there's also `NSClassFromString()`. They are basically the same, but the latter one is more "Objective-C friendly". If you use it.. just make sure to spell the class name correctly heh.
* `%orig` - This does not have an exact equivalent in Substrate. To achieve the effect of `%orig` a little bit of Objective-C runtime magic is needed, with the help of the MobileSubstrate API. It'll be explained in the examples below.

* If you want to know more about the constructor and destructor attributes, read through [here](https://stackoverflow.com/questions/2053029/how-exactly-does-attribute-constructor-work) and [here](https://www.tutorialspoint.com/attribute-constructor-and-attribute-destructor-syntaxes-in-c-in-tutorials-point)

* More information about Logos is also available [here](https://iphonedev.wiki/index.php/Logos)

## Converting from Logos to Substrate

Let's say we have some easy tweak to set a view's opacity to 50%, written in Logos.

```objc
@import UIKit;

@interface SomeView : UIView
@end

%hook SomeView

-(void)didMoveToSuperview {
  self.alpha = 0.5;
  %orig;
}

%end
```

First we need to import the Substrate framework.

```objc
@import UIKit;
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

Then we will add the wrapper for `%ctor`, a.k.a. `__attribute__((constructor))` at the bottom.

You *have* to add that attribute before you create the initializing C function, so that it'll act as an initializer for all the `MSHookMessageEx` messages you pass there.

```objc
@import UIKit;
#import <substrate.h>

@interface SomeView : UIView
@end

%hook SomeView

- (void)didMoveToSuperview {
  self.alpha = 0.5;
  %orig;
}

%end

__attribute__((constructor)) static void initialize() {

}
```

Then we would convert the `%hook` wrapper to `MSHookMessageEx`.

```objc
@import UIKit;
#import <substrate.h>

@interface SomeView : UIView
@end

%hook SomeView

- (void)didMoveToSuperview {
  self.alpha = 0.5;
  %orig;
}

%end

__attribute__((constructor)) static void initialize() {
    MSHookMessageEx(
      NSClassFromString(@"SomeView"),
                        @selector(didMoveToSuperview),
                        (IMP) &override_didMoveToSuperview,
                        (IMP *) &orig_didMoveToSuperview
    );
}
```

Finally, we would have to "convert" the Objective-C method we are hooking to the C function that every Objective-C method gets "translated" to.

```objc
@import UIKit;
#import <substrate.h>

@interface SomeView : UIView
@end

static void (*orig_didMoveToSuperview)(SomeView *self, SEL _cmd);

static void override_didMoveToSuperview(SomeView *self, SEL _cmd) {
    self.alpha = 0.50;
    orig_didMoveToSuperview(self, _cmd);
}

__attribute__((constructor)) static void initialize() {
  MSHookMessageEx(
    NSClassFromString(@"SomeView"),
    @selector(didMoveToSuperview),
    (IMP) &override_didMoveToSuperview,
    (IMP *) &orig_didMoveToSuperview
  );
}
```

## What is going on here?

* First of all, we create two C functions which take two parameters, a pointer to `self`, so you can use it in the functions just like you would in Logos tweaks to refer to the current object, and a `SEL` variable (shorthand for selector) which can be used if you are passing several `MSHookMessageEx`'s messages with the same C function for different selectors, so `_cmd` can be used to differentiate.

## "What about the MSHookMessageEx function?"

* That one takes four parameters, and the implementation of it, quoting from Saurik's page, looks like this:

```c
void MSHookMessageEx(Class _class, SEL message, IMP hook, IMP *old);
```

- A `Class` object which is an Objective-C class in which a message will be passed to, could also be a metaclass if you were to hook a class method, for which you would use `objc_getMetaClass`.

- A `SEL` variable which will point to an Objective-C selector with the message that'll be passed.

- An `IMP` variable with a compatible replacement for the implementation of the message being passed to.

- An `IMP` variable which is a function to a function pointer that will be filled in with a stub which may be used to call the original implementation. This can be `NULL` if there are no intentions of calling it. PLEASE notice, you're NOT calling `%orig;` here, this is just a variable which may be used if you wish to, but if you don't, it's better to pass `NULL` to avoid redundancies.

```objc
// let's say we're hooking SBDockView's method:

- (void)setBackgroundAlpha:(CGFloat)alpha;

// it would "become"

void setBackgroundColor(SBDockView *self, SEL _cmd, CGFloat alpha);
```
This is definitely not an all-inclusive overview of Substrate-hooking, but it is a great starting place.

More information about it can be found <a href="https://iphonedev.wiki/index.php/Cydia_Substrate">here</a> and <a href="http://www.cydiasubstrate.com/api/c/MSHookMessageEx/">here</a>, as well as [here for method swizzling](https://nshipster.com/method-swizzling/)

<a href="https://github.com/NightwindDev/Tweak-Tutorial/blob/main/p6_prefbundlept2.md">Previous Page (Preference Bundles cont.)</a>

<a href="https://github.com/NightwindDev/Tweak-Tutorial/blob/main/p8_challenges.md">Next Page (Challenges)</a>


// TODO: <br>
// Explain the %subclass wrapper <br>
// Maybe something else I'm forgetting, idk <br>
// This comments should be removed before this repo being public <br>

* File co-authored with [Luki120](https://github.com/Luki120)

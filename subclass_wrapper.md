# How Do You Create a Tweak?

## Demystifying the %subclass wrapper from Logos

* Logos has an underrated wrapper known as `%subclass`.

* In a nutshell, what it does is it creates and registers a custom class at runtime, to which you can add methods and properties (ivars are not yet supported).

## How is this useful?

* It allows you to create view code and move it out of the main `Tweak.x` file to avoid clutter, allowing you to write your view code somewhere else while keeping the main file clean only with hooks. Bear in mind, splitting Logos files will not be covered in this part since the code is small, but it's totally possible, take a look [here](https://theos.dev/docs/logos-hook-splitting) under the section 'Splitting Logos Hooking Code Across Multiple Files'.

* It's good practice not to pollute UIKit classes' methods, such as `- (id)init;` or `- (void)viewDidLoad;`, so this is a good way to achieve that.

* Custom subclasses allow for more control over the views you want to create, so this approach will also help with that.

## How do we use it?

* Alright, so start by creating a new project in theos, select the tweak option, and after finishing the setup configuration, create a new `Tweak.h` file, in which we'll be placing interfaces and relevant imports to keep the main file even cleaner.

It'll look like this:

```objc
// Tweak.h

@import UIKit;


@interface CustomBlurView : UIView
- (void)setupViews;
@end

@interface SBHomeScreenViewController : UIViewController
@end

@interface _UIBackdropViewSettings : NSObject
+ (id)settingsForStyle:(NSInteger)arg1;
@end


@interface _UIBackdropView : UIView
@property (assign, nonatomic) BOOL blurRadiusSetOnce;
@property (nonatomic, copy) NSString *_blurQuality;
- (id)initWithSettings:(id)arg1;
- (id)initWithFrame:(CGRect)arg1 autosizesToFitSuperview:(BOOL)arg2 settings:(id)arg3;
@end
```

## What's going on here?

* First we need to import the UIKit framework, because we'll be using UIKit components, such as `UIView`.

* In order to create a subclass *and* keep the compiler happy, we'll make an interface for our class. The tweak itself will be a nice semi gaussian blur covering the HomeScreen, behind the icons, so we want to inherit from `UIView`.

* We declare the interface for the main SpringBoard's view controller class in the HomeScreen (`SBHomeScreenViewController`) so we can hook it and still keep the compiler happy.

* Finally, we add the two interfaces needed for the type of blur we'll be using. Sadly, Apple decided to keep this blur, called `_UIBackdropView`, private, which means we need to make the interfaces visible again so the compiler can see them and stay happy. The `_` character indicates that the class is private. It's common practice in Objective-C to prefix your classes, ivars, methods, etc with an underscore if you want to indicate that they should be private.

Then, in the main `Tweak.x` file, add this:

```objc
#import "Tweak.h"

%subclass CustomBlurView : UIView

- (id)init {

    self = %orig;
    [self setupViews];
    return self;

}

%new

- (void)setupViews {

    self.translatesAutoresizingMaskIntoConstraints = NO;

    _UIBackdropViewSettings *settings = [_UIBackdropViewSettings settingsForStyle:2];

    _UIBackdropView *blurView = [[_UIBackdropView alloc] initWithFrame:CGRectZero autosizesToFitSuperview:YES settings:settings];
    blurView.alpha = 0.85;
    blurView._blurQuality = @"high";
    blurView.blurRadiusSetOnce = NO;
    [self addSubview: blurView];

}

%end

%hook SBHomeScreenViewController

- (void)viewDidLoad {

    %orig;

    CustomBlurView *customBlurView = [%c(CustomBlurView) new];
    [self.viewIfLoaded insertSubview: customBlurView atIndex: 0];

    [customBlurView.topAnchor constraintEqualToAnchor: self.viewIfLoaded.topAnchor].active = YES;
    [customBlurView.bottomAnchor constraintEqualToAnchor: self.viewIfLoaded.bottomAnchor].active = YES;
    [customBlurView.leadingAnchor constraintEqualToAnchor: self.viewIfLoaded.leadingAnchor].active = YES;
    [customBlurView.trailingAnchor constraintEqualToAnchor: self.viewIfLoaded.trailingAnchor].active = YES;

}

%end
```

## Wait hold on, not so fast

1. We begin importing the `Tweak.h` file where we placed all the necessary interfaces so we can hook properly and be friends with the compiler.

2. We override the `- (id)init;` method, which is an already *existing* method in `UIView` classes, so it'll be called automatically by UIKit once our class gets instantiated.

3. Remember how I mentioned earlier how we shouldn't pollute UIKit classes' existing methods? We'll put that into practice right away. We create a new method of type `void` which returns nothing called `setupViews`, we just need to implement our view there. Notice how we specify the `%new` directive before implementing it, we *have* to let Logos know this will be a new method we want to add to the class, (in a nutshell, it'll also be added at runtime). Otherwise your code there will never work, and if you try to call it, your tweak will crash. Now, we just told Logos this method exists, but now we need to tell UIKit as well so it can be useful. In order to do that we'll call it in `ìnit` with this syntax `[self setupViews];`, so when `init` gets called, our new method gets called as well and executes the code we want, which will be the blur view we'll create.

4. It makes sense that we would want our blur view to cover the whole screen. An easy & effective way of doing this is with AutoLayout. So we tell UIKit we don't want the view to create an autoresizing mask automatically, we'll implement the constraints ourselves for better control, so we have to override the `translatesAutoresizingMaskIntoConstraints` property to false, aka `NO` in a more friendly Objective-C way.

5. Now, our `CustomBlurView` class will act as a *container* view for our blur view, so our view *itself* it's the one that needs to be constrained, hence why we use `self` when overriding the `translatesAutoresizingMaskIntoConstraints` property. If you pay attention at the initializer method of the blur view Apple made for us, you'll see one of the parameters is named `autosizesToFitSuperview:`, which takes a `BOOL` value, so one could specify anything in order to achieve the desired behavior. If we set it to `YES` that's it, the job is done. Since in this case the superview is our custom view class, and the superview of the view in the end it's the HomeScreen's main view controller's view class, it'll *automatically fit the superview*, like the parameter says, so it'll just cover the whole screen. No need at all to set a frame or constraints, so really nice from Apple regarding that.

6. We create the blur, set some nice properties such as the `alpha`, `blurQuality` & `blurRadiusSetOnce` and finally we add this blur to our newly created class. If you want to dive deeper into this class and see what it can do and play around with it's features, look [here](https://iphonedev.wiki/index.php/UIBackdropView).

7. Finally, after already isolating all of the view code we just created, now we can move on to the hooking part. In order to get a blur view in the HomeScreen behind the icons, we need to hook `- (void)viewDidLoad;` method in `SBHomeScreenViewController`, as already mentioned, the main SpringBoard's HomeScreen class. `viewDidLoad` is always a good choice because it's guaranteed to be called in a `UIViewController` class after the view has loaded, so it's pretty common to add custom code there to add additional setup.

8. We call the original implementation with `%orig;` since we don't want to break or cause unwanted behavior with the code Apple may have added there. Right after that, we create a new local variable of our `CustomBlurView` class type and we instantiate it by calling `new` on it, basically the same thing as `alloc` + `ìnit`. Notice how we need to wrap `CustomBlurView` with the Logos `%c()` directive. This is because well, since the class will be created at runtime, the compiler *has no idea* this class exists, so by doing this we'll keep him happy. If you remove it, you'll see what kind of error you get.

9. We add our custom view containing the blur to the `view` property from the `SBHomeScreenViewController` class. Notice two things here, first, we use a different method to add the subview, it's not the regular `addSubview` but `ìnsertSubview:atIndex:`. By passing index 0, we make sure the view will be *behind* the icons, otherwise the blur will be covering them. The other one is that instead of adding the view to the regular `view` property of the view controller, we add it to `viewIfLoaded`, it's essentially the same thing, but the latter will make sure the view has *loaded* first before our code gets called. Just a basic safety check.

10. Finally, we set four constraints: top, bottom, leading & trailing. This will make sure our view stretches and gets pinned to all edges and fill the whole screen. If you've reached to this part, congratulations, you've just learned how to use the `%subclass` wrapper for Logos and how it can be useful. Do notice that this same thing can be done as well without Logos with a regular `@interface` + `@implementation` syntax type, but if this is your thing, then go for it.

* Final result ↓, look how clean this blur looks:

![Result](https://raw.githubusercontent.com/Luki120/luki120.github.io/master/assets/Misc/Result.png)

* This blur is available as one of the types to choose in the tweak [Amēlija](https://repo.twickd.com/get/me.luki.amelija) if you're interested.

[Previous Page (`%hookf`)](./hookf.md)

[Next Page (Substrate Tweaks)](./substrate_tweaks.md)

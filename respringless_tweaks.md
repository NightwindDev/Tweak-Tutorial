# How do you create a respringless tweak?

* What we'll make is a simple tweak that adds a blur to the lock screen, with the option to change the its alpha/intensity on the fly. How can this happen without a respring? The Settings app will need to communicate with SpringBoard to notify that the blur value has been changed, so that it can refresh the UI. The `NSNotificationCenter` Foundation API makes that really straightforward.
You can explore the `NSNotificationCenter` API's documentation [here](https://developer.apple.com/documentation/foundation/nsnotificationcenter)

## Tweak

Open your terminal and create a tweak project, your `Tweak.x` should look like this:

```objc
#import "Tweak.h"


static CGFloat blurIntensity = 0.85f;

static void loadPrefs(void) {

    NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:@"com.example.respringlesstweakprefs"];
    blurIntensity = [prefs objectForKey:@"blurIntensity"] ? [prefs floatForKey:@"blurIntensity"] : 0.85;

}

%hook CSCoverSheetViewController

%property (nonatomic, strong) _UIBackdropView *blurView;

%new

- (void)setupBlur {

    _UIBackdropViewSettings *settings = [_UIBackdropViewSettings settingsForStyle:2];

    if(!self.blurView) {
        self.blurView = [[_UIBackdropView alloc] initWithFrame:CGRectZero autosizesToFitSuperview:YES settings:settings];
        self.blurView.alpha = blurIntensity;
        [self.view insertSubview:self.blurView atIndex:0];
    }
}

%new

- (void)updateBlurIntensity {

    loadPrefs();
    self.blurView.alpha = blurIntensity;

}

- (void)viewDidLoad {

    %orig;
    [self setupBlur];

    [NSDistributedNotificationCenter.defaultCenter addObserver:self selector:@selector(updateBlurIntensity) name:@"com.example.respringlesstweakprefs/DidUpdateBlurIntensityNotification" object: nil];

}

%end

%ctor {
    loadPrefs();
}
```

Then your `Tweak.h` should have:

```objc
@import UIKit;


@interface _UIBackdropViewSettings : NSObject
+ (id)settingsForStyle:(NSInteger)style;
@end


@interface _UIBackdropView : UIView
- (id)initWithFrame:(CGRect)frame autosizesToFitSuperview:(BOOL)autosizes settings:(_UIBackdropViewSettings *)settings;
@end


@interface CSCoverSheetViewController: UIViewController
@property (nonatomic, strong) _UIBackdropView *blurView;
- (void)setupBlur;
@end

@interface NSDistributedNotificationCenter: NSNotificationCenter
@end
```

## Explanation

* First we create the `void loadPrefs(void)` function that will contain our prefs, adding the `CGFloat` key for the blur intensity.

* We hook `- (void)viewDidLoad` from `CSCoverSheetViewController` where we call the original implementation and our custom method `- (void)setupBlur` where we create a `_UIBackdropView` blur with custom settings, nothing crazy going on there.
Finally the most important part: we create a notification observer by calling `addObserver:selector:name:object:` on `NSDistributedNotificationCenter`. We're using the distributed variant because we need to communicate between two different processes (Preferences & SpringBoard). This observer, `CSCoverSheetViewController` will be listening to notifications with the name of `com.example.respringlesstweakprefs/DidUpdateBlurIntensityNotification`, when one gets send, it'll call `updateBlurIntensity`, which will update the `alpha` value accordingly & reflect it on the UI.

Now we have to actually make the preferences, so create a preference bundle project, your root view controller should look like this:

```objc

#import "RTRootVC.h"

@implementation RTRootVC

- (NSArray *)specifiers {

    if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
    return _specifiers;

}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {

    NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:@"com.example.respringlesstweakprefs"];
    [prefs setObject:value forKey:specifier.properties[@"key"]];

    [super setPreferenceValue:value specifier:specifier];

    if(![specifier.properties[@"key"] isEqualToString: @"blurIntensity"]) return;
    [NSDistributedNotificationCenter.defaultCenter postNotificationName:@"com.example.respringlesstweakprefs/DidUpdateBlurIntensityNotification" object:nil];

}

@end
```

Then your `RTRootVC.h`:

```objc
@import Preferences.PSListController;
@import Preferences.PSSpecifier;

@interface RTRootVC : PSListController
@end

@interface NSDistributedNotificationCenter : NSNotificationCenter
@end
```

* The logic is simple. We implement `- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier` where we create an instance of `NSUserDefaults` with our suite name and set the float value for the given key, to finally post a notification when the slider value is modified, which in turn will be received by `CSCoverSheetViewController` which will update the UI accordingly.

* That's how a respringless tweak works, in this case every time you update the slider in the prefs panel, the method we implemented gets called which posts the notification, the observer listening for it receives it and calls the designated method. Now you have succesfully created your first respringless tweak!

* If you want to try the project yourself it's available [here](./Projects/Respringless/)

* Here's how the blur looks ↓

<img src="/Assets/RespringlessTweakBlur.png" width="300">

[Previous Page (Substrate Tweaks)](./substrate_tweaks.md)

[Next Page (Crashlogs)](./crashlogs.md)

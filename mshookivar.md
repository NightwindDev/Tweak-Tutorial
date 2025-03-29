# How Do You Create a Tweak?

## What is `MSHookIvar`?

MSHookIvar is a function present in the Cydia Substrate API, used to obtain instance variables (ivars) from objects. It can only be used in `.xm` files, so if it is needed to be used, the file should be renamed to have a `.xm` extension.

## What is its syntax?

```objc
MSHookIvar<type>(object, name_of_ivar);
```

* `type` - This is the type of the ivar, so if the ivar for example is a UIView, then `UIView *` would be put there.
* `object` - This is where the ivar is located, so for example it could be `self` or an instance of a class.
* `name_of_ivar` - This is obviously the name of the ivar, it has to be written as a C string rather than an NSString, so no `@` before the string.

## Example use-case

```objc
#import <UIKit/UIKit.h>

%hook PSTableCell

-(void)didMoveToWindow {
    UITableViewLabel *detail = MSHookIvar<UITableViewLabel *>(self, "_detailTextLabel");
    detail.textColor = UIColor.redColor;
    %orig;
}

%end
```

## Alternative to `MSHookIvar`

`-valueForKey:` is an alternative to `MSHookIvar` when it cannot be used. It is also not a part of the Cydia Substrate API. It will work most of the time and is also useful for when a file cannot have a `.xm` extension. However, it may not work for Non-KVO-compliant classes.

Its syntax looks like this:

```objc
[object valueForKey:name_of_ivar];
```

* `object` - This is where the ivar is located, so for example it could be `self` or an instance of a class.
* `name_of_ivar` - This is the name of the ivar. In `valueForKey`, the name is written as an `NSString`, not a C string. Bear in mind though that despite `MSHookIvar` "ugly" syntax, it tends to be more effective.

In addition, there is also `-safeValueForKey:`, which is a private method that is present in the `NSObject` class. The difference between `-valueForKey:` and `-safeValueForKey:` is that `-valueForKey:` will crash if the instance variable is not present, while `-safeValueForKey:` will just return a `nil` value and not crash.

## Another Example use-case

```objc
#import <UIKit/UIKit.h>

%hook PSTableCell

-(void)didMoveToWindow {
    UITableViewLabel *detail = [self valueForKey:@"_detailTextLabel"];
    detail.textColor = UIColor.redColor;

    %orig;
}

%end
```

[Previous Page (Preference Bundles cont.)](./preference_bundles_cont.md)

[Next Page (Avoiding `layoutSubviews`)](./no_layoutsubviews.md)

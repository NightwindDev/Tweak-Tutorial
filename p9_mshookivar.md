# How Do You Create a Tweak?

## What is `MSHookIvar`?

MSHookIvar is a function, used by Substrate, to obtain ivar values of an object or instance. It can only be used in `.xm` files, so if it is needed to be used, the file should be renamed to have a `.xm` extension.

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

`valueForKey` is an alternative to `MSHookIvar` when it cannot be used. Its syntax looks like this:

```objc
[object valueForKey:name_of_ivar];
```

* `object` - This is where the ivar is located, so for example it could be `self` or an instance of a class.
* `name_of_ivar` - This is obviously the name of the ivar. In `valueForKey` it can be written as a NSString though.

## Example use-case

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


<a href="https://github.com/NightwindDev/Tweak-Tutorial/blob/main/p8_challenges.md">Previous Page (Challenges)</a>

<a href="https://github.com/NightwindDev/Tweak-Tutorial/blob/main/p10_hookf.md">Next Page (%hookf)</a>



# How Do You Create a Tweak?

## A Great Resource: Headers

"Headers" are `.h` files. They define "things" for the actual code in `.m` files, and if you choose to use them in your tweak, they will also define "things" for your `.x`/`.xm` file as well. `@interface`, `@property`, methods, `#import`, `#include`, etc are all located in header files. A header file would look something like this:

```objc
#import <UIKit/UIKit.h>

@interface AViewController : UIViewController

@property (nonatomic, strong) NSString *someStringProperty;
@property (nonatomic, assign) BOOL someBooleanProperty;
@property (nonatomic, strong) NSArray *someArrayProperty;

-(void)someVoidMethod;
-(BOOL)someBooleanMethod;
-(id)someIdMethod;
-(void)someMethodWithArgs:(BOOL)arg1;

@end
```

This is a very short header, normally they would be much longer, however it is a good "example" header.

Most views and view controllers in the software have such headers, and those would help with finding the correct methods to use. Let's say, theoretically, we want to hook `AViewController`, and let's say we want to use a specific method. We could either use FLEX for that or use the header. We would do:

```objc
%hook AViewController

-(void)someVoidMethod {
  %orig;
  // our code
}

%end
```

This is just an explanation of how we would use the headers, it is not actual code.

People have dumped headers for views and view controllers for versions and posted them online. You can use these to your advantage when finding what to hook. Some great places to find dumped headers are https://developer.limneos.net and https://headers.krit.me. These are easy to use and help a lot.

<a href="https://developer.limneos.net">Limneos</a> — To use this service, simply type the class you are trying to find the headers for in the search bar.

<a href="https://headers.krit.me">Krit</a> — To use this service, find the iOS version that you are trying to find the headers for and then go on the searchbar to find your headers.

Of course, not all headers are dumped, sometimes you will need to dump them yourself. One of the <a href="https://www.youtube.com/watch?v=M8HzCj0aKpw">videos by Zane Helton</a> explains how to do this perfectly.

## A brief explanation of `@property` and it's arguments

`@property` obviously adds properties to the object that is being interfaced so that dot notation could be used.

`@synthesize` automatically generates a getter and a setter for an underlying ivar.

| Name | Description |
| ---- | ----------- |
| `nonatomic` | Multiple threads can access properties at the same time.
| `atomic` | A single thread can access a property at a given time. |
| `assign` | Used for primitive data types such as `int`, `bool`, `char`, etc.
| `readonly` | Only a getter will be generated, so you can get its value but not set it.
| `readwrite` | A getter AND a setter method will be generated.
| `strong/weak` |  Used for pointers.
| `copy` |  Used for pointers, calls `[PROPERTY copy]` so you get a copy of the property (Only works in `NSCopying`-compliant classes).
| `retain` | __**DEPRECATED**__: Same as `strong`, but you should use `strong` because it is newer.

<a href="https://github.com/NightwindDev/Tweak-Tutorial/blob/main/p3_views.md">Previous Page (Delving Into Views)</a>

<a href="https://github.com/NightwindDev/Tweak-Tutorial/blob/main/p5_prefbundle.md">Next Page (Preference Bundles)</a>
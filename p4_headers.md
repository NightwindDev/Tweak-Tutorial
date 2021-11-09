# How Do You Create a Tweak?

## A Great Resource: Headers

"Headers" are `.h` files. They define "things" for the actual code in `.m` files, and if you choose to use them in your tweak, they will also define "things" for your `.x`/`.xm` file as well. `@interface`, `@property`, methods, `#import`, `#include`, etc are all located in header files. A header file would look something like this:

```objc
#import <UIKit/UIKit.h>

@interface AViewController : UIViewController

@property (nonatomic, retain) NSString *someStringProperty;
@property (nonatomic, retain) BOOL *someBooleanProperty;
@property (nonatomic, retain) NSArray *someArrayProperty;

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


<a href="https://github.com/NightwindDev/Tweak-Tutorial/blob/main/p3_syntax.md">Previous Page (Delving Into Views)</a>

<a href="https://github.com/NightwindDev/Tweak-Tutorial/blob/main/p5_example.md">Next Page (Trying Another Example Tweak)</a>

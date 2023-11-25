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

This is a very short header, normally they would be much longer, however it is a good "example" header to grasp the basic idea.

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

People have dumped headers for views and view controllers for versions and posted them online. You can use these to your advantage when finding what to hook. Some great places to find dumped headers are https://developer.limneos.net and https://headers.cynder.me. These are easy to use and help a lot.

[Limneos](https://developer.limneos.net) — To use this service, simply type the class you are trying to find the headers for in the search bar.

[Cynder](https://headers.cynder.me) — To use this service, find the iOS version that you are trying to find the headers for and then go on the searchbar to find your headers.

Of course, not all headers are dumped, sometimes you will need to dump them yourself. A [video](https://web.archive.org/web/20201202093934/https://www.youtube.com/watch?v=M8HzCj0aKpw&gl=US&hl=en) (archived via [the Internet Archive](https://archive.org)) by Zane Helton explains how to do this perfectly.

## A brief explanation of `@property` and it's attributes

`@property` adds properties, which are values of classes, to the object that is being interfaced. They exist to store data for later reference and/or reassignment in the object, and they are a newer and more adopted standard compared to the old way of using instance variables (ivars).

The table below shows the attributes which describe the property's behavior to `@property`, which can be seen in the parentheses in between `@property` and the actual property type and name, so:

`@property (/* here */) generic_type someName;`

| Name          | Description                                                                                                                 |
| ------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `nonatomic`   | Multiple threads can access properties at the same time.                                                                    |
| `atomic`      | A single thread can access a property at a given time.                                                                      |
| `assign`      | Used for primitive data types such as `int`, `bool`, `char`, etc.                                                           |
| `readonly`    | Only a getter will be generated, so you can get its value but not set it.                                                   |
| `readwrite`   | A getter AND a setter method will be generated.                                                                             |
| `strong/weak` | Used for pointers.                                                                                                          |
| `copy`        | Used for pointers, calls `[PROPERTY copy]` so you get a copy of the property (Only works in `NSCopying`-compliant classes). |
| `retain`      | __**DEPRECATED**__: Same as `strong`, but you should use `strong` because it is newer.                                      |

[Previous Page (Delving Into Views)](./views.md)

[Next Page (Preference Bundles)](./preference_bundles.md)

# How Do You Create a Tweak?

## How do we create our own shapes on top of the software?

Let's say we theoretically wanted to make a shape on our screen. How would we accomplish that? Well, we would need to use <a href="https://developer.apple.com/documentation/uikit?language=objc">UIKit</a>. 

UIKit features UIViews and UIViewControllers. These are used to create "shapes" which we will now be referring to as "views" and "view controllers."

## UIView
UIViews are basically the "shapes" that we are talking about. For example, `UIButton`s are UIViews, and so are `SBIconView`s which are the icons on our homescreen.

## UIViewController
UIViewControllers, on the other hand, "control" the views. They utilize data and display it on a UIView. An example of this would be `UIAlertController`.  

## Applying the Knowledge

So, from what we learned, we will now try to create our own tweak to put a rectangle on our homescreen. We will replace the code in our first tweak, but if you want to make a new project for this, feel free to do so. Let's first find the class that we will hook to "inject" our custom code to. We will do this with FLEX. As stated previously, the way we will need to find the view would be like so:

1. Trigger the FLEX menu (the instructions to this are likely in the tweak description.)
2. Press the select button on the FLEX menu.
3. Then press the HomeScreen.
4. After that, press the views button. FLEX will automatically scroll down to the selected view.

We will not be changing any `@property` on our view, so we don't need to look for that. The view you should have selected is `SBHomeScreenView`. If this was not the case, then scroll up in the FLEX menu and find it. Notice how it has parenthesis after it, saying `SBHomeScreenViewController`? Well, generally, it is better to hook the view controller instead of the view when adding your own view. So, we will be hooking that instead. 
Note: if you do not see `SBHomeScreenViewController`, try pressing the (i) button next to `SBHomeScreenView` and then pressing the "Nearest View Controller" tile.

To transfer this to code, we will do the following.

```objc
#import <UIKit/UIKit.h> // Importing UIKit

@interface SBHomeScreenViewController : UIViewController /* Interfacing, SBHomeScreenViewController
                                                            inherits from UIViewController */
@end

%hook SBHomeScreenViewController // Hooking SBHomeScreenViewController

%end
```

Now we will find the correct method to use to put our view in. Generally, `viewDidLoad` is a "safe bet" because it is on all view controllers. You have to put your methods inside of the hook. So, adding on to the previous code snippet, we would put:

```objc
%hook SBHomeScreenViewController // Hooking SBHomeScreenViewController

-(void)viewDidLoad { // method
  %orig; // original code
}

%end
```

Right now, this code just executes or "initializes" the original code. We need to add our own code there.

We will make our own view now. To make our own view, we will allocate and initalize UIView.

```objc
UIView *ourView = [[UIView alloc] init];
```

For now, we will give it a frame, although it is better to use `NSLayoutConstraint`s for layouts. Let's make the rectangle have a width of 40, a height of 30, and be located on the top left of the screen.

For this, we will use `CGRectMake`, but as stated previously, for more *"advanced"* layouts, ***please*** use `NSLayoutConstraint`s instead.

The way to do this with frames is like so:

```objc
UIView *ourView = [[UIView alloc] init];
ourView.frame = CGRectMake(
                           0, // X coordinate 
                           0, // Y coordinate
                           40, // Width
                           30); // Height


// constraints ↓ FIX

// [ourView.leadingAnchor constraintEqualToAnchor: ]].active = YES;
// [[target constraint] constraintEqualToAnchor: [targetTwo constraint]].active = YES;
// [[target constraint] constraintEqualToAnchor: [targetTwo constraint]].active = YES;
// [[target constraint] constraintEqualToAnchor: [targetTwo constraint]].active = YES;
```

Note that this is vetical just for the purpose of showing what number is what, this could easily be written as:

```objc
UIView *ourView = [[UIView alloc] init];
ourView.frame = CGRectMake(0, 0, 40, 30); 
```

Then, we will need to set a background color to this rectangle. Let's set it to... blue. How do we do this? It's actually really simple!

```objc
ourView.backgroundColor = [UIColor blueColor];
```

The available colors can be found here: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/

Finally, we will need to add our rectangle as a subview to our hooked view controller. This can be done like so:

```objc
[self.view addSubview:ourView];
```

`self` refers to the hooked view controller and the `.view` is needed because we are adding our subview to the view of the view controller.

To compile all this together, our final code should look like so:

```objc
#import <UIKit/UIKit.h> // Importing UIKit

@interface SBHomeScreenViewController : UIViewController /* Interfacing, SBHomeScreenViewController
                                                            inherits from UIViewController */
@end

%hook SBHomeScreenViewController // Hooking SBHomeScreenViewController

-(void)viewDidLoad { // method
  %orig; // original code
  UIView *ourView = [[UIView alloc] init]; // allocating/initializing our view
  ourView.frame = CGRectMake(
                             0, // X coordinate 
                             0, // Y coordinate
                             40, // Width
                             30); // Height
  ourView.backgroundColor = [UIColor blueColor]; // setting our background color to blue
  [self.view addSubview:ourView]; // adding our view as a subview
}

%end
```

<img width="102" alt="IMG_18CFD7742F33-1" src="https://user-images.githubusercontent.com/81449663/140844150-c6246369-a493-47a5-a012-cf9acf4e5cdc.png">

Looks like it's working!


<a href="https://github.com/NightwindDev/Tweak-Tutorial/blob/main/p2_syntax.md">Previous Page (Code for The Tweak)</a>

<a href="https://github.com/NightwindDev/Tweak-Tutorial/blob/main/p4_headers.md">Next Page (Finding Headers)</a>

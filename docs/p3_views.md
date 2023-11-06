---
id: exploring_views
title: Exploring Views
sidebar_position: 3
---

##### **Notice:** bear in mind that you don't really hook classes, you hook methods. But to keep consistency across this tutorial we'll refer to that by saying hook a class

## How do we create our own shapes on top of the software?

Let's say we theoretically wanted to make a shape on our screen. How would we accomplish that? Well, we would need to use [UIKit](https://developer.apple.com/documentation/uikit?language=objc).

UIKit features UIViews and UIViewControllers. These are used to create "shapes" which we will now be referring to as "views" and "view controllers."

## UIView

UIViews are basically the "shapes" that we are talking about. For example, `UIButton`s are UIViews, and so are `SBIconView`s which are the icons on our homescreen.

## UIViewController

UIViewControllers, on the other hand, "control" the views. They utilize data and display it on a UIView. An example of this would be `UIAlertController`. `UIViewController`s do not actually display anything by themselves on the screen, they use their `.view` property, which is a `UIView`, to display whatever they need to display.

## Applying the Knowledge

So, from what we learned, we will now try to create our own tweak to put a rectangle on our homescreen. We will replace the code in our first tweak, but if you want to make a new project for this, feel free to do so. Let's first find the class that we will hook the methods of to "inject" our custom code to. We will do this with FLEX. As stated previously, the way we will need to find the view would be like so:

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

%hook SBHomeScreenViewController

%end
```

Now we will find the correct method to use to put our view in. Generally, `viewDidLoad` is a "safe bet" because it is called only once in the view controller's lifecycle. It is also called late enough in the lifecycle for the changes with the view take effect. You have to put your methods inside of the hook. So, adding on to the previous code snippet, we would put:

```objc
%hook SBHomeScreenViewController

-(void)viewDidLoad { // overriding method
    %orig; // original code
}

%end
```

Right now, this code just executes or "initializes" the original code. We need to add our own code there.

We will now make our own view. To make our own view, we will allocate and initalize a UIView.

```objc
UIView *ourView = [[UIView alloc] init];
```

There are two distinct ways to lay out a view's position on the screen. One is with frames and the other is with constraints.

## Frames

The way to do this with frames like this:

```objc
UIView *ourView = [[UIView alloc] init];
ourView.frame = CGRectMake(
                           0, // X coordinate
                           0, // Y coordinate
                           40, // Width
                           30); // Height

```

Note that this is vertical just for the purpose of showing which number represents what, this could easily be written as:

```objc
UIView *ourView = [[UIView alloc] init];
ourView.frame = CGRectMake(0, 0, 40, 30);
```

Then, we will need to set a background color to this rectangle. Let's set it to... blue. How do we do this? It's actually really simple!

```objc
ourView.backgroundColor = [UIColor blueColor];
```

The available colors can be found [here](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/).

Finally, we will need to add our rectangle as a subview of the view controller's view. This can be done like so:

```objc
[self.view addSubview:ourView];
```

`self.view` is needed because we are adding our subview to the view of the view controller, not the view controller itself. The view controller is not present in the view hierarchy; it is not a visual element that one can see on the screen. However, its view _is_ present in the hierarchy.

To compile all this together, our final code should look like something like this:

```objc
#import <UIKit/UIKit.h> // Importing UIKit

@interface SBHomeScreenViewController : UIViewController /* Interfacing, SBHomeScreenViewController
                                                            inherits from UIViewController */
@end

%hook SBHomeScreenViewController

-(void)viewDidLoad { // overriding method
    %orig; // original code

    UIView *ourView = [[UIView alloc] init]; // allocating & initializing our view
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

## Constraints

Constraints are good for making complex layouts and they work universally across devices as well as in some tricky scenarios. For example, when the user rotates their device, the constraints could update to reflect the new screen whereas frames cannot.

When using constraints, the view's `translatesAutoresizingMaskIntoConstraints` property needs to be set to false. If it is not set to false, then UIKit will automatically create autoresizing mask constraints for the view.

This is how that would be done:

```objc
view.translatesAutoresizingMaskIntoConstraints = false;
```

The view then needs to be added as a subview BEFORE creating the constraints. Otherwise, the parent view will try to create constraints for a subview that doesn't exist yet and will result in runtime crashes. So now, we need to do:

```objc
[self.view addSubview:ourView];
```

The basic syntax of constraints looks something like this:

```objc
// Setting constraint to other view's constraints with a constant
[view.anchorType constraintEqualToAnchor:otherView.anchorType constant:x].active = true;

// Setting constraint to other view's constraint without a constant
[view.anchorType constraintEqualToAnchor:otherView.anchorType].active = true;

// Setting constraint to constant
[view.anchorType constraintEqualToConstant:x].active = true;
```

These are the `anchorType`s that can be used with constraints:

| Anchor Type      | Description                                            |
| ---------------- | ------------------------------------------------------ |
| `leadingAnchor`  | Left side of a view (with support for RTL languages).  |
| `trailingAnchor` | Right side of a view (with support for RTL languages). |
| `leftAnchor`     | Left side of a view.                                   |
| `rightAnchor`    | Right side of a view.                                  |
| `topAnchor`      | Top of view.                                           |
| `bottomAnchor`   | Bottom of view.                                        |
| `centerXAnchor`  | Center of view on X-axis.                              |
| `centerYAnchor`  | Center of view on Y-axis.                              |

Alright, so now we're ready to add the constraints. The constraints will look something like this:

```objc
[ourView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor].active = true;
[ourView.topAnchor constraintEqualToAnchor: self.view.topAnchor].active = true;
[ourView.widthAnchor constraintEqualToConstant: 40].active = true;
[ourView.heightAnchor constraintEqualToConstant: 30].active = true;
```

We will then add the background color like we did with frames:

```objc
ourView.backgroundColor = [UIColor blueColor];
```

To compile all this together, our final code should look like so:

```objc
#import <UIKit/UIKit.h> // Importing UIKit

@interface SBHomeScreenViewController : UIViewController /* Interfacing, SBHomeScreenViewController
                                                            inherits from UIViewController */
@end

%hook SBHomeScreenViewController

-(void)viewDidLoad { // overriding method
    %orig; // original code

    UIView *ourView = [[UIView alloc] init]; // allocating & initializing our view
    ourView.backgroundColor = [UIColor blueColor]; // setting our background color to blue
    ourView.translatesAutoresizingMaskIntoConstraints = false; // allows for manual control of constraints
    [self.view addSubview:ourView]; // adding our view as a subview

    [ourView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor].active = true; // Left Constraint
    [ourView.topAnchor constraintEqualToAnchor: self.view.topAnchor].active = true; // Top Constraint
    [ourView.widthAnchor constraintEqualToConstant: 40].active = true; // Width Constraint
    [ourView.heightAnchor constraintEqualToConstant: 30].active = true; // Height Constraint
}

%end
```

![Example of it Working](https://user-images.githubusercontent.com/81449663/140844150-c6246369-a493-47a5-a012-cf9acf4e5cdc.png)

Looks like it's working!

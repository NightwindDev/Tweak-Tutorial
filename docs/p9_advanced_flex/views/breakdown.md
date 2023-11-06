---
id: flex_views
title: Views
unlisted: true
---
The top title of the window is the name of the selected view. It can be hooked with proper interfacing. In this case, the hooking would look like:


```objc
%hook UIScrollView
// the hooked methods
%end
```
<br/>
Next, there is a <b>searchbar</b> where you can search for any information about the instance of the class that you need.
<br/>
After that, there is a <b>tabview</b> where FLEX displays all the superclasses for the current class. In the above screenshot, UIScrollView is a subclass of UIView which is a subclass of UIResponder, which in turn is a sublcass of NSObject.
<br/>
In the next area, called the <b>DESCRIPTION</b> area, some basic information about the class is displayed. The information shown, which looks like:

```
<UIScrollView:0x108832a00; frame = (0 0; 390 375);
clipsToBounds = YES; gestureRecognizers = <NSArray:
0x2830faeb0>; layer = <CALayer: 0x283efcbc0>;
contentOffset: {0, 0}; contentSize: {1813, 0};
adjustedContentInset: {0, 0, 0, 0}>
```
* `<UIScrollView:0x108832a00;` -> This is the class view and its tag, which can be hooked using `viewWithTag:`
* `frame = (0 0; 390 375);` -> This is the frame of the instance following a format of `x`, `y`, `width` and `height`
* `clipsToBounds = YES;` -> This shows whether the instance of the class allows its subviews to clip its bounds
* `gestureRecognizers = <NSArray: 0x2830faeb0>;` -> This shows the <a href="https://medium.com/ios-os-x-development/make-a-custom-uigesturerecognizer-in-objective-c-b9099fd8cfa3">gestureRecognizers</a> on the instance of the class.
* `layer = <CALayer: 0x283efcbc0>;` -> Gets the current <a href="https://www.youtube.com/watch?v=-kjyltrKZSY">.layer</a> properrty of the instance of the view.
* `contentOffset: {0, 0};` -> This is a property which `UIScrollView` has, which is <a href="https://developer.apple.com/documentation/uikit/uiscrollview/1619404-contentoffset?language=objc">"the point at which the origin of the content view is offset from the origin of the scroll view."</a>

Next, we have the "SHORTCUTS" section of the view. In here, we have some basic/common properties for the tweak. For example, the first shortcut is the Nearest View Controller shortcut, having the view controller that the view resides in. These properties are different for different views.

Further ahead, we have the "PROPERTIES" section. This section contains all the `@property`'s for the tweak, not just the basic ones. It also contains their values. You may be able to change some of them as well by tapping the ⓘ button to temporarily set the `@property` to adifferent value.

After that, there is the "IVARS" section. This section contains all the **i**nstance **var**iables for the object.

Below that, there is the "METHODS" section, which contains all the instance methods that the object has. Note that this contains the methods for the specific *subclass* that the selected object pertains to, not all the methods which it inherits from its superclass. To check the methods which it inherits from its superclass, you'd need to go to the tabview and select its superclass.

In addition, there is a section below that which contains the class methods for the object. These are different with respect to the instance methods because they are on the class itself, not an instance of the class.

Next, there's the "CLASS HIERARCHY" section. This is pretty much the same thing as the top tabbar with the various subclasses and superclasses.

After that, we have the "PROTOCOLS" section. This includes all the protocols that the view conforms to.

Next, there is some miscellaneous information about the object inside of the "MISCELLANEOUS" section.

Finally, the very last section is the "OBJECT GRAPH" section. This section allows you to browse all the objects that reference the current object in their code.
<!-- markdownlint-disable MD001 MD026 -->

# How Do You Create a Tweak?

## Why Should We Know About Flex?
Flex makes it **significantly** easier to debug your tweak, look through different classes and their properties without dumping their headers, and a whole lot more.

## Flex's Menu

<details>
<summary>Menu Tab</summary>
<blockquote>
    > --- Process and Events --- <
    <br/><br/>
    <details>
    <summary>📡 Network History</summary>
    <blockquote> Shows the network history of the device.
    </details>
    <details>
    <summary>&#x26A0; System Log</summary>
    <blockquote> Similar to the Console app on macOS, shows logs from os_log/NSLog.
    </details>
    <details>
    <summary>🚦 NSProcessInfo.processInfo</summary>
    <blockquote> Shows information about the current <a href="https://developer.apple.com/documentation/foundation/nsprocessinfo?language=objc">process</a>.
    </details>
    <details>
    <summary>💩 Heap Objects</summary>
    <blockquote> Allows the finding of objects which are currently in the <a href="https://stackoverflow.com/questions/79923/what-and-where-are-the-stack-and-heap">heap</a>.
    </details>
    <details>
    <summary>🔎 Address Explorer</summary>
    <blockquote> Allows the user to find objects at certain memory addresses. For example, a memory address could be 0x03a61efb and it would store an object. This object's methods could then be hooked for the desired outcome.
    </details>
    <details>
    <summary>📚 Runtime Browser</summary>
    <blockquote> Allows the user to browse the Objective-C runtime. Extremely useful if one wants to find classes, methods, etc. in there.
    <br/><br/>
    <details>
    <summary>Keyboard Button: *</summary>
    <blockquote> Allows the selection of specific dylibs and frameworks to browse.
    </details>
    <details>
    <summary>Keyboard Button: *.</summary>
    <blockquote> Allows the user to browse specific class names in the runtime.
    </details>
    </details>
    > ---- App Shortcuts ---- <
    <br/><br/>
    <details>
    <summary>📁 Browse Bundle Directory</summary>
    <blockquote> Allows the user to browse the contents of the current NSBundle. Contents may include .plist files, images, localizations, etc.
    </details>
    <details>
    <summary>📁 Browse Container Directory</summary>
    <blockquote> Allows the user to browse the contents of the current NSBundle container, e.g. /var/mobile/Containers/Data/Application/container_id.
    </details>
    <details>
    <summary>📦 NSBundle.mainBundle</summary>
    <blockquote> Allows the user to look at information about the NSBundle in the current app.
    </details>
    <details>
    <summary>💾 Preferences</summary>
    <blockquote> Allows the user to look at the <a href="https://developer.apple.com/documentation/foundation/nsuserdefaults">NSUserDefaults</a> of the current app.
    </details>
    <details>
    <summary>🔑 Keychain</summary>
    <blockquote> Shows the keychain for the current app.
    </details>
    <details>
    <summary>🚀 UIApplication.sharedApplication</summary>
    <blockquote> Gives access to methods, properties, etc from UIApplication through it’s <a href="https://developer.apple.com/documentation/appkit/nsapplication/1428360-sharedapplication">sharedApplication</a>’s <a href="https://riptutorial.com/objective-c/example/3258/singleton-class">singleton</a>.
    </details>
    <details>
    <summary>🎟️ App Delegate</summary>
    <blockquote> Gets the current <a href="https://developer.apple.com/documentation/uikit/uiapplicationdelegate?language=objc">app delegate</a>.
    </details>
    <details>
    <summary>🔑 Key Window</summary>
    <blockquote> Fetches the current <a href="https://developer.apple.com/documentation/uikit/uiapplication/1622924-keywindow?language=objc">key window</a>.
    </details>
    <details>
    <summary>🌴 Root View Controller</summary>
    <blockquote> Fetches the current <a href="https://developer.apple.com/documentation/uikit/uiwindow/1621581-rootviewcontroller?language=objc">root view controller</a>.
    </details>
    <details>
    <summary>🍪 Cookies</summary>
    <blockquote> Gets the cookies in the current app.
    </details>
    > ---- Miscellaneous ---- <
    <br/><br/>
    <details>
    <summary>📋 UIPasteboard.generalPasteboard</summary>
    <blockquote> Gets the current clipboard. The current pasteboard is <a href="https://developer.apple.com/documentation/uikit/uipasteboard?language=objc">UIPasteboard</a>'s <a href="https://developer.apple.com/documentation/uikit/uipasteboard/1622106-generalpasteboard?language=objc">generalPasteboard</a> property.
    </details>
    <details>
    <summary>💻 UIScreen.mainScreen</summary>
    <blockquote> Shows information about the primary screen instance of UIScreen for the device.
    </details>
    <details>
    <summary>📱 UIDevice.currentDevice</summary>
    <blockquote> Shows information about the current device.
    </details>
    <details>
    <summary>📡 NSURLSession.sharedSession</summary>
    <blockquote> Shows information about the current instance of <a href="https://developer.apple.com/documentation/foundation/nsurlsession">__NSURLSessionLocal</a>.
    </details>
    <details>
    <summary>⏳ NSURLCache.sharedURLCache</summary>
    <blockquote> Gets information about <a href="https://developer.apple.com/documentation/foundation/nsurlcache">NSURLCache</a>.
    </details>
    <details>
    <summary>🔔 NSNotificationCcenter.defaultCenter</summary>
    <blockquote> Fetches the instance of <a href="https://developer.apple.com/documentation/foundation/nsnotificationcenter">NSNotificationCenter</a>.
    </details>
    <details>
    <summary>📎 UIMenuController.sharedMenuController</summary>
    <blockquote> Fetches information about the current <a href="https://developer.apple.com/documentation/foundation/uimenucontroller">UIMenuController</a>.
    </details>
    <details>
    <summary>🗄️ NSFileManager.defaultManager</summary>
    <blockquote> Gets the current NSFileManager.defaultManager instance.
    </details>
    <details>
    <summary>🌎 NSTimeZone.systemTimeZone</summary>
    <blockquote> Gets the current timezone, stored in the NSTimeZone class
    </details>
    <details>
    <summary>🗣️ NSLocale.currentLocale</summary>
    <blockquote> Gets the current instance of <a href="https://developer.apple.com/documentation/foundation/nslocale?language=objc">NSLocale</a>.
    </details>
    <details>
    <summary>📆 NSCalendar.currentCalendar</summary>
    <blockquote> Gets the current instance of the calendar, stored in the NSCalendar class.
    </details>
    <details>
    <summary>🏃 NSRunLoop.mainRunLoop</summary>
    <blockquote> Gets the current <a href="https://developer.apple.com/documentation/foundation/nsrunloop">NSRunLoop</a>.
    </details>
    <details>
    <summary>🧵 NSThread.mainThread</summary>
    <blockquote> Gets the current thread in the <a href="https://developer.apple.com/documentation/foundation/nsthread">NSThread</a> class.
    </details>
    <details>
    <summary>📚 NSOperationQueue.mainQueue</summary>
    <blockquote> Gets the current main queue for <a href="https://developer.apple.com/documentation/foundation/nsoperationqueue">NSOperationQueue</a>.
    </details>
</blockquote>
</details>

<!--<details>-->
<summary>Views Tab</summary>
<blockquote>
<br/>
<img src="https://i.imgur.com/zgrHhRA.png" width="250"></img>
<br/>
When the view tab is pressed, this is what pops up. The popup conveys the view hierarchy of the current UIWindow. The more to the right the view is, the more views it is under. Pressing the <b style="color:rgb(15, 105, 249);">ⓘ</b> button allows a look at the view's information, opening up the window that looks like this:
<br/>
<img src="https://i.imgur.com/jP1r49a.png" width="250"></img>
<br/>
Let's break it all down.
<br/>
========================
<br/>
The top title of the window is the name of the selected view. It can be hooked with proper interfacing. In this case, the hooking would look like:
<br/>

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

\<UIScrollView:0x108832a00; frame = (0 0; 390 375); clipsToBounds = YES; gestureRecognizers = <NSArray: 0x2830faeb0>; layer = <CALayer: 0x283efcbc0\>; contentOffset: {0, 0}; contentSize: {1813, 0}; adjustedContentInset: {0, 0, 0, 0}\>


</blockquote>

<!--</details>-->

<details>
<summary>Select Button</summary>
<blockquote>Allows you to select a view on the screen and look at its values.</blockquote>
</details>

<details>
<summary>Recent Button</summary>
This is how you dropdown.
</details>
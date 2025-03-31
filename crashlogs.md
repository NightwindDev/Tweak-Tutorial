# How Do You Create a Tweak?
Knowing how to read crashlogs can help diagnose issues with code.

iOS has a built-in crash reporting system. By default, this system includes some basic information about the crash. However, we can enhance this system.
- On iOS 14 and below, there is an application called Cr4shed on the Havoc repo - [link](https://havoc.app/package/cr4shed). This application allows viewing of crashlogs and also hooks into the stock crash reporting system to provide more details.
- On iOS 15 and above, Cr4shed does not work correctly. However, there is a combination of two packages that can be used to get readable and useful crash reports. There is an application called KrashKop on the Havoc repo - [link](https://havoc.app/package/krashkop). This application allows viewing of crashlogs. However, we can enhance the produced crash reports by using the OSAnalytics tweak from this repo: https://poomsmart.github.io/repo/. Make sure to perform a userspace reboot after installing this tweak in order for it to take effect.

## What do crashlogs look like?
We will be looking into the structure of a sample crashlog from KrashKop with OSAnalytics installed. Crashlogs from Cr4shed look similar, with some minor differences. Let's make a quick tweak that will purposefully crash SpringBoard in order to look at the crash. Here is the sample tweak:
```objc
#import <UIKit/UIKit.h>

@interface SBIconView : UIView
- (void)nonexistentMethod;
@end

%hook SBIconView

- (void)didMoveToWindow {
	%orig;
	[self nonexistentMethod];
}

%end
```
In this code, we're essentially lying to the compiler by saying that `SBIconView` has a method called `nonexistentMethod`. When we call the method with `[self nonexistentMethod];`, SpringBoard will crash with the folowing crashlog. Some details have been stripped for brevity.

```
Incident Identifier: 7AE383D3-92AA-4783-B9DD-FF514DE29D3A
CrashReporter Key:   a5a64577848c568ee740561fbbff3e23b256e045
Process:             SpringBoard [30471]
Path:                /System/Library/CoreServices/SpringBoard.app/SpringBoard
Identifier:          com.apple.springboard
Version:             1.0 (50)
Code Type:           ARM-64 (Native)
Role:                Foreground
Parent Process:      launchd [1]
Coalition:           com.apple.springboard [9408]

/* Device specific information redacted for brevity */

Exception Type:  EXC_CRASH (SIGABRT)
Exception Codes: 0x0000000000000000, 0x0000000000000000
Exception Note:  EXC_CORPSE_NOTIFY
Triggered by Thread:  0

Application Specific Information:
terminating with uncaught exception of type NSException
*** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[SBIconView nonexistentMethod]: unrecognized selector sent to instance 0x105926e00'
dyld4 config: DYLD_INSERT_LIBRARIES=/usr/lib/systemhook.dylib
abort() called


Last Exception Backtrace:
0   CoreFoundation                	       0x180c750fc __exceptionPreprocess + 220
1   libobjc.A.dylib               	       0x1994afd64 objc_exception_throw + 60
2   CoreFoundation                	       0x180d520c4 +[NSObject(NSObject) _copyDescription] + 0
3   UIKitCore                     	       0x183ff0030 -[UIResponder doesNotRecognizeSelector:] + 296
4   CoreFoundation                	       0x180c0a524 ___forwarding___ + 1728
5   CoreFoundation                	       0x180c09660 _CF_forwarding_prep_0 + 96
6   samplecrash.dylib             	       0x109867f34 _logos_method$_ungrouped$SBIconView$didMoveToWindow + 56
7   UIKitCore                     	       0x18333ce78 -[UIView(Internal) _didMoveFromWindow:toWindow:] + 2228
8   UIKitCore                     	       0x18333c960 -[UIView(Internal) _didMoveFromWindow:toWindow:] + 924
9   UIKitCore                     	       0x18333c960 -[UIView(Internal) _didMoveFromWindow:toWindow:] + 924
10  UIKitCore                     	       0x18333c960 -[UIView(Internal) _didMoveFromWindow:toWindow:] + 924
11  UIKitCore                     	       0x18333c960 -[UIView(Internal) _didMoveFromWindow:toWindow:] + 924
12  UIKitCore                     	       0x18333c960 -[UIView(Internal) _didMoveFromWindow:toWindow:] + 924
13  UIKitCore                     	       0x18333c960 -[UIView(Internal) _didMoveFromWindow:toWindow:] + 924
14  UIKitCore                     	       0x18333c960 -[UIView(Internal) _didMoveFromWindow:toWindow:] + 924
15  UIKitCore                     	       0x1832625cc __45-[UIView(Hierarchy) _postMovedFromSuperview:]_block_invoke + 140
16  UIKitCore                     	       0x1832f210c -[UIView(Hierarchy) _postMovedFromSuperview:] + 808
17  UIKitCore                     	       0x18320e194 -[UIView(Internal) _addSubview:positioned:relativeTo:] + 2148
18  UIKitCore                     	       0x183349b50 -[UIWindow addRootViewControllerViewIfPossible] + 976
19  UIKitCore                     	       0x183356bbc -[UIWindow setRootViewController:] + 600
20  SpringBoard                   	       0x1ae5f6eb0 -[SBWindow initWithScreen:scene:rootViewController:layoutStrategy:role:debugName:] + 724
21  SpringBoard                   	       0x1ae532514 -[SBHomeScreenWindow initWithScreen:scene:rootViewController:layoutStrategy:role:debugName:] + 216
22  SpringBoard                   	       0x1ae0025d0 -[SBUIController init] + 676
23  SpringBoard                   	       0x1adef9754 +[SBUIController sharedInstance] + 144
24  SpringBoard                   	       0x1adef94dc +[SBIconController sharedInstance] + 36
25  SpringBoard                   	       0x1ae2c14d4 -[SBAppSwitcherModel init] + 48
26  SpringBoard                   	       0x1ae36dd0c -[SBMainSwitcherViewController _init] + 84
27  SpringBoard                   	       0x1ae36dc88 __46+[SBMainSwitcherViewController sharedInstance]_block_invoke + 44
28  libdispatch.dylib             	       0x1808e7670 _dispatch_client_callout + 20
29  libdispatch.dylib             	       0x1808e8f18 _dispatch_once_callout + 32
30  SpringBoard                   	       0x1adf3a920 +[SBMainSwitcherViewController sharedInstance] + 324
31  SpringBoard                   	       0x1ae487ca8 -[SBApplicationSupportServiceRequestContext _main_persistenceIDs] + 56
32  SpringBoard                   	       0x1ae487dbc -[SBApplicationSupportServiceRequestContext _main_applicationInitializationContext] + 108
33  SpringBoard                   	       0x1ae4876f8 -[SBApplicationSupportServiceRequestContext applicationInitializationContext] + 72
34  SpringBoard                   	       0x1ae065be4 -[SBApplication _initializationContext] + 124
35  SpringBoard                   	       0x1adf76204 -[SBApplication _processWillLaunch:] + 328
36  SpringBoard                   	       0x1ae01573c -[SBMainWorkspace _finishInitialization] + 616
37  BaseBoard                     	       0x18609c9e8 -[BSEventQueue _processNextEvent] + 332
38  BaseBoard                     	       0x18609399c -[BSEventQueue _removeEventQueueLock:] + 148
39  SpringBoard                   	       0x1ae0154a8 -[SBMainWorkspace _resume] + 276
40  SpringBoard                   	       0x1ae00ef48 +[SBMainWorkspace start] + 144
41  SpringBoard                   	       0x1adfe628c -[SpringBoard applicationDidFinishLaunching:] + 3288
42  UIKitCore                     	       0x1833ac520 -[UIApplication _handleDelegateCallbacksWithOptions:isSuspended:restoreState:] + 456
43  UIKitCore                     	       0x183594c54 -[UIApplication _callInitializationDelegatesWithActions:forCanvas:payload:fromOriginatingProcess:] + 5376
44  UIKitCore                     	       0x18357ce58 -[UIApplication _runWithMainScene:transitionContext:completion:] + 1208
45  UIKitCore                     	       0x1833da464 -[_UISceneLifecycleMultiplexer completeApplicationLaunchWithFBSScene:transitionContext:] + 216
46  UIKitCore                     	       0x1833d98c8 -[UIApplication _compellApplicationLaunchToCompleteUnconditionally] + 68
47  UIKitCore                     	       0x18359d064 -[UIApplication _run] + 1064
48  UIKitCore                     	       0x18331b958 UIApplicationMain + 2092
49  SpringBoard                   	       0x1adfcc8d8 SBSystemAppMain + 6564
50  dyld                          	       0x1051bdaa4 start + 520

/* Other threads redacted for brevity */

Thread 0 crashed with ARM Thread State (64-bit):
    x0: 0x0000000000000000   x1: 0x0000000000000000   x2: 0x0000000000000000   x3: 0x0000000000000000
    x4: 0x00000001995bb0ad   x5: 0x000000016ae21d10   x6: 0x000000000000006e   x7: 0x00000000000b3d00
    x8: 0x41f57397d4aebcb1   x9: 0x41f5c696d18f3931  x10: 0x0000000000000002  x11: 0x000000000000000b
   x12: 0x0000000089a26035  x13: 0x0000000009a26000  x14: 0x0000000000000010  x15: 0x0000000000000002
   x16: 0x0000000000000148  x17: 0x0000000105218580  x18: 0x000000012778ece8  x19: 0x0000000000000006
   x20: 0x0000000000000103  x21: 0x0000000105218660  x22: 0x000000028107cee0  x23: 0x0000000282563de0
   x24: 0x00000001cad9e5cf  x25: 0x000000028289b4c0  x26: 0x00000001cb167e4f  x27: 0x0000000000000008
   x28: 0x00000001caec184f   fp: 0x000000016ae21c80   lr: 0x00000001f1f4d378
    sp: 0x000000016ae21c60   pc: 0x00000001b8311964 cpsr: 0x40001000
   far: 0x00000001f1c5f9ec  esr: 0x56000080  Address size fault

Binary Images:
       0x1b830a000 -        0x1b833dfff libsystem_kernel.dylib arm64e  <eb3e47f3395335839feefb6cff8a8d7a> /usr/lib/system/libsystem_kernel.dylib
       0x1f1f46000 -        0x1f1f51fff libsystem_pthread.dylib arm64e  <c5c27e9d955739c9b9c65f6e7323ee1c> /usr/lib/system/libsystem_pthread.dylib
       0x18bb19000 -        0x18bb97fff libsystem_c.dylib arm64e  <f3afe30409793cba8338bebe9722ecd8> /usr/lib/system/libsystem_c.dylib
       0x1995a4000 -        0x1995bdfff libc++abi.dylib arm64e  <71b1e39fb291315daf46a4343e707387> /usr/lib/libc++abi.dylib
       0x19949a000 -        0x1994d3fff libobjc.A.dylib arm64e  <73e920f0e7ce394197d87a10dd2cd390> /usr/lib/libobjc.A.dylib
       0x1808e3000 -        0x180929fff libdispatch.dylib arm64e  <edd169e1d0db3808a19e99c1cd5a1c4c> /usr/lib/system/libdispatch.dylib
       0x1adeed000 -        0x1ae918fff SpringBoard arm64e  <5c15e883f98f3158987db1c70cf830c7> /System/Library/PrivateFrameworks/SpringBoard.framework/SpringBoard
       0x18608b000 -        0x186147fff BaseBoard arm64e  <12e6f6fa945831d2a05963fea728ed5c> /System/Library/PrivateFrameworks/BaseBoard.framework/BaseBoard
       0x183083000 -        0x18490dfff UIKitCore arm64e  <cd7f7ba2a2c63727aff69baab60cc6ab> /System/Library/PrivateFrameworks/UIKitCore.framework/UIKitCore
       0x1051a0000 -        0x105203fff dyld arm64e  <444f5041322e342e3300f611a6caa7e0> /private/preboot/<boot-hash>/dopamine-Jag4OU/procursus/basebin/gen/dyld
       0x1ab5f0000 -        0x1ab60afff KeyboardArbiter arm64e  <35c10c446873384690b8fed5ddb71429> /System/Library/PrivateFrameworks/KeyboardArbiter.framework/KeyboardArbiter
       0x1e8db7000 -        0x1e8dcffff SpotlightUI arm64e  <998810063c0235ecad350a237af8a812> /System/Library/PrivateFrameworks/SpotlightUI.framework/SpotlightUI
       0x1818ba000 -        0x182380fff libnetwork.dylib arm64e  <fb6fbf7c88273375a5006d440f277a49> /usr/lib/libnetwork.dylib
       0x1813f5000 -        0x1818b9fff CFNetwork arm64e  <b63d7160ebc33de7b98bca51e08b72f1> /System/Library/Frameworks/CFNetwork.framework/CFNetwork
       0x19971e000 -        0x19979cfff WeatherFoundation arm64e  <89fa5a3f30fb369aa367f04dc11f9d5a> /System/Library/PrivateFrameworks/WeatherFoundation.framework/WeatherFoundation
       0x1aee6e000 -        0x1aeef1fff Weather arm64e  <512b05b67f5f33b0a04da1e9b0421b7e> /System/Library/PrivateFrameworks/Weather.framework/Weather
       0x1823ff000 -        0x182705fff Foundation arm64e  <9618b2f2a4c23e07b7eed8d9e1bdeaec> /System/Library/Frameworks/Foundation.framework/Foundation
       0x18dc00000 -        0x18dc78fff SpringBoardServices arm64e  <bf41276800a33235afa1fe255c7d0bba> /System/Library/PrivateFrameworks/SpringBoardServices.framework/SpringBoardServices
       0x1ab3f3000 -        0x1ab55dfff UserNotificationsUIKit arm64e  <572dde2dc5fb3aa099e8e785a5fec16e> /System/Library/PrivateFrameworks/UserNotificationsUIKit.framework/UserNotificationsUIKit
       0x180bdc000 -        0x18102ffff CoreFoundation arm64e  <16faa70c278c3561859ecec407c2dc7c> /System/Library/Frameworks/CoreFoundation.framework/CoreFoundation
       0x18dc92000 -        0x18dfa1fff CoreMotion arm64e  <ca7e348ebfb037bdb4a8f549f5a8209d> /System/Library/Frameworks/CoreMotion.framework/CoreMotion
       0x109860000 -        0x109867fff samplecrash.dylib arm64e  <78b5afc206063c4598f5ee39c8a45d72> /private/preboot/<boot-hash>/dopamine-Jag4OU/procursus/usr/lib/TweakInject/samplecrash.dylib

Filtered syslog:
Timestamp                         Type Thread  Act Process[pid] (Sender)
2025-03-31 13:47:43.3453 -0400    info 0x352cd1 0x9db9b3 SpringBoard[30471] (ProactiveSupport): _PASDatabaseMigrator migrateDatabases called
2025-03-31 13:47:43.3454 -0400 default 0x352cd1 0x9db9b3 SpringBoard[30471] (ProactiveSupport): _PASDatabaseMigrator: <_PASDatabaseMigrator: <_PASDatabaseMigrationContext db:/var/mobile/Library/DuetExpertCenter/_ATXInfoSuggestionStore.db v:27 mc:27>>: done migrating
2025-03-31 13:47:43.3455 -0400 default 0x352c8b 0x9db9b2 SpringBoard[30471] (DoNotDisturb): Adding state update listener: listener=<SBIconController: 0x10608d600; orientation: UIInterfaceOrientationPortrait; model: <SBIconModel: 0x10d51a270; store: <SBDefaultIconModelStore: 0x28289c0a0; currentIconStateURL: file:///var/mobile/Library/SpringBoard/IconState.plist; desiredIconStateURL: file:///var/mobile/Library/SpringBoard/DesiredIconState.plist>; applicationDataSource: 0x10608d600; rootFolder: <SBRootFolderWithDock: 0x10c144750; displayName: Folder; listCount: 14; listGridSize: 4×6; iconGridSizeClassSizes: {small: 2×2, medium: 4×2, large: 4×4, extraLarge: 4×4, newsLargeTall: 4×6}>; visibleIconIdentifiers: {(...

/* Rest of syslog redacted for brevity */
```
Let's look at each section separately.
- The first section includes some identifiers about the crash report and the process that the crash happened in. As we can see, the `Process:` is `SpringBoard`, so we know that the crash happened in SpringBoard. We can also see the path to the process in the filesystem, labeled by `Path:`.
- We then have information about the device and when the crash happened. This has been redacted in the sample output.
- The third section is about the exception type. This specific crash happens to trigger an `EXC_CRASH (SIGABRT)` ([documentation](https://developer.apple.com/documentation/xcode/sigabrt)). This can help you identify the general cause of the crash. For example, if we have a `EXC_BAD_ACCESS` ([documentation](https://developer.apple.com/documentation/xcode/exc_bad_access)), then we know that the tweak is accessing invalid memory.
- The fourth section is extremely helpful for tweak development. The `Application Specific Information:` section can tell us in plain words what caused the crash. This speciic crashlog has this reason: `*** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[SBIconView nonexistentMethod]: unrecognized selector sent to instance 0x105926e00'`. The `unrecognized selector sent to instance` is a common crash that happens when working with undocumented APIs. The `- (void)nonexistentMethod` method, which we lied to the compiler about does not exist, so when we call the method, the Objective-C runtime causes a crash.
- The fifth section has a backtrace leading up to the crash. Essentially, a backtrace is the list of methods and functions that were called leading up to the crash. The bottom-most part of the backtrace (in this case line number 50, labeled `dyld`), is the beginning of the thread, and going up from there we go towards what caused the crash. On the left side, we can see the binary name. For example, some of the calls are marked in `UIKitCore`. This means that those calls were made in that framework. On line 6 we notice our `samplecrash.dylib`. This may indicate that the crash happened due to something in our code. Note that this may not always be the case. On a regular jailbroken device you may see other tweaks lower in the backtrace, but that does not necessarily mean that they caused the crash to happen. On the right, we see the method names leading up to the crash. For our `samplecrash.dylib`, we can see that it says `_logos_method$_ungrouped$SBIconView$didMoveToWindow`. As we can see, the crash is happening in our `-[SBIconView didMoveToWindow]` hook. Note that if the binary is stripped (compiled with `FINALPACKAGE=1`), we will not see a method name, rather an address in the binary.
- After the backtrace section we may see more threads. This can be helpful for seeing what the app was doing in the background when the crash happened.
- We then see the `Thread 0 crashed with ARM Thread State (64-bit):` section. This section contains the values of the ARM64 assembly registers at the time the crash happened. This can be helpful in more obscure crashes.
- Then we have the `Binary Images:` section. This section contains the binaries loaded at the time the crash happened. It includes the names of the binaries and their paths in the filesystem. The topmost binary is the one that was loaded first, the second is the one that was loaded second, and so on.
- Lastly, we have the `Filtered syslog:` section. This section contains a snapshot of all the logs that were passed to the system log leading up to the crash. This section may be helpful for analyzing events that happened in the binary before the crash occurred.

[Previous Page (Respringless Tweaks)](./respringless_tweaks.md)

[Next Page (Challenges)](./challenges.md)
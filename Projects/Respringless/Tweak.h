@import UIKit;


@interface _UIBackdropViewSettings : NSObject
+ (id)settingsForStyle:(NSInteger)style;
@end


@interface _UIBackdropView : UIView
- (id)initWithFrame:(CGRect)frame autosizesToFitSuperview:(BOOL)autosizes settings:(_UIBackdropViewSettings *)settings;
@end


@interface CSCoverSheetViewController: UIViewController
- (void)setupBlur;
@end


@interface NSDistributedNotificationCenter: NSNotificationCenter
@end

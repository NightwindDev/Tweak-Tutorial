#import <UIKit/UIKit.h>


@interface SBIconImageView : UIView
@end

@interface SBHomeScreenBackdropView : UIView
@end


%hook SBIconImageView

-(void)didMoveToWindow {
  self.alpha = 0.5;
  %orig;
}

%end


%hook SBHomeScreenBackdropView

-(void)didMoveToWindow {
  self.hidden = true;
  %orig;
}

%end=

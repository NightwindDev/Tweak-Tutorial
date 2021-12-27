#import <UIKit/UIKit.h>


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

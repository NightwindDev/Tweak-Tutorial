#import "Tweak.h"


static CGFloat blurIntensity = 0.85f;

static void loadPrefs(void) {

	NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:@"com.example.respringlesstweakprefs"];
	blurIntensity = [prefs objectForKey:@"blurIntensity"] ? [prefs floatForKey:@"blurIntensity"] : 0.85f;

}

%hook CSCoverSheetViewController

%property (nonatomic, strong) _UIBackdropView *blurView;

%new

- (void)setupBlur {

	_UIBackdropViewSettings *settings = [_UIBackdropViewSettings settingsForStyle:2];

	if(!self.blurView) {
		self.blurView = [[_UIBackdropView alloc] initWithFrame:CGRectZero autosizesToFitSuperview:YES settings:settings];
		self.blurView.alpha = blurIntensity;
		[self.view insertSubview:self.blurView atIndex:0];
	}

}

%new

- (void)updateBlurIntensity {

	loadPrefs();
	self.blurView.alpha = blurIntensity;

}

- (void)viewDidLoad {

	%orig;
	[self setupBlur];

	[NSDistributedNotificationCenter.defaultCenter addObserver:self selector:@selector(updateBlurIntensity) name:@"com.example.respringlesstweakprefs/DidUpdateBlurIntensityNotification" object: nil];

}

%end

%ctor {
	loadPrefs();
}

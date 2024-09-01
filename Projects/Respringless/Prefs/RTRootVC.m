#import "RTRootVC.h"

@implementation RTRootVC

- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	return _specifiers;

}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {

	NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName: @"com.example.respringlesstweakprefs"];
	[prefs setObject:value forKey:specifier.properties[@"key"]];

	[NSDistributedNotificationCenter.defaultCenter postNotificationName:@"com.example.respringlesstweakprefs/DidUpdateBlurIntensityNotification" object:nil];

	[super setPreferenceValue:value specifier:specifier];

}

@end

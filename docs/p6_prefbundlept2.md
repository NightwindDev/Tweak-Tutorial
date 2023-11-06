---
id: advanced_preferences
title: Preferences Continued
sidebar_position: 6
---

For the `Root.plist` file, you can find out what cells are available to use by default <a href="https://github.com/NightwindDev/Preference-Bundle-Example">here</a> and <a href="https://iphonedev.wiki/index.php/Preferences_specifier_plist">here</a>.

## `EXMRootListController.m`

```objc
#include "EXMRootListController.h" // better to change to #import

@implementation EXMRootListController

- (NSArray *)specifiers {
    if (!_specifiers) {
        _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
    }

    return _specifiers;
}

@end

```

This is the code of the view controller that displays when the user opens up the tweak settings page.

Let's go through it one by one.

- It is including the `EXMRootListController.h` header which contains the headers for this view controller.
  - The difference between `#include` and `#import` is that `#include` literally copies the contents of the header into the file, while `#import` makes sure to only include the contents of the header once.
- `@implementation`
  - This implements the view controller, basically allowing the developer to add methods and write the code for the view controller.
- `- (NSArray *)specifiers {`
  - This is the method holding all of the **specifiers**, i.e. the cells in the view controller.
- `_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];`
  - This line sets `_specifiers` to the specifiers which are in the `Root.plist`.
- `return _specifiers;`
  - This returns the specifiers because that is needed as the method is not of the type `void` (which does not need to return anything).

This also allows the developer to make cells manually, you would need to add the specifier manually through `PSSpecifier` and then add it to the `_specifiers` array.

- Further information about this can be found near the bottom of https://iphonedev.wiki/index.php/Preferences_specifier_plist.

Linking the preference bundle to the tweak can also be found in my preference bundle examples page: https://github.com/NightwindDev/Preference-Bundle-Example#linking-cells-to-tweak.

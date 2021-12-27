# How Do You Create a Tweak?

`%hookf` can be confusing at first, but it is pretty easy to understand once you get into it.

## What is `%hookf` used for?

While `%hook` is used to hook Objective-C classes, `%hookf` is used to hook C functions. It's syntax is also different from `%hook`.

## Syntax

```objc
%hookf(thing_hooked, symbol_name, arguments...) {...}
```

* `thing_hooked` - This is what you're hooking.
* `symbol_name` - This is the name of the function being hooked.
* `arguments` - These are the arguments that are passed into the function.

## Example

Let's say we want to hook <a href="https://developer.apple.com/documentation/coregraphics/1396330-cgfontcreatewithfontname?language=objc">`CGFontRef CGFontCreateWithFontName(CFStringRef name);`</a>. This would be done like so:

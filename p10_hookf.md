# How Do You Create a Tweak?

`%hookf` can be confusing at first, but it is pretty easy to understand once you get into it.

## What is `%hookf` used for?

While `%hook` is used to hook Objective-C classes, `%hookf` is used to hook C functions. It's syntax is also different from `%hook`.

## Syntax

```objc
%hookf(return_type, symbol_name, arguments...) {...}
```

* `return_type` - The return type of the function.
* `symbol_name` - This is the name of the function being hooked.
* `arguments` - These are the arguments that are passed into the function.

## Example

Let's say we want to hook <a href="https://developer.apple.com/documentation/coregraphics/1396330-cgfontcreatewithfontname?language=objc">`CGFontRef CGFontCreateWithFontName(CFStringRef name);`</a>. This would be done like so:

```objc
%hookf(CGFontRef, CGFontCreateWithFontName, CFStringRef name) {
  // code
  return %orig;
}
```

Below is the Substrate version of the above code, if needed.
```objc
CGFontRef (*orig_CGFontCreateWithFontName)(CFStringRef);
CGFontRef new_CGFontCreateWithFontName(CFStringRef name) {
  return orig_CGFontCreateWithFontName(name);
}

__attribute__((constructor)) static void initialize() {
  MSHookFunction(((void *)MSFindSymbol(NULL, "CGFontCreateWithFontName")), (void *)new_CGFontCreateWithFontName, (void **)&orig_CGFontCreateWithFontName);
}
```

For further information about `%hookf`, please go <a href="https://iphonedev.wiki/index.php/Logos">here</a>.

<a href="https://github.com/NightwindDev/Tweak-Tutorial/blob/main/p9_mshookivar.md">Previous Page (MSHookIvar)</a>

<a href="https://github.com/NightwindDev/Tweak-Tutorial/blob/main/p11_subclassWrapper.md">Next Page (%subclass Wrapper)</a>

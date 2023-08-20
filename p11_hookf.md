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

Let's say we want to hook [`CGFontRef CGFontCreateWithFontName(CFStringRef name);`](https://developer.apple.com/documentation/coregraphics/1396330-cgfontcreatewithfontname?language=objc). This would be done like so:

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

For further information about `%hookf`, please go [here](https://iphonedev.wiki/index.php/Logos).

[Previous Page (Adapting for rootless)](./p10_rootless.md)

[Next Page (`%subclass` Wrapper)](./p12_subclassWrapper.md)

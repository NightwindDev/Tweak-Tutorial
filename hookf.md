# How Do You Create a Tweak?

`%hookf` can be confusing at first, but it is pretty easy to understand once you get into it.

## What is `%hookf` used for?

While `%hook` is used to hook Objective-C classes, `%hookf` is used to hook C functions. Its syntax is also different from `%hook`.

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
static CGFontRef (*CGFontCreateWithFontName_orig)(CFStringRef) = NULL;
static CGFontRef CGFontCreateWithFontName_hook(CFStringRef name) {
  return CGFontCreateWithFontName_orig(name);
}

__attribute__((constructor)) static void initialize() {
  MSHookFunction(dlsym(RTLD_DEFAULT, "CGFontCreateWithFontName"), (void *)CGFontCreateWithFontName_hook, (void **)&CGFontCreateWithFontName_orig);
}
```

## Danger
Due to the previously mentioned [Spinlock panics](https://github.com/opa334/Dopamine/issues/274#issuecomment-1821038203) on iOS 15 arm64e devices, `%hookf`/`MSHookFunction` should be used with caution. When possible, look into alternative methods of achieving your esired goal in order for a better user experience for users on iOS 15 arm64e devices. 

For further information about `%hookf`, please go [here](https://theos.dev/docs/logos-syntax).

[Previous Page (Old ABI)](./oldabi.md)

[Next Page (`%subclass` Wrapper)](./subclass_wrapper.md)

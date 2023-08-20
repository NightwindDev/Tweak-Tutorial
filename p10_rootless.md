# Adapting for Rootless

### What is rootless?
- "rootless" is the term used for jailbreaks which do not have access to the root filesystem for whatever reason. This means that anything outside of `/var/` and `/private/preboot/` is not writable. However, the root **user** is still accessibly on a rootless jailbreak.

### How does this affect my tweak?
- Existing tweaks which do not support rootless will need some changes in order to work on a rootless jailbreak. For instance, preference bundles are stored in `/Library/PreferenceBundles/` on a traditional ("rootful") jailbreak. However, since a rootless jailbreak does not have the ability to write to outside of the aforementioned directories, there needs to be a change made to the path in order to work properly. On rootless jailbreaks, the jailbreak files are stored in `/var/jb/`. Thus, the path becomes `/var/jb/Library/PreferenceBundles/`. This is the main difference between "rootless" and "rootful" jailbreaks.

---

### How can I adapt my tweak for rootless?

Firsrly, it is best to always use the most up-to-date version of Theos. Make sure to update it if you installed Theos a while ago.

Theos includes convenient macros for you to use in order to adapt for rootless. They are stored in a header file called [rootless.h](https://github.com/theos/headers/blob/4c7409e29260a7c47a27d52531a0ebc4bc034e72/rootless.h) which is bundled in recent versions. Say we have a file path that needs to be adapted stored within an `NSString` like so:
```objc
NSString *filePath = @"/Library/Application Support/";
```

This particular directory *does* exist in non-jailbroken iOS. On "rootful" jailbreaks, tweaks can write to this directory to store files. However, on "rootless" jailbreaks, there is no ability to do that. So, rootless jailbreaks write to `/var/jb/Library/Application Support/`. So how can we include the `/var/jb/` part of the path when compiling for "rootless" but not "rootful?" Well, the macros make that process quite simple. In order to utilize the macros, you need to `#import <rootless.h>` at in your file. That will give you the ability to access the macros. Then, you can just wrap the path in the `ROOT_PATH_NS()` macro in order to adapt for "rootless" jailbreaks. So, it can be done as easily as this:

```objc
#import <rootless.h>

// ...

NSString *filePath = ROOT_PATH_NS(@"/Library/Application Support/");
```

The value of this string will be like so:
- "rootful": `/Library/Application Support/`
- "rootless": `/var/jb/Library/Application Support/`

---

Do note that some libraries also need to be updated for rootless, so that is something that needs to be taken into account.

---

More information about adapting for rootless can be found [here](https://theos.dev/docs/rootless).

---

[Previous Page (Advanced FLEX)](./p9_advanced_flex.md)

[Next Page (`%hookf`)](./p11_hookf.md)
![Gilt Tech logo](https://raw.githubusercontent.com/gilt/Cleanroom/master/Assets/gilt-tech-logo.png)

# CleanroomASL

CleanroomASL is an iOS framework providing a Swift-based API for writing to and reading from [the Apple System Log (ASL) facility](#about-the-apple-system-log).

CleanroomASL is designed as a thin wrapper around ASL’s native C API that makes use of Swift concepts where appropriate to make coding easier-to-understand and less error-prone.

CleanroomASL is part of [the Cleanroom Project](http://github.com/gilt/Cleanroom) from [Gilt Tech](http://tech.gilt.com).

### Who It’s For

If you need to read from your application’s log on the device, CleanroomASL is for you. CleanroomASL is also useful if you need low-level access to writing to the Apple System Log.

### Who It’s Not For

Because CleanroomASL is a low-level API, it may be cumbersome to use for common logging tasks.

If you’d like to use a simple, high-level Swift API for logging within your iOS application, consider using [the CleanroomLogger project]().

CleanroomLogger uses CleanroomASL under the hood, but provides a simpler API that will be more familiar to developers who’ve used other logging systems such as CocoaLumberjack or log4j.

CleanroomLogger is also extensible, allowing you to multiplex log output to multiple destinations and to add your own logger implementations.

### Pre-Release Software

CleanroomASL is in active development, and as such, it needs additional unit tests, more documentation, and probably a bit of debugging.

If you’d like to contribute to this or any other Cleanroom Project repo, please read the [contribution guidelines](https://github.com/gilt/Cleanroom#contributing-to-the-cleanroom-project).

CleanroomASL is pre-release software. It is provided for your use, free-of-charge and on an as-is basis. We make no guarantees, promises or apologies. *Caveat developer.*

### Requirements

CleanroomASL requires a **mimimum Xcode version of 6.3** to be built, and the resulting binary can be used on **iOS 8.1 and higher**.

**CleanroomASL is designed specificially to be used from Swift code.** Although you *may* be able to use some (or all) of it from Objective-C, we do not specifically support it and can’t provide any help or advice for doing so.

## Building

The `CleanroomASL.xcodeproj` project contains two targets: `CleanroomASL` and `CleanroomASLTests`.

`CleanroomASL` builds an iOS 8 framework.

`CleanroomASLTests` contains unit tests for the code in the framework.

## Integration

Adding third-party frameworks to your application can make development more complicated:

- Frameworks need to be built for a specific *processor architecture*; a framework built for an iPhone won’t work in the iOS Simulator and vice-versa
- Architectures can be combined using the command-line tool `lipo` to create what’s called a **fat binary**. Frameworks that contain fat binaries *will* work on the iPhone *and* in the simulator, but Apple won’t accept App Store submissions that use those fat binary frameworks.

Third-party frameworks are a new feature as of iOS 8, and the development and dependency-management workflow still isn’t very mature. As a result, **we do not recommend building the framework separately and including it in your project**.

Instead, we recommend embedding `CleanroomASL.xcodeproj` directly in your Xcode project.

This will ensure that CleanroomASL is built with the exact same settings you’re using for your app. You won’t have to fiddle with different settings for different architectures. You’ll also be able to step into CleanroomASL code directly in the debugger, which is very helpful.

### Embedding the needed frameworks

Once you’ve embedded `CleanroomASL.xcodeproj` in your project, you'll need to ensure that the necessary frameworks are listed in your target’s **Embedded Binaries** and **Linked Frameworks and Libraries** settings:

- `CleanroomASL.framework` — This is the CleanroomASL binary
- `CleanroomBase.framework` — This is the binary for [CleanroomBase](https://github.com/emaloney/CleanroomBase), which is a dependency of CleanroomASL. It is included as a submodule within CleanroomASL.

Once this is done, all you should need to do is add the following `import` to any Swift file where you want to use CleanroomASL:

```swift
import CleanroomASL
```

## About the Apple System Log

ASL may be most familiar to Mac and iOS developers as the subsystem that underlies the [`NSLog()`](https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Miscellaneous/Foundation_Functions/index.html#//apple_ref/c/func/NSLog) function.

When running within Xcode, `NSLog()` output shows up in the Console view.

On the Mac, messages written to ASL are available in the Console application.

For these reasons, people sometimes think of ASL as “the console,” even though that’s a bit of a misnomer:

- Xcode’s Console view shows the  `stdout` and `stderr` streams of the running process. Because `NSLog()` uses ASL configured in such a way that log messages are echoed to `stderr`, those messages show up in Xcode’s Console view. But the Console view can also show messages that *weren’t* sent through ASL.

- The Console application on the Mac can be thought of as a *viewer* for ASL log messages, but it only shows a subset of the information that can be sent along with an ASL message. Further, Console is not limited to ASL; it can also be used to follow the content of standard text log files.

### Learning more about ASL

Apple’s native API for ASL is written in C. The definitive documentation for ASL can be found in the manpage that can be accessed using the [`man 3 asl`](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man3/asl.3.html) Terminal command.

Peter Hosey’s *Idle Time* blog also has [a number of informative posts on ASL](http://boredzo.org/blog/archives/category/programming/apple-system-logger) helpful to anyone who wants to understand how it works.

## License

CleanroomASL is distributed under the [MIT license](LICENSE).

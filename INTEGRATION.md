![Gilt Tech logo](https://raw.githubusercontent.com/gilt/Cleanroom/master/Assets/gilt-tech-logo.png)

# CleanroomASL Integration Notes

This document describes how to integrate CleanroomASL into your application.

*Integration* is the act of embedding the `CleanroomASL.framework` binary (and its required dependencies) into your project and exposing the API it provides to your code.

Note that CleanroomASL is built as a *Swift framework*. This has several implications, not the least of which is that it will only work on iOS 8 or above. It is also only supported for use by other Swift code. Some, all or none of it may work from Objective-C; we haven't tried it, we wouldn't recommend it, and we don't support it.

### Requirements

CleanroomASL requires a **mimimum Xcode version of 6.3** to be built, and the resulting binary can be used on **iOS 8.1 and higher**.

### About Frameworks

Official support for third-party iOS frameworks was introduced with Xcode 6 and iOS 8. Prior to that, developers had been using frameworks in an unsupported fashion by placing shared libraries and resources inside a filesystem structure that mimicked that of the frameworks published by Apple.

Given that *real* third-party iOS framework support is still in its infancy, it should be no surprise that there are still kinks in the development process when using them:

- The iOS Simulator uses a different processor architecture than real devices. As a result, **frameworks compiled for device won't work in the simulator, and vice-versa**. Sure, you *could* use `lipo` to stitch together a universal binary and use that instead, but...

- **Apple will not accept App Store binaries containing iOS Simulator code.** That means if you go the universal binary route, now you need a custom build step to make the universal binary, and you need another step to un-make the universal binary when you're building for submission. Okay, well, why not just build *two* frameworks: one for the iOS Simulator and one for devices?

- **Xcode won't be happy if you import two separate frameworks with the same symbols.** Xcode won't notice that there really is no conflict because the frameworks are compiled for different processor architectures. All Xcode will care about is that you're importing two separate frameworks that both claim to have the same module name.

For these reasons, we do not release Cleanroom projects as framework binaries. Instead, we provide the source, the Xcode project file, and options for integrating so that you can use it from within your code and submit an app that Apple will accept. (Or, at the very least, if Apple *doesn't* accept your app, we don't want it to be the fault of *this* project!)

### Options for integration

There are two supported options for integration:

- **Manual integration** — The `CleanroomASL.xcodeproj` Xcode project file is embedded directly within your project. You then add `CleanroomASL.framework` and its dependencies to the *Embedded Binaries* and *Linked Frameworks and Libraries* sections under the *General* tab for your application target.

- **Carthage integration** — [Carthage](https://github.com/Carthage/Carthage) is a dependency package manager designed to build frameworks. To add CleanroomASL using Carthage, you would add `github "emaloney/CleanroomASL"` to your `Cartfile` and then issue the command `carthage update`.

Whether you choose one over the other largely depends on your preferences and—in the case of Carthage—whether you're already using that solution for other dependencies.

## Manual Integration

Manual integration involves embedding `CleanroomASL.xcodeproj` directly in your Xcode project.

This will ensure that CleanroomASL is built with the exact same settings you’re using for your app. You won’t have to fiddle with different settings for different architectures — when you're running in the simulator, it will work; when you then switch to building for device, it'll work, too.

You’ll also be able to step into CleanroomASL code directly in the debugger without worrying about `.dSYM` resolution, which is very helpful.

### The strategy

Manual integration is a bit involved, so here's an overview of what we'll be doing:

1. Adding the CleanroomASL repo as a submodule to your project

2. Embedding `CleanroomASL.xcodeproj` in your Xcode project

3. ???

4. *Profit!*

### Checking out the repo

The first thing you'll need to do is 


clone the repository locally. Because this repo contains submodules, you'll need to do a recursive clone:

```
git clone --recursive https://github.com/emaloney/CleanroomASL.git
```

### The Xcode Project

The `CleanroomASL.xcodeproj` project contains two targets: `CleanroomASL` and `CleanroomASLTests`.

`CleanroomASL` builds an iOS 8 framework.

`CleanroomASLTests` contains unit tests for the code in the framework.

### Embedding the needed frameworks

Once you’ve embedded `CleanroomASL.xcodeproj` in your project, you'll need to ensure that the necessary frameworks are listed in your target’s **Embedded Binaries** and **Linked Frameworks and Libraries** settings:

- `CleanroomASL.framework` — This is the CleanroomASL binary
- `CleanroomBase.framework` — This is the binary for [CleanroomBase](https://github.com/emaloney/CleanroomBase), which is a dependency of CleanroomASL. It is included as a submodule within CleanroomASL.

> **Important:** If multiple developers are working from the same project file, you will want to pay close attention to how Xcode adds the frameworks to the project.
>
> Sometimes, files get added using full paths or certain types of relative paths may specific to that development environment. When this happens, other developers using the project may see build errors related to being unable to locate these frameworks.
>
> The ideal way to reference each framework path is as "`$(BUILT_PRODUCTS_DIR)/CleanroomASL.framework`" and "`$(BUILT_PRODUCTS_DIR)/CleanroomBase.framework`".

*...more here...*



## Carthage Integration

*Coming soon!*

## Importing CleanroomASL

Once CleanroomASL has been successfully integrated, all you will need to do is add the following `import` statement to any Swift source file where you want to use CleanroomASL:

```swift
import CleanroomASL
```

*Happy coding!*

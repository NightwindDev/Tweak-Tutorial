---
id: flex_process
title: Process and Events
unlisted: true
---

<table>
  <thead>
    <tr>
      <th align="left">Label</th>
      <th align="left">Explanation</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>📡 Network History</td>
      <td>Shows the network history of the device.</td>
    </tr>
    <tr>
      <td>⚠ System Log</td>
      <td>Similar to the Console app on macOS, shows logs from os_log/NSLog.</td>
    </tr>
    <tr>
      <td>🚦 NSProcessInfo.processInfo</td>
      <td>Shows information about the current [process](https://developer.apple.com/documentation/foundation/nsprocessinfo?language=objc)</td>
    </tr>
    <tr>
      <td>💩 Heap Objects</td>
      <td>Allows the finding of objects which are currently in the [heap](https://stackoverflow.com/questions/79923/what-and-where-are-the-stack-and-heap)</td>
    </tr>
    <tr>
      <td>🔎 Address Explorer</td>
      <td>Allows the user to find objects at certain memory addresses. For example, a memory address could be 0x03a61efb and it would store an object. This object's methods could then be hooked for the desired outcome.</td>
    </tr>
    <tr>
      <td>📚 Runtime Browser</td>
      <td>
        Allows the user to browse the Objective-C runtime. Extremely useful if one wants to find classes, methods, etc. in there.

        **`Keyboard Button: *`**
        Allows the selection of specific dylibs or frameworks to browse the symbols of.

        **`Keyboard Button: .*`**
        Allows the user to browse specific class names in the runtime.
      </td>
    </tr>
  </tbody>
</table>
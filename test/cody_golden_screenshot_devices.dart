import 'package:flutter/cupertino.dart';
import 'package:golden_screenshot/golden_screenshot.dart';

enum CodyGoldenScreenshotDevices {
  /// An Android phone based on the Pixel 6 Pro.
  android(ScreenshotDevice(
    platform: TargetPlatform.android,
    resolution: Size(1440, 3120),
    pixelRatio: 10 / 3,
    goldenSubFolder: 'androidScreenshots/',
    frameBuilder: ScreenshotFrame.android,
  )),

  /// based on the iPhone 16
  newerIphone(ScreenshotDevice(
    platform: TargetPlatform.iOS,
    resolution: Size(1206, 2622),
    pixelRatio: 3,
    goldenSubFolder: 'iphoneScreenshots/',
    frameBuilder: ScreenshotFrame.newerIphone,
  )),

  /// iPad Pro 13" (M4),
  /// labelled on App Store Connect as iPad 13" Display.
  ///
  /// This is the newer type of iPad with thinner bezels and no home button.
  newerIpad(ScreenshotDevice(
    platform: TargetPlatform.iOS,
    resolution: Size(2064, 2752),
    pixelRatio: 2,
    goldenSubFolder: 'ipadScreenshots/',
    frameBuilder: ScreenshotFrame.newerIpad,
  ));

  const CodyGoldenScreenshotDevices(this.device);
  final ScreenshotDevice device;
}
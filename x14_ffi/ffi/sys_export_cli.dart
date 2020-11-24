import 'dart:io';

import 'win/export_cli.dart';

abstract class SysExportCLI {
  int getWindowHeight();
  int getWindowWidth();

  void enableRawMode();
  void disableRawMode();

  factory SysExportCLI() {
    if (Platform.isWindows) {
      return WindowsCLI();
    } else {}
    return null;
    // return TermLibUnix();
  }
}

import "package:flutter/material.dart";
import 'package:package_info_plus/package_info_plus.dart';

class PackageInformation{

  static PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

}
import 'package:cognizant_assessment/env/BuildEnvironment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'MyApp.dart';

void main() {
  BuildEnvironment.setEnvironment(Environment.DEV);
  runApp(const GetMaterialApp(home: MyApp()));
}

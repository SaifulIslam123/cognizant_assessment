import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../env/BuildEnvironment.dart';
import 'MyApp.dart';

void main() {
  BuildEnvironment.setEnvironment(Environment.PROD);
  runApp(const GetMaterialApp(home: MyApp()));
}

import 'package:sqlite_m8_demo/main.adapter.g.m8.dart';
import 'package:sqlite_m8_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() {
  enableFlutterDriverExtension();

  runApp(GymspectorApp(
      DatabaseProvider(DatabaseAdapter(InitMode.developmentAlwaysReinitDb))));
}

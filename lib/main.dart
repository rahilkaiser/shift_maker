import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'src/core/settings/settings_service.dart';

import 'src/root.dart';
import 'src/core/settings/settings_controller.dart';

import 'src/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(RootWidget(settingsController: settingsController));
}

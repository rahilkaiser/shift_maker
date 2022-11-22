import 'package:flutter/material.dart';
import 'src/core/settings/settings_service.dart';

import 'src/root.dart';
import 'src/core/settings/settings_controller.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(RootWidget(settingsController: settingsController));
}

import 'package:flutter/material.dart';

import 'components/manager_my_account_screen_body.dart';

class ManagerMyAccountScreen extends StatelessWidget {
  const ManagerMyAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ManagerMyAccountScreenBody(),
    );
  }
}

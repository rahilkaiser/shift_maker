import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/auth/auth_status_bloc/auth_status_bloc.dart';
import '../../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../../../routes/router.gr.dart';
import '../../../components/continue_button_component/continue_button_component.dart';
import 'profile_menu_item_component.dart';
import 'profile_pic_section_component.dart';

class ManagerProfileScreenBody extends StatelessWidget {
  const ManagerProfileScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfilePicSectionComponent(),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            ProfileMenuItem(
              text: "My Account",
              icon: Icon(Icons.account_circle),
              press: () {
                AutoRouter.of(context).push(const ManagerMyAccountRoute());
              },
            ),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            ProfileMenuItem(
              text: "Notifications",
              icon: Icon(Icons.notifications),
              press: () {},
            ),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            ProfileMenuItem(
              text: "Settings",
              icon: Icon(Icons.settings),
              press: () {},
            ),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            ProfileMenuItem(
              text: "Help Center",
              icon: Icon(Icons.headphones),
              press: () {},
            ),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: ContinueButtonComponent(
                text: 'Logout',
                onPressed: () {
                  BlocProvider.of<AuthStatusBloc>(context).add(const AuthStatusEvent.logout());
                },
                showSpinner: false,
              ),
            ),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
          ],
        ),
      ),
    );
  }
}

// child: Padding(
//   padding: CoreSpacingConstants.getCoreBodyContentPadding(size),
//   child: Container(
//     // color: Colors.red,
//     // width: double.maxFinite,
//     child: Column(
//       // crossAxisAlignment: CrossAxisAlignment.stretch,
//       // mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         const ProfilePicSectionComponent(),
//         Flexible(
//           flex: 2,
//           child: ContinueButtonComponent(
//             text: 'Logout',
//             onPressed: () {
//               BlocProvider.of<AuthStatusBloc>(context).add(const AuthStatusEvent.logout());
//             },
//             showSpinner: false,
//           ),
//         ),
//       ],
//     ),
//   ),
// ),

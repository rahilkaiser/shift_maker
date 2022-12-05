import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../application/current_user/current_user_watcher_bloc/current_user_watcher_bloc.dart';
import '../../../../../../../domain/entities/users/manager/manager_entity.dart';

class ManagerMyAccountScreenBody extends StatelessWidget {
  const ManagerMyAccountScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<CurrentUserWatcherBloc>().state as CurrentUserWatcherSuccessState;
    final user = state.userEntity as ManagerEntity;
    const double _sigmaX = 2.5; // from 0-10
    const double _sigmaY = 2.5; // from 0-10
    const double _opacity = 0.2; // from 0-1.0

    return SingleChildScrollView(
      child: Column(
        children: [
          //Section Profil bearbeiten


          // Abrechnung und Zahlungen
            //Zahlungsmethoden verwalten
            //Rechnungen und Transaktionen
            //Art der Rechnungszustellung

          //Rechnungen und Transaktionen


          // Vollversion freischalten
        ],
      ),
    );
  }
}

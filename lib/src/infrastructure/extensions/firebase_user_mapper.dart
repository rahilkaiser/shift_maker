import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/core/unique_id.dart';
import '../../domain/entities/user/user_entity.dart';
import '../../domain/entities/user/user_role.dart';

extension FirebaseUserMapper on User {
  Future<UserEntity> toEntity() async {
    // final userId = this.uid;
    // final firestore = serviceLocator<FirebaseFirestore>();
    //
    // final DocumentReference userDoc = await firestore.collection("users").doc(this.uid);
    //
    // final DocumentSnapshot snap = await userDoc.snapshots().first;
    //
    // final Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
    //
    // print("QEWEWEEW");
    // print(data);




    return UserEntity(
      id: UniqueId.fromUniqueString(uid),
      role: UserRole.MANAGER,
      email: '',
      phone: '',
    );
    // try {
    //   // Get reference to Firestore collection
    //
    //   print("QQQQQ");
    //   print(ManagerModel.fromFireStore(docSnap).toEntity());
    //   if (userData['role'] == UserRole.MANAGER) {
    //     return ManagerModel.fromFireStore(docSnap).toEntity();
    //   } else if (userData['role'] == UserRole.WORKER) {
    //     return WorkerModel.fromFireStore(docSnap).toEntity();
    //   }
    //
    //
    // } catch (e) {
    //   throw e;
    // }

    // print("Heloooooo");
    //
    //
  }
}

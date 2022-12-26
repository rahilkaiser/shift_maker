import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/unique_id.dart';
import '../../department/department_entity.dart';
import '../../user/user_entity.dart';

class WorkerEntity extends UserEntity {
  final String forename;
  final String surname;
  final List<String> docs;
  final List<DepartmentEntity> assignedDeparts;
  final DateTime? createdAt;
  final DateTime? birthDate;
  final DocumentReference? manager;
  final String? profileImage;

  WorkerEntity({
    required UniqueId id,
    required String role,
    required String email,
    required String phoneNumber,
    required this.forename,
    required this.surname,
    required this.profileImage,
    required this.manager,
    required this.docs,
    required this.assignedDeparts,
    required this.birthDate,
    required this.createdAt,
  }) : super(id: id, role: role, email: email, phone: phoneNumber);

  factory WorkerEntity.empty() => WorkerEntity(
        id: UniqueId(),
        profileImage: null,
        forename: "Quistis",
        surname: "Leonheart",
        phoneNumber: "0193482434",
        assignedDeparts: [],
        docs: [],
        createdAt: DateTime.now(),
        birthDate: null,
        manager: null,
        role: 'worker',
        email: '',
      );
}

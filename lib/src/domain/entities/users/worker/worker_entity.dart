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
  final DateTime? validUntil;
  final DateTime? birthDate;
  late  DocumentReference? manager;
  final String? profileImage;
  final String? description;
  final String preference;
  final int maxWorkDays;

  WorkerEntity({
    required UniqueId id,
    required String role,
    required String? email,
    required String? phoneNumber,
    required this.forename,
    required this.surname,
    required String? this.profileImage,
    this.manager,
    required this.docs,
    required this.assignedDeparts,
    required this.birthDate,
    required this.createdAt,
    required this.validUntil,
    required this.description,
    required this.preference,
    required this.maxWorkDays,
  }) : super(id: id, role: role, email: email, phoneNumber: phoneNumber);

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
        validUntil: null,
        description: '',
        preference: '',
        maxWorkDays: 15,
      );

  WorkerEntity copyWith({
    UniqueId? id,
    String? role,
    String? email,
    String? phoneNumber,
    String? forename,
    String? surname,
    List<String>? docs,
    List<DepartmentEntity>? assignedDeparts,
    DateTime? createdAt,
    DateTime? validUntil,
    DateTime? birthDate,
    DocumentReference? manager,
    String? profileImage,
    String? description,
    String? preference,
    int? maxWorkDays,
  }) {
    return WorkerEntity(
      id: id ?? this.id,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      forename: forename ?? this.forename,
      surname: surname ?? this.surname,
      docs: docs ?? this.docs,
      assignedDeparts: assignedDeparts ?? this.assignedDeparts,
      createdAt: createdAt ?? this.createdAt,
      validUntil: validUntil ?? this.validUntil,
      birthDate: birthDate ?? this.birthDate,
      manager: manager ?? this.manager,
      profileImage: profileImage ?? this.profileImage,
      description: description ?? this.description,
      preference: preference ?? this.preference,
      maxWorkDays: maxWorkDays ?? this.maxWorkDays,
    );
  }
}

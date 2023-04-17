import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../domain/entities/core/unique_id.dart';
import '../../../../domain/entities/department/department_entity.dart';
import '../../../../domain/entities/user/user_role.dart';
import '../../../../domain/entities/users/worker/worker_entity.dart';

class WorkerModel {
  final String id;
  final String email;
  final String phoneNumber;
  final String forename;
  final String surname;
  final String role;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? birthDate;
  final List<String> docs;
  final List<DepartmentEntity> assignedDeparts;
  final DocumentReference? manager;
  final String description;
  final String preference;
  final DateTime? validUntil;
  final int maxWorkDays;
  final dynamic serverTimeStamp;

  WorkerModel(
      {required this.id,
      required this.email,
      required this.phoneNumber,
      required this.forename,
      required this.surname,
      required this.role,
      required this.createdAt,
      required this.birthDate,
      required this.assignedDeparts,
      required this.docs,
      required this.profileImage,
      required this.manager,
      required this.description,
      required this.preference,
      required this.validUntil,
      required this.maxWorkDays,
      this.serverTimeStamp});

  factory WorkerModel.fromFireStore(DocumentSnapshot documentSnapshot) {
    final Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return WorkerModel.fromMap(data).copyWith(id: documentSnapshot.id);
  }

  WorkerEntity toEntity() {
    return WorkerEntity(
      id: UniqueId.fromUniqueString(this.id),
      email: this.email,
      phoneNumber: this.phoneNumber,
      forename: this.forename,
      surname: this.surname,
      role: UserRole.WORKER,
      manager: this.manager,
      assignedDeparts: this.assignedDeparts,
      birthDate: this.birthDate,
      createdAt: this.createdAt,
      docs: this.docs,
      profileImage: this.profileImage,
      description: this.description,
      preference: this.preference,
      validUntil: this.validUntil,
      maxWorkDays: this.maxWorkDays,
    );
  }

  factory WorkerModel.fromEntity(WorkerEntity workerEntity) {
    return WorkerModel(
      id: workerEntity.id.value,
      email: workerEntity.email,
      phoneNumber: workerEntity.phone,
      forename: workerEntity.forename,
      surname: workerEntity.surname,
      serverTimeStamp: FieldValue.serverTimestamp(),
      role: workerEntity.role,
      profileImage: workerEntity.profileImage,
      docs: workerEntity.docs,
      createdAt: workerEntity.createdAt,
      birthDate: workerEntity.birthDate,
      assignedDeparts: workerEntity.assignedDeparts,
      manager: workerEntity.manager,
      description: workerEntity.description,
      preference: workerEntity.preference,
      validUntil: workerEntity.validUntil,
      maxWorkDays: workerEntity.maxWorkDays,
    );
  }

  WorkerModel copyWith({
    String? id,
    String? email,
    String? phoneNumber,
    String? forename,
    String? surname,
    String? role,
    String? profileImage,
    DateTime? createdAt,
    DateTime? birthDate,
    List<String>? docs,
    List<DepartmentEntity>? assignedDeparts,
    DocumentReference? manager,
    String? description,
    String? preference,
    DateTime? validUntil,
    dynamic? serverTimeStamp,
  }) {
    return WorkerModel(
      id: id ?? this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      forename: forename ?? this.forename,
      surname: surname ?? this.surname,
      role: role ?? this.role,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      birthDate: birthDate ?? this.birthDate,
      docs: docs ?? this.docs,
      assignedDeparts: assignedDeparts ?? this.assignedDeparts,
      manager: manager ?? this.manager,
      description: description ?? this.description,
      preference: preference ?? this.preference,
      validUntil: validUntil ?? this.validUntil,
      maxWorkDays: maxWorkDays ?? this.maxWorkDays,
      serverTimeStamp: serverTimeStamp ?? this.serverTimeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'phoneNumber': this.phoneNumber,
      'forename': this.forename,
      'surname': this.surname,
      'role': this.role,
      'profileImage': this.profileImage,
      'createdAt': this.createdAt,
      'birthDate': this.birthDate,
      'docs': this.docs,
      'assignedDeparts': this.assignedDeparts,
      'manager': this.manager,
      'serverTimeStamp': this.serverTimeStamp,
      'preference': this.preference,
      'description': this.description,
      'maxWorkDays': this.maxWorkDays,
      'validUntil': this.validUntil,
    };
  }

  factory WorkerModel.fromMap(Map<String, dynamic> map) {
    var birthTmp = map['birthDate'];
    var createdAtTmp = map['createdAt'];
    var validUntilTmp = map['validUntil'];

    return WorkerModel(
      id: "",
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      forename: map['forename'] as String,
      surname: map['surname'] as String,
      role: map['role'] as String,
      profileImage: map['profileImage'] as String,
      birthDate: birthTmp != null ? DateTime.fromMicrosecondsSinceEpoch(birthTmp.microsecondsSinceEpoch) : null,
      createdAt: createdAtTmp != null ? DateTime.fromMicrosecondsSinceEpoch(createdAtTmp.microsecondsSinceEpoch) : null,
      docs: List.from(map['docs']),
      assignedDeparts: [],
      manager: map['manager'] as DocumentReference,
      validUntil: validUntilTmp != null ? DateTime.fromMicrosecondsSinceEpoch(validUntilTmp.microsecondsSinceEpoch) : null,
      description: map['description'] as String,
      preference: map['preference'] as String,
      maxWorkDays: map['maxWorkDays'] as int,
      serverTimeStamp: map['serverTimeStamp'] as dynamic,
    );
  }
}

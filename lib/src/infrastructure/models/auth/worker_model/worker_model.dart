import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../domain/entities/core/unique_id.dart';
import '../../../../domain/entities/user/user_role.dart';
import '../../../../domain/entities/users/worker/worker_entity.dart';

class WorkerModel {
  final String id;
  final String email;
  final String phoneNumber;
  final String forename;
  final String surname;
  final String role;
  final dynamic serverTimeStamp;

  WorkerModel({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.forename,
    required this.surname,
    required this.role,
    this.serverTimeStamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'phoneNumber': this.phoneNumber,
      'forename': this.forename,
      'surname': this.surname,
      'role': this.role,
      'serverTimeStamp': this.serverTimeStamp,
    };
  }

  factory WorkerModel.fromMap(Map<String, dynamic> map) {
    return WorkerModel(
      id: "",
      email: map['email'] as String,
      phoneNumber: map['phone_number'] as String,
      forename: map['forename'] as String,
      surname: map['surname'] as String,
      role: map['role'] as String,
      serverTimeStamp: map['serverTimeStamp'] as dynamic,
    );
  }

  WorkerModel copyWith({
    String? id,
    String? email,
    String? phoneNumber,
    String? forename,
    String? surname,
    String? role,
    dynamic? serverTimeStamp,
  }) {
    return WorkerModel(
      id: id ?? this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      forename: forename ?? this.forename,
      surname: surname ?? this.surname,
      role: role ?? this.role,
      serverTimeStamp: serverTimeStamp ?? this.serverTimeStamp,
    );
  }

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
    );
  }

  factory WorkerModel.fromEntity(WorkerEntity workerEntity) {
    return WorkerModel(
      id: workerEntity.id.value,
      email: workerEntity.email,
      phoneNumber: workerEntity.phoneNumber,
      forename: workerEntity.forename,
      surname: workerEntity.surname,
      serverTimeStamp: FieldValue.serverTimestamp(),
      role: workerEntity.role,
    );
  }
}

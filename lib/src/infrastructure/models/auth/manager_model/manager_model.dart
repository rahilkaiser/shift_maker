import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../domain/entities/core/unique_id.dart';
import '../../../../domain/entities/user/user_role.dart';
import '../../../../domain/entities/users/manager/manager_entity.dart';

class ManagerModel {
  final String id;
  final String email;
  final String name;
  final String role;
  final String phone;
  final dynamic serverTimeStamp;

  ManagerModel({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.phone,
    this.serverTimeStamp,
  });

  factory ManagerModel.fromFireStore(DocumentSnapshot documentSnapshot) {
    final Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    ManagerModel result = ManagerModel.fromMap(data).copyWith(id: documentSnapshot.id);
    return result;
  }

  ManagerEntity toEntity() {
    return ManagerEntity(
      id: UniqueId.fromUniqueString(this.id),
      email: this.email,
      name: this.name,
      role: this.role,
      phone: this.phone,
    );
  }

  factory ManagerModel.fromEntity(ManagerEntity managerEntity) {
    return ManagerModel(
      id: managerEntity.id.value,
      email: managerEntity.email,
      name: managerEntity.name,
      phone: managerEntity.phone,
      role: managerEntity.role,
      serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  ManagerModel copyWith({
    String? id,
    String? email,
    String? name,
    String? role,
    String? phone,
    dynamic? serverTimeStamp,
  }) {
    return ManagerModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      serverTimeStamp: serverTimeStamp ?? this.serverTimeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'name': this.name,
      'role': this.role,
      'phoneNumber': this.phone,
      'serverTimeStamp': this.serverTimeStamp,
    };
  }

  factory ManagerModel.fromMap(Map<String, dynamic> map) {
    return ManagerModel(
      id: "",
      email: map['email'] as String,
      name: map['name'] as String,
      role: map['role'] as String,
      phone: map['phoneNumber'] as String,
      serverTimeStamp: map['serverTimeStamp'] as dynamic,
    );
  }
}

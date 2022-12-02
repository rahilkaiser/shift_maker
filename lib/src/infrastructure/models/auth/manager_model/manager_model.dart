import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../domain/entities/core/unique_id.dart';
import '../../../../domain/entities/user/user_role.dart';
import '../../../../domain/entities/users/manager/manager_entity.dart';

class ManagerModel {
  final String id;
  final String email;
  final String name;
  final dynamic serverTimeStamp;

  ManagerModel({
    required this.id,
    required this.email,
    required this.name,
    this.serverTimeStamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'name': this.name,
      'serverTimeStamp': this.serverTimeStamp,
    };
  }

  factory ManagerModel.fromMap(Map<String, dynamic> map) {
    return ManagerModel(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      serverTimeStamp: map['serverTimeStamp'] as dynamic,
    );
  }

  ManagerModel copyWith({
    String? id,
    String? email,
    String? name,
    dynamic? serverTimeStamp,
  }) {
    return ManagerModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      serverTimeStamp: serverTimeStamp ?? this.serverTimeStamp,
    );
  }

  factory ManagerModel.fromFireStore(QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return ManagerModel.fromMap(documentSnapshot.data()).copyWith(id: documentSnapshot.id);
  }

  ManagerEntity toEntity() {
    return ManagerEntity(
      id: UniqueId.fromUniqueString(this.id),
      email: this.email,
      name: this.name,
      role: UserRole.MANAGER,
    );
  }

  factory ManagerModel.fromEntity(ManagerEntity departmentEntity) {
    return ManagerModel(
      id: departmentEntity.id.value,
      email: departmentEntity.email,
      name: departmentEntity.name,
      serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }
}

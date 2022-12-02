import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/core/unique_id.dart';
import '../../../domain/entities/department/department_entity.dart';

class DepartmentModel {
  final String id;
  final String label;
  final String description;
  final dynamic serverTimeStamp;

  DepartmentModel({required this.id, required this.label, required this.description, this.serverTimeStamp});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'label': this.label,
      'description': this.description,
      'serverTimeStamp': this.serverTimeStamp,
    };
  }

  factory DepartmentModel.fromMap(Map<String, dynamic> map) {
    return DepartmentModel(
      id: "",
      label: map['label'] as String,
      description: map['description'] as String,
      serverTimeStamp: map['serverTimeStamp'] as dynamic,
    );
  }

  DepartmentModel copyWith({
    String? id,
    String? label,
    String? description,
    dynamic? serverTimeStamp,
  }) {
    return DepartmentModel(
      id: id ?? this.id,
      label: label ?? this.label,
      description: description ?? this.description,
      serverTimeStamp: serverTimeStamp ?? this.serverTimeStamp,
    );
  }

  factory DepartmentModel.fromFireStore(QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return DepartmentModel.fromMap(documentSnapshot.data()).copyWith(id: documentSnapshot.id);
  }

  DepartmentEntity toEntity() {
    return DepartmentEntity(
        id: UniqueId.fromUniqueString(this.id), label: label, description: this.description);
  }

  factory DepartmentModel.fromEntity(DepartmentEntity departmentEntity) {
    return DepartmentModel(
      id: departmentEntity.id.value,
      label: departmentEntity.label,
      description: departmentEntity.description,
      serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }
}

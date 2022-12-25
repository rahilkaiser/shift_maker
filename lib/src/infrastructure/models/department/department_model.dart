import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/core/unique_id.dart';
import '../../../domain/entities/department/department_entity.dart';

class DepartmentModel {
  final String id;
  final String label;
  final String description;
  final String address;
  final DateTime? begin;
  final DateTime? end;
  final List<String> images;
  final DocumentReference? manager;
  final dynamic serverTimeStamp;

  DepartmentModel({
    required this.id,
    required this.label,
    required this.description,
    required this.address,
    required this.begin,
    required this.end,
    required this.images,
    required this.manager,
    this.serverTimeStamp,
  });

  factory DepartmentModel.fromFireStore(QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return DepartmentModel.fromMap(documentSnapshot.data()).copyWith(id: documentSnapshot.id);
  }

  DepartmentEntity toEntity() {
    var entity = DepartmentEntity(
      id: UniqueId.fromUniqueString(this.id),
      label: label,
      description: this.description,
      address: this.address,
      begin: this.begin,
      end: this.end,
      images: this.images,
      manager: this.manager,
    );

    return entity;
  }

  factory DepartmentModel.fromEntity(DepartmentEntity departmentEntity) {
    return DepartmentModel(
      id: departmentEntity.id.value,
      label: departmentEntity.label,
      description: departmentEntity.description,
      address: departmentEntity.address,
      begin: departmentEntity.begin,
      end: departmentEntity.end,
      images: departmentEntity.images,
      manager: departmentEntity.manager,
      serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  DepartmentModel copyWith({
    String? id,
    String? label,
    String? description,
    String? address,
    DateTime? begin,
    DateTime? end,
    DocumentReference? manager,
    List<String>? images,
    dynamic? serverTimeStamp,
  }) {
    return DepartmentModel(
      id: id ?? this.id,
      label: label ?? this.label,
      description: description ?? this.description,
      address: address ?? this.address,
      begin: begin ?? this.begin,
      end: end ?? this.end,
      images: images ?? this.images,
      manager: manager ?? this.manager,
      serverTimeStamp: serverTimeStamp ?? this.serverTimeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'label': this.label,
      'description': this.description,
      'address': this.address,
      'begin': this.begin,
      'end': this.end,
      'images': this.images,
      'manager': this.manager,
      'serverTimeStamp': this.serverTimeStamp,
    };
  }

  factory DepartmentModel.fromMap(Map<String, dynamic> map) {
    // print(map['images']);
    var beginTmp = map['begin'];
    var endTmp = map['end'];
    return DepartmentModel(
      id: "",
      label: map['label'] as String,
      description: map['description'] as String,
      address: map['address'] as String,
      begin: beginTmp != null ? DateTime.fromMicrosecondsSinceEpoch(beginTmp.microsecondsSinceEpoch) : null,
      end: endTmp != null ? DateTime.fromMicrosecondsSinceEpoch(endTmp.microsecondsSinceEpoch) : null,
      images: List.from(map['images']),
      manager: map['manager'],
      serverTimeStamp: map['serverTimeStamp'] as dynamic,
    );
  }
}

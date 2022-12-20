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
  final dynamic serverTimeStamp;

  DepartmentModel({
    required this.id,
    required this.label,
    required this.description,
    required this.address,
    required this.begin,
    required this.end,
    required this.images,
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
      'serverTimeStamp': this.serverTimeStamp,
    };
  }

  factory DepartmentModel.fromMap(Map<String, dynamic> map) {
    print(map['images']);
    Timestamp beginTmp = map['begin'];
    Timestamp endTmp = map['end'];
    return DepartmentModel(
      id: "",
      label: map['label'] as String,
      description: map['description'] as String,
      address: map['address'] as String,
      begin: DateTime.fromMicrosecondsSinceEpoch(beginTmp.microsecondsSinceEpoch),
      end: DateTime.fromMicrosecondsSinceEpoch(endTmp.microsecondsSinceEpoch),
      images: List.from(map['images']),
      serverTimeStamp: map['serverTimeStamp'] as dynamic,
    );
  }
}

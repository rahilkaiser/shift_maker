import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/unique_id.dart';

part 'department_entity.freezed.dart';

@freezed
class DepartmentEntity with _$DepartmentEntity {
  const factory DepartmentEntity({
    required UniqueId id,
    required String label,
    required String description,
    required String address,
    required DateTime? begin,
    required DateTime? end,
    required List<String> images,
    required DocumentReference? manager,
  }) = _DepartmentEntity;

  factory DepartmentEntity.empty() => DepartmentEntity(
    id: UniqueId(),
    label: "",
    description: "",
    address: "",
    begin: null,
    end: null,
    images: [],
    manager: null
  );
}

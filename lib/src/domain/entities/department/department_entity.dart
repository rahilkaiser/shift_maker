import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/unique_id.dart';

part 'department_entity.freezed.dart';

@freezed
class DepartmentEntity with _$DepartmentEntity {
  const factory DepartmentEntity({
    required UniqueId id,
    required String label,
    required String description,
  }) = _DepartmentEntity;

  factory DepartmentEntity.empty() => DepartmentEntity(
    id: UniqueId(),
    label: "",
    description: "",
  );
}

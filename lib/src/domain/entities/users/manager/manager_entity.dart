import '../../core/unique_id.dart';
import '../../user/user_entity.dart';

class ManagerEntity extends UserEntity {
  final String name;

  ManagerEntity({
    required UniqueId id,
    required String role,
    required String email,
    required String phone,
    required this.name,
  }) : super(
          id: id,
          role: role,
          email: email,
          phone: phone,
        );
}

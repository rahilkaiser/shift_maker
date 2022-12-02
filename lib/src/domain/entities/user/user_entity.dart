import '../core/unique_id.dart';

class UserEntity {
  final UniqueId id;
  final String role;
  final String email;


  UserEntity({
    required this.id,
    required this.role,
    required this.email,
  });
}

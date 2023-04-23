import '../core/unique_id.dart';

class UserEntity {
  final UniqueId id;
  final String role;
  final String? email;
  final String? phoneNumber;


  UserEntity({
    required this.id,
    required this.role,
    required this.email,
    required this.phoneNumber,
  });
}

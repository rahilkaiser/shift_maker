import '../../core/unique_id.dart';
import '../../user/user_entity.dart';

class WorkerEntity extends UserEntity {
  final String phoneNumber;
  final String forename;
  final String surname;

  WorkerEntity({
    required UniqueId id,
    required String role,
    required String email,
    required this.phoneNumber,
    required this.forename,
    required this.surname,
  }) : super(
          id: id,
          role: role,
          email: email,
        );
}

import 'package:uuid/uuid.dart';

class UniqueId {
  final String value;

  const UniqueId._(this.value);

  factory UniqueId() {
    return UniqueId._(const Uuid().v1());
  }

  factory UniqueId.fromUniqueString(String? uniqueId) {
    assert(uniqueId != null);
    return UniqueId._(
      uniqueId!,
    );
  }
}

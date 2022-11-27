abstract class AuthFailure {}

class ServerFailure extends AuthFailure {}

// Registration
class EmailAlreadyInUseFailure extends AuthFailure {}

class InvalidEmailFailure extends AuthFailure {}

class OperationNotAllowedFailure extends AuthFailure {}

class WeakPasswordFailure extends AuthFailure {}

// Login
class InvalidEmailAndPasswordCombinationFailure extends AuthFailure {}

class UserDisabledFailure extends AuthFailure {}

class UserNotFoundFailure extends AuthFailure {}

import 'package:flutter/cupertino.dart';

class AuthenticationInputValidators {
  static RegExp get _emailValidatorRegExp => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static String get _kEmailNullError => "Please Enter your email";

  static String get _kInvalidEmailError => "Please Enter Valid Email";

  static String get _kPassNullError => "Please Enter your password";

  static String get _kShortPassError => "Password is too short";

  static String get _kMatchPassError => "Passwords don't match";

  static String get _kNamelNullError => "Please Enter your name";

  static String get _kPhoneNumberNullError => "Please Enter your phone number";

  static String get _kAddressNullError => "Please Enter your address";

  static GlobalKey<FormState> get formKey => GlobalKey<FormState>();

  AuthenticationInputValidators._();

  /// Validates Email-Address
  ///
  ///
  static String? validateEmail(String? input) {
    if (input == null || input.isEmpty) {
      return _kEmailNullError;
    } else if (_emailValidatorRegExp.hasMatch(input)) {
      return null;
    } else {
      return _kInvalidEmailError;
    }
  }

  /// Validates Password
  ///
  ///
  static String? validatePassword(String? input) {
    if (input == null || input.isEmpty) {
      return _kPassNullError;
    } else if (input.length < 8) {
      return _kShortPassError;
    }
    return null;
  }

  /// Validates Confirmation-Password
  ///
  ///
  static String? validateConfirmPassword(String? input, String? password) {
    if (input == null || input.isEmpty) {
      return _kPassNullError;
    } else if (password != input) {
      return _kMatchPassError;
    }
    return null;
  }
}

import 'package:broke_student_brokers/pages/authenticate/register.dart';
import 'package:broke_student_brokers/pages/authenticate/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // test('title', () {
  //   //Setup

  //   //run

  //   // verify
  // });

  test('Sign-in Empty email returns error string', () {
    var result = EmailFieldValidator.validate('');
    expect(result, 'Enter an email');
  });

  test('Sign-in Non-empty email returns null', () {
    var result = EmailFieldValidator.validate('email');
    expect(result, null);
  });

  test('Sign-in Empty password returns error string', () {
    var result = PasswordFieldValidator.validate('');
    expect(result, 'Password must be at least 6 characters long');
  });

  test('Sign-in Non-empty password returns null', () {
    var result = PasswordFieldValidator.validate('password1234');
    expect(result, null);
  });

  test('Register Empty email returns error string', () {
    var result = RegisterEmailFieldValidator.validate('');
    expect(result, 'Enter an email');
  });

  test('Register Non-empty email returns null', () {
    var result = RegisterEmailFieldValidator.validate('email');
    expect(result, null);
  });

  test('Register Empty password returns error string', () {
    var result = RegisterPasswordFieldValidator.validate('');
    expect(result, 'Password must be at least 6 characters long');
  });

  test('Non-empty password returns null', () {
    var result = RegisterPasswordFieldValidator.validate('password1234');
    expect(result, null);
  });
}

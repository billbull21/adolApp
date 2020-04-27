import 'dart:io';

import 'package:adolapp/helpers/toastHelper.dart';
import 'package:validators/validators.dart';

String commonValidator(String input) {
  if (input.trim().isEmpty) {
    return "field cannot be empty!";
  }
  return null;
}

String urlValidator(String input) {
  if (!isURL(input)) {
    return "please, enter a valid URL image!";
  }
  return null;
}

String emailValidator(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty) return '*Email is required';
  if (!regex.hasMatch(value))
    return '*Enter a valid email';
  else
    return null;
}

String passwordValidator(String value) {
  if (value.isEmpty) return '*Password is required';
  if (value.length < 6)
    return '*at least 6 characters';
  else
    return null;
}

String confirmPasswordValidator(String value, String passValue) {
  if (value.isEmpty) return '*Password is required';
  if (value != passValue) {
    return "*Confirm password not match";
  } else
    return null;
}

// firebase auth
enum authProblems { UserNotFound, PasswordNotValid, UserNotVerified, CredentialInUse }
void firebaseAuthErrorHandling(e) {
  authProblems errorType;
  if (Platform.isAndroid) {
    switch (e.code) {
      case 'ERROR_USER_NOT_FOUND':
        errorType = authProblems.UserNotFound;
        showDangerToast("User Not Found!");
        break;
      case 'ERROR_WRONG_PASSWORD':
        errorType = authProblems.PasswordNotValid;
        showDangerToast("Password not valid!");
        break;
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        errorType = authProblems.CredentialInUse;
        showDangerToast("The email was already registered!");
        break;
      case '401':
        errorType = authProblems.UserNotVerified;
        showWarningToast("Email was not verified yet!");
        break;
    // ...
      default:
        showDangerToast("Failed to connect!");
        print('Case ${e.message} is not yet implemented ; ${e.code}');
    }
  } else if (Platform.isIOS) {
    switch (e.code) {
      case 'Error 17011':
        errorType = authProblems.UserNotFound;
        showDangerToast("User Not Found!");
        break;
      case 'Error 17009':
        errorType = authProblems.PasswordNotValid;
        showDangerToast("Password not valid!");
        break;
        // TODO : ADD HANDLER FOR DUPLICATE EMAIL ERROR.
      case '401':
        errorType = authProblems.UserNotVerified;
        showWarningToast("Email was not verified yet!");
        break;
      default:
        showDangerToast("Failed to connect!");
        print('Case ${e.message} is not yet implemented');
    }
  }
  print('The error is $errorType : ${e.code}');
}
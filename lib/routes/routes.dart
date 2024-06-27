import 'package:flutter/material.dart';
import 'package:my_list/components/views/password_reset_email_message.dart';
import 'package:my_list/components/views/todo_details_view.dart';
import 'package:my_list/constants/constants.dart';
import 'package:my_list/models/todo_model.dart';

abstract class Routes {
  static void navigateToHomeScreen({required BuildContext buildContext}) {
    Navigator.of(buildContext).pushNamedAndRemoveUntil(
      Constants.homescreen,
      (route) => false,
    );
  }

  static void navigateToLoginScreen({required BuildContext buildContext}) {
    Navigator.of(buildContext).pushNamedAndRemoveUntil(
      Constants.login,
      (route) => false,
    );
  }

  static void navigateToSignUpScreen({required BuildContext buildContext}) {
    Navigator.of(buildContext).pushNamed(Constants.signUP);
  }

  static void navigateToPasswordResetEmailMessageView({
    required BuildContext buildContext,
    required String email,
  }) {
    Navigator.of(buildContext).push(
      MaterialPageRoute(
        builder: (context) => PasswordResetEmailMessageView(email: email),
      ),
    );
  }

  static void navigateToTodoDetailsView({
    required BuildContext buildContext,
    required String id,
    required Todo todo,
  }) {
    Navigator.of(buildContext).push(
      MaterialPageRoute(
        builder: (context) => TodoDetailsView(
          id: id,
          todo: todo,
        ),
      ),
    );
  }

  static void navigateToSettingsPage({required BuildContext context}) {
    Navigator.of(context).pushNamed(Constants.settings);
  }
}

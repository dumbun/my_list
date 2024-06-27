import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_list/components/widgets/input_text_field_widget.dart';
import 'package:my_list/main.dart';
import 'package:my_list/routes/routes.dart';

class PasswordResetView extends StatefulWidget {
  const PasswordResetView({super.key});

  @override
  State<PasswordResetView> createState() => _PasswordResetViewState();
}

class _PasswordResetViewState extends State<PasswordResetView> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _lodingState = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _navigateToMessageView() {
    Routes.navigateToPasswordResetEmailMessageView(
      buildContext: context,
      email: _emailController.text,
    );
  }

  void _showDilog(String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Text(error),
      ),
    );
  }

  void _sendResetPasswordEmail() async {
    if (_formKey.checkValidation) {
      setState(() {
        _lodingState = true;
      });
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text,
        );
        setState(() {
          _lodingState = false;
        });
        _navigateToMessageView();
      } on FirebaseException catch (e) {
        _showDilog(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(22),
          alignment: Alignment.center,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 320,
                    child: InputTextField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return "Please input your email";
                          } else if (value.isEmail == false) {
                            return "Please input correct email";
                          } else {
                            return null;
                          }
                        } else {
                          return "Please input ypur email";
                        }
                      },
                      border: true,
                      hintText: "Please enter your email",
                      controller: _emailController,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Visibility(
                    visible: _lodingState,
                    replacement: ElevatedButton(
                      onPressed: _sendResetPasswordEmail,
                      child: const Text("Send reset password email"),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

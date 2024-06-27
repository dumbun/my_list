import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_list/constants/constants.dart';
import 'package:my_list/database/firebase_helper.dart';
import 'package:my_list/main.dart';
import 'package:my_list/routes/routes.dart';
import 'package:my_list/utility.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = true;

  void _loginWithGoogle() {
    Utility.signInWithGoogle().then((UserCredential? value) {
      if (value != null) {
        Routes.navigateToHomeScreen(buildContext: context);
      }
    });
  }

  void _loginWithCredentials() {
    if (_formKey.checkValidation) {
      try {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailControler.text, password: _passwordController.text)
            .then(
          (UserCredential userCredential) async {
            Routes.navigateToHomeScreen(buildContext: context);
            if (userCredential.user != null &&
                userCredential.user?.email != null) {
              Backend.addNewUser(userCredential.user!.email!);
            }
          },
        );
      } on FirebaseAuthException catch (e) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog.adaptive(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  void _navigateToResetPasswordPage(BuildContext context) {
    Navigator.of(context).pushNamed(Constants.passwordResetView);
  }

  @override
  void dispose() {
    _emailControler.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 320,
                  child: TextFormField(
                    enableSuggestions: true,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailControler,
                    validator: (String? value) {
                      if (value != null) {
                        return value.isEmail
                            ? null
                            : 'Please enter the valid email';
                      } else {
                        return "Please input the email";
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Email"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: 320,
                  child: TextFormField(
                    enableSuggestions: true,
                    obscureText: _showPassword,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: const Text("Password"),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _loginWithCredentials(),
                      child: const Text("Login"),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      style: const ButtonStyle(
                        foregroundColor: WidgetStatePropertyAll(Colors.blue),
                      ),
                      onPressed: () => _navigateToResetPasswordPage(context),
                      child: const Text("Forget Password"),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () => _loginWithGoogle(),
                  child: const Card(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Image(
                        height: 32,
                        image: AssetImage("assets/icons/google.png"),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () =>
                      Routes.navigateToSignUpScreen(buildContext: context),
                  child: const Text("Create New Account"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_list/database/firebase_helper.dart';
import 'package:my_list/main.dart';
import 'package:my_list/routes/routes.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isSame = false;

  @override
  void dispose() {
    _emailControler.dispose();
    _password2Controller.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp() async {
    if (_formKey.checkValidation) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailControler.text,
          password: _passwordController.text,
        );
        await Backend.addNewUser(_emailControler.text);

        _navigateToHomeScreen();
      } on FirebaseAuthException catch (e) {
        showDialog<String>(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) => AlertDialog.adaptive(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  void _navigateToHomeScreen() {
    Routes.navigateToHomeScreen(buildContext: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 320,
                    child: TextFormField(
                      controller: _emailControler,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) => value != null
                          ? value.isEmail
                              ? null
                              : "Please enter valid email"
                          : "Please enter your email",
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Email"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 320,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _isSame = _password2Controller.text == _passwordController.text;
                        });
                      },
                      controller: _passwordController,
                      autocorrect: false,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("password"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 320,
                    child: TextFormField(
                      controller: _password2Controller,
                      onChanged: (value) {
                        setState(() {
                          _isSame = _password2Controller.text == _passwordController.text;
                        });
                      },
                      autocorrect: false,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("re-enter your password"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _isSame ? const Text("Password matched") : const Text("Password not Mateched"),
                      const SizedBox(width: 12.0),
                      _isSame
                          ? const Icon(
                              Icons.beenhere,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.warning,
                              color: Colors.redAccent,
                            )
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  ElevatedButton(
                    onPressed: _signUp,
                    child: const Text("Sign Up"),
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => Routes.navigateToLoginScreen(buildContext: context),
                        child: const Text(
                          "Go back to Login",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

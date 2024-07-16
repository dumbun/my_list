import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_list/components/views/add_new_todo_view.dart';
import 'package:my_list/components/views/all_todos_view.dart';
import 'package:my_list/components/views/completed_todos_view.dart';
import 'package:my_list/components/views/homepage.dart';
import 'package:my_list/components/views/important_todos_view.dart';
import 'package:my_list/components/views/incompleted_todos_view.dart';
import 'package:my_list/components/views/login_page.dart';
import 'package:my_list/components/views/password_reset_view.dart';
import 'package:my_list/components/views/settings_view.dart';
import 'package:my_list/components/views/sign_up_page.dart';
import 'package:my_list/constants/constants.dart';
import 'firebase_options.dart';

//extentions

extension EmailChecking on String {
  bool get isEmail => RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(this);
}

extension FormValidation on GlobalKey<FormState> {
  bool get checkValidation => currentState!.validate();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: "key.env");
  GoogleFonts();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return MaterialApp(
      navigatorKey: navigatorKey,
      routes: <String, Widget Function(BuildContext)>{
        Constants.login: (BuildContext context) => const LoginPage(),
        Constants.signUP: (BuildContext context) => const SignUpPage(),
        Constants.homescreen: (BuildContext context) => const MyHomePage(),
        Constants.settings: (BuildContext context) => const SettingsView(),
        Constants.addNewTodoPage: (BuildContext context) => const AddNewTodoView(),
        Constants.incompletedTodosView: (BuildContext context) => const IncompletedTodosView(),
        Constants.completedTodosView: (BuildContext context) => const CompletedTodosView(),
        Constants.importantTodosView: (BuildContext context) => const ImportantTodosView(),
        Constants.allTodosview: (BuildContext context) => const AllTodosView(),
        Constants.passwordResetView: (BuildContext context) => const PasswordResetView(),
      },
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: ThemeData(
        textTheme: GoogleFonts.playTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: FirebaseAuth.instance.currentUser == null ? const LoginPage() : const MyHomePage(),
    );
  }
}

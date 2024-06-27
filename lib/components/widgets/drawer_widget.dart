import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_list/constants/constants.dart';
import 'package:my_list/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:my_list/utility.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user != null && user.photoURL != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  user.photoURL!,
                  errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                ),
              ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.all(12),
                child: user != null
                    ? user.displayName != null
                        ? Text(
                            user.displayName!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        : Text(
                            user.email!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                    : const Text("error fetching user data"),
              ),
            ),
            _buildButtons(
              title: "D A S H B O A R D",
              onTap: () => Routes.navigateToHomeScreen(buildContext: context),
              leading: Icon(
                Icons.home,
                color: Colors.grey[700],
              ),
            ),
            _buildButtons(
              title: "A D D  N E W  T O D O",
              onTap: () => Navigator.of(context).pushNamed(Constants.addNewTodoPage),
              leading: Icon(
                Icons.add,
                color: Colors.grey[700],
              ),
            ),
            _buildButtons(
              title: "S E T T I N G S",
              onTap: () => Routes.navigateToSettingsPage(context: context),
              leading: Icon(
                Icons.account_circle_rounded,
                color: Colors.grey[700],
              ),
            ),
            _buildButtons(
              leading: Icon(
                Icons.logout_rounded,
                color: Colors.grey[700],
              ),
              title: "L O G O U T",
              onTap: () {
                Utility.logout();
                Routes.navigateToLoginScreen(buildContext: context);
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildButtons({
    Widget? leading,
    required String title,
    void Function()? onTap,
    Color? color,
  }) {
    return ListTile(
      leading: leading,
      title: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}

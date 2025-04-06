import 'package:flutter/material.dart';
import 'package:trait_lens_admin/features/tabs/notifications/view/ui/add_notifications_screen.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, AddNotificationsScreen.routeName);
      },
      child: Icon(Icons.add),
    );
  }
}

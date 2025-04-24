import 'package:flutter/material.dart';

class DetectionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const DetectionAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

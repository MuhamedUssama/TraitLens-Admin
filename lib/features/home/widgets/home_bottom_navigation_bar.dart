import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trait_lens_admin/features/home/view_model/home_screen_view_model.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  final HomeScreenViewModel viewModel;

  const HomeBottomNavigationBar({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    return BottomNavigationBar(
      currentIndex: viewModel.currentIndex,
      onTap: (index) {
        viewModel.changeTab(index);
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.groups), label: locale!.users),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: locale.notifications,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_sharp),
          label: locale.profile,
        ),
      ],
    );
  }
}

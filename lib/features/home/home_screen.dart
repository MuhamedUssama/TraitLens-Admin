import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trait_lens_admin/core/di/di.dart';

import 'view_model/home_screen_view_model.dart';
import 'widgets/home_bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home-screen';
  HomeScreen({super.key});

  final HomeScreenViewModel viewModel = getIt.get<HomeScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: viewModel,
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: viewModel.currentIndex,
            children: viewModel.tabs,
          ),
          bottomNavigationBar: HomeBottomNavigationBar(viewModel: viewModel),
        );
      },
    );
  }
}

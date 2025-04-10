import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens_admin/core/di/di.dart';

import 'view_model/home_screen_view_model.dart';
import 'widgets/custom_floating_action_button.dart';
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
          appBar: AppBar(
            title: Text('TraitLens'),
            titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 30.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          body: IndexedStack(
            index: viewModel.currentIndex,
            children: viewModel.tabs,
          ),
          floatingActionButton:
              viewModel.currentIndex == 1 ? CustomFloatingActionButton() : null,
          bottomNavigationBar: HomeBottomNavigationBar(viewModel: viewModel),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens_admin/features/home/view_model/home_screen_states.dart';
import 'package:trait_lens_admin/features/tabs/notifications/view/ui/notifications_tab.dart';
import 'package:trait_lens_admin/features/tabs/profile/view/ui/profile_tab.dart';
import 'package:trait_lens_admin/features/tabs/users/view/ui/users_tab.dart';

@injectable
class HomeScreenViewModel extends Cubit<HomeScreenStates> {
  HomeScreenViewModel() : super(HomeScreenInitialState());

  int currentIndex = 0;

  List<Widget> tabs = [UsersTab(), NotificationsTab(), ProfileTab()];

  void changeTab(int index) {
    currentIndex = index;
    emit(HomeScreenChangeTabState());
  }
}

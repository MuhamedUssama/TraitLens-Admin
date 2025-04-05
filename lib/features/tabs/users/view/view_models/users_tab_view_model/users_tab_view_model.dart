import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens_admin/features/tabs/users/data/repositories/users_repository.dart';

import 'users_tab_states.dart';

@injectable
class UsersTabViewModel extends Cubit<UsersTabStates> {
  final UsersRepository _usersRepository;

  @factoryMethod
  UsersTabViewModel(this._usersRepository) : super(UsersTabInitialState());

  TextEditingController searchController = TextEditingController();

  Future<void> getAllUsers() async {
    emit(UsersTabLoadingState());

    final result = await _usersRepository.getUsers();

    result.fold(
      (error) => emit(UsersTabErrorState(error.toString())),
      (usersList) => emit(UsersTabLoadedState(usersList)),
    );
  }
}

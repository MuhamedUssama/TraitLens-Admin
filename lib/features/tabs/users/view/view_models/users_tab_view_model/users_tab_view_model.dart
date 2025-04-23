import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens_admin/core/models/user_details_model.dart';
import 'package:trait_lens_admin/features/tabs/users/data/repositories/users_repository.dart';

import 'users_tab_states.dart';

@injectable
class UsersTabViewModel extends Cubit<UsersTabStates> {
  final UsersRepository _usersRepository;

  @factoryMethod
  UsersTabViewModel(this._usersRepository) : super(UsersTabInitialState()) {
    getAllUsers();
  }

  TextEditingController searchController = TextEditingController();
  List<UserDetailsModel> _allUsers = [];
  Timer? _debounceTimer;

  Future<void> getAllUsers() async {
    emit(UsersTabLoadingState());

    final result = await _usersRepository.getUsers();

    result.fold((error) => emit(UsersTabErrorState(error.toString())), (
      usersList,
    ) {
      _allUsers = usersList;
      emit(UsersTabLoadedState(usersList));
    });
  }

  String calculateAge(Timestamp? birthTimestamp) {
    if (birthTimestamp == null) return 'Unknown';

    DateTime birthDate = birthTimestamp.toDate();
    DateTime today = DateTime.now();

    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age.toString();
  }

  void searchUsers(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _performSearch(query.trim());
    });
  }

  void submitSearch(String query) {
    _performSearch(query.trim());
  }

  void _performSearch(String query) {
    emit(UsersTabSearchLoadingState());

    if (query.isEmpty) {
      emit(UsersTabLoadedState(_allUsers));
    } else {
      final List<UserDetailsModel> filteredUsers =
          _allUsers.where((user) {
            final String fullName = user.fullName?.toLowerCase() ?? '';
            return fullName.contains(query.toLowerCase());
          }).toList();

      emit(UserTabSearchSuccessState(filteredUsers));
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    searchController.dispose();
    return super.close();
  }
}

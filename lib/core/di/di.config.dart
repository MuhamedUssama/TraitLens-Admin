// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/data_source/auth_data_source.dart' as _i364;
import '../../features/auth/data/data_source_impl/auth_data_source_impl.dart'
    as _i105;
import '../../features/auth/data/repository_impl/auth_repository_impl.dart'
    as _i954;
import '../../features/auth/domain/repository/auth_repository.dart' as _i961;
import '../../features/auth/domain/use_cases/forget_password_usecase.dart'
    as _i27;
import '../../features/auth/domain/use_cases/sign_in_with_email_and_password_usecase.dart'
    as _i780;
import '../../features/auth/domain/use_cases/sign_out_usecase.dart' as _i399;
import '../../features/auth/domain/use_cases/verify_account_usecase.dart'
    as _i3;
import '../../features/auth/view/view_models/forget_password_view_model/forget_password_view_model.dart'
    as _i247;
import '../../features/auth/view/view_models/sign_in_view_model/sign_in_view_model.dart'
    as _i615;
import '../../features/home/view_model/home_screen_view_model.dart' as _i666;
import '../../features/tabs/users/data/data_sources/users_remote_data_source.dart'
    as _i685;
import '../../features/tabs/users/data/repositories/users_repository.dart'
    as _i621;
import '../../features/tabs/users/data/repositories_impl/users_repository_impl.dart'
    as _i650;
import '../../features/tabs/users/view/view_models/users_tab_view_model/users_tab_view_model.dart'
    as _i947;
import '../cache/shared_preferences.dart' as _i254;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i666.HomeScreenViewModel>(() => _i666.HomeScreenViewModel());
    gh.singleton<_i254.SharedPreferencesHelper>(
      () => _i254.SharedPreferencesHelper(),
    );
    gh.lazySingleton<_i685.UsersRemoteDataSource>(
      () => _i685.UsersRemoteDataSource(),
    );
    gh.singleton<_i364.AuthDataSource>(() => _i105.AuthDataSourceImpl());
    gh.factory<_i621.UsersRepository>(
      () => _i650.UsersRepositoryImpl(gh<_i685.UsersRemoteDataSource>()),
    );
    gh.factory<_i947.UsersTabViewModel>(
      () => _i947.UsersTabViewModel(gh<_i621.UsersRepository>()),
    );
    gh.factory<_i961.AuthRepository>(
      () => _i954.AuthRepositoryImpl(gh<_i364.AuthDataSource>()),
    );
    gh.factory<_i780.SignInWithEmailAndPasswordUsecase>(
      () => _i780.SignInWithEmailAndPasswordUsecase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i399.SignOutUsecase>(
      () => _i399.SignOutUsecase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i3.VerifyAccountUsecase>(
      () => _i3.VerifyAccountUsecase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i27.ForgetPasswordUsecase>(
      () => _i27.ForgetPasswordUsecase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i615.SignInViewModel>(
      () =>
          _i615.SignInViewModel(gh<_i780.SignInWithEmailAndPasswordUsecase>()),
    );
    gh.factory<_i247.ForgetPasswordViewModel>(
      () => _i247.ForgetPasswordViewModel(gh<_i27.ForgetPasswordUsecase>()),
    );
    return this;
  }
}

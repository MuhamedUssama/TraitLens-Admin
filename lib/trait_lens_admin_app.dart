import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens_admin/core/di/di.dart';
import 'package:trait_lens_admin/core/shared/language_view_model/language_states.dart';
import 'package:trait_lens_admin/core/shared/language_view_model/language_view_model.dart';
import 'package:trait_lens_admin/core/theme/app_theme.dart';
import 'package:trait_lens_admin/features/auth/view/ui/forget_password_screen.dart';
import 'package:trait_lens_admin/features/auth/view/ui/sign_in_screen.dart';
import 'package:trait_lens_admin/features/home/home_screen.dart';
import 'package:trait_lens_admin/features/tabs/notifications/view/ui/add_notifications_screen.dart';
import 'package:trait_lens_admin/features/tabs/profile/view/ui/edit_profile_screen.dart';
import 'package:trait_lens_admin/features/tabs/users/view/ui/result_details_screen.dart';
import 'package:trait_lens_admin/features/tabs/users/view/ui/user_details_screen.dart';

class TraitLensAdmin extends StatelessWidget {
  const TraitLensAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => getIt<LanguageViewModel>(),

          child: BlocBuilder<LanguageViewModel, LanguageStates>(
            builder: (context, state) {
              Locale currentLocale = const Locale('en');
              if (state is LanguageChangedState) {
                currentLocale = state.locale;
              }

              return MaterialApp(
                title: 'TraitLens Admin',
                debugShowCheckedModeBanner: false,
                themeMode: ThemeMode.light,
                theme: AppTheme.lightTheme,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [Locale('en'), Locale('ar')],
                locale: currentLocale,
                routes: {
                  SignInScreen.routeName: (_) => SignInScreen(),
                  ForgetPasswordScreen.routeName: (_) => ForgetPasswordScreen(),
                  HomeScreen.routeName: (_) => HomeScreen(),
                  UserDetailsScreen.routeName: (_) => UserDetailsScreen(),
                  ResultDetailsScreen.routeName: (_) => ResultDetailsScreen(),
                  AddNotificationsScreen.routeName:
                      (_) => AddNotificationsScreen(),
                  EditProfileScreen.routeName: (_) => EditProfileScreen(),
                },
                initialRoute: _getInitialRoute(),
              );
            },
          ),
        );
      },
    );
  }

  String _getInitialRoute() {
    final user = FirebaseAuth.instance.currentUser;
    return user != null ? HomeScreen.routeName : SignInScreen.routeName;
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens_admin/core/theme/app_theme.dart';
import 'package:trait_lens_admin/features/auth/view/ui/forget_password_screen.dart';
import 'package:trait_lens_admin/features/auth/view/ui/sign_in_screen.dart';
import 'package:trait_lens_admin/features/home/home_screen.dart';

class TraitLensAdmin extends StatelessWidget {
  const TraitLensAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
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
          routes: {
            SignInScreen.routeName: (_) => SignInScreen(),
            ForgetPasswordScreen.routeName: (_) => ForgetPasswordScreen(),
            HomeScreen.routeName: (_) => HomeScreen(),
          },
          initialRoute: _getInitialRoute(),
        );
      },
    );
  }

  String _getInitialRoute() {
    final user = FirebaseAuth.instance.currentUser;
    return user != null ? HomeScreen.routeName : SignInScreen.routeName;
  }
}

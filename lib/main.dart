import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trait_lens_admin/core/cache/shared_preferences.dart';
import 'package:trait_lens_admin/core/di/di.dart';
import 'package:trait_lens_admin/firebase_options.dart';
import 'package:trait_lens_admin/trait_lens_admin_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  await dotenv.load(fileName: ".env");

  await SharedPreferencesHelper.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  runApp(const TraitLensAdmin());
}

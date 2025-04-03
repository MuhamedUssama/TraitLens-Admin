import 'package:flutter/material.dart';
import 'package:trait_lens_admin/core/di/di.dart';
import 'package:trait_lens_admin/trait_lens_admin_app.dart';

void main() {
  configureDependencies();

  runApp(const TraitLensAdmin());
}

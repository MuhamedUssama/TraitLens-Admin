import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens_admin/core/theme/app_theme.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController controller;

  const CustomSearchField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    AppLocalizations locale = AppLocalizations.of(context)!;

    return TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      style: Theme.of(context).textTheme.titleSmall,
      decoration: InputDecoration(
        filled: false,
        hintText: locale.search,
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          borderSide: BorderSide(color: AppTheme.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          borderSide: BorderSide(color: AppTheme.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          borderSide: BorderSide(color: AppTheme.grey, width: 2),
        ),
      ),
    );
  }
}

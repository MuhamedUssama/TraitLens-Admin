import 'package:flutter/material.dart';
import 'package:trait_lens_admin/core/theme/app_theme.dart';

import '../view_model/edit_profile_screen/edit_profile_screen_view_model.dart';

class EditScreenRadioWidget extends StatelessWidget {
  final Gender value;
  final Gender groupValue;
  final String title;
  final Function(Gender gender) onChangeGender;

  const EditScreenRadioWidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.onChangeGender,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      onTap: () {
        onChangeGender.call(value);
      },
      child: Row(
        children: [
          Radio<Gender>(
            activeColor: AppTheme.primary,
            value: value,
            groupValue: groupValue,
            onChanged: (Gender? value) {
              onChangeGender.call(value!);
            },
          ),
          Text(title, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

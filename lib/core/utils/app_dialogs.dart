import 'package:bottom_picker/bottom_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:trait_lens_admin/core/theme/app_theme.dart';

import 'animation_assets.dart';
import 'app_dialog_utils.dart';

class AppDialogs {
  static void showFailDialog({
    required String message,
    required BuildContext context,
    String? posActionTitle,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction,
  }) {
    AppDialogUtils.showDialogOnScreen(
      context: context,
      message: message,
      imagePath: AnimationsAssets.errorAnimation,
      posAction: posAction,
      negativeAction: negativeAction,
      negativeActionTitle: negativeActionTitle,
      posActionTitle: posActionTitle,
    );
  }

  static void showInfoDialog({
    required String message,
    required BuildContext context,
    String? posActionTitle,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction,
  }) {
    AppDialogUtils.showDialogOnScreen(
      context: context,
      message: message,
      imagePath: AnimationsAssets.infoAnimation,
      posAction: posAction,
      negativeAction: negativeAction,
      negativeActionTitle: negativeActionTitle,
      posActionTitle: posActionTitle,
    );
  }

  static void showLoading({
    required String message,
    required BuildContext context,
  }) {
    AppDialogUtils.showLoadingDialog(context: context, message: message);
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showSuccessDialog({
    required String message,
    required BuildContext context,
    String? posActionTitle,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction,
  }) {
    AppDialogUtils.showDialogOnScreen(
      context: context,
      message: message,
      imagePath: AnimationsAssets.checkAnimation,
      posAction: posAction,
      negativeAction: negativeAction,
      negativeActionTitle: negativeActionTitle,
      posActionTitle: posActionTitle,
    );
  }

  static Future<void> showCameraDialog({
    required BuildContext context,
    required Function onCaremraClicked,
    required Function onGalleryClicked,
  }) async {
    AppLocalizations? locale = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            locale!.chooseOption,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                InkWell(
                  onTap: () => onCaremraClicked(),
                  child: Row(
                    children: [
                      const Icon(Icons.camera, color: AppTheme.primary),
                      SizedBox(width: 8.w),
                      Text(
                        locale.camera,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14.h),
                InkWell(
                  onTap: () => onGalleryClicked(),
                  child: Row(
                    children: [
                      const Icon(Icons.image, color: AppTheme.primary),
                      SizedBox(width: 8.w),
                      Text(
                        locale.gallery,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void takeUserBirthday({
    required BuildContext context,
    required TextEditingController controller,
    required void Function(Timestamp birthdayTimestamp) onPicked,
  }) {
    BottomPicker.date(
      height: MediaQuery.sizeOf(context).height * .46,
      buttonStyle: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(16.r),
      ),
      buttonPadding: 12,
      itemExtent: 36,
      pickerTitle: Text(
        'Set Your Birthday',
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      dateOrder: DatePickerDateOrder.dmy,
      initialDateTime: DateTime.now(),
      minDateTime: DateTime(1900, 1, 1),
      maxDateTime: DateTime.now(),
      pickerTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      buttonContent: Text(
        'Select',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
      buttonSingleColor: AppTheme.primary,
      buttonWidth: MediaQuery.sizeOf(context).width * .8,
      onSubmit: (date) {
        controller.text = DateFormat('dd/MM/yyyy').format(date);
        final Timestamp timestamp = Timestamp.fromDate(date);
        onPicked(timestamp);
      },
    ).show(context);
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens_admin/core/constants/app_constants.dart';
import 'package:trait_lens_admin/core/theme/app_theme.dart';
import 'package:trait_lens_admin/features/tabs/users/view/widgets/background_image_loading_widget.dart';

class UserDetailsAppBar extends StatelessWidget {
  final String? imageUrl;

  const UserDetailsAppBar({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 240.h,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: AppTheme.black),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: CachedNetworkImage(
          imageUrl: imageUrl ?? AppConstants.noFoundImage,
          placeholder: (context, url) => BackgroundImageLoadingWidget(),
          errorWidget: (context, url, error) => BackgroundImageLoadingWidget(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

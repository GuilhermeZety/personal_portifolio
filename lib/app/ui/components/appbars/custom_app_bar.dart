import 'package:flutter/material.dart';
import 'package:personal_portifolio/app/core/common/constants/app_colors.dart';
import 'package:personal_portifolio/app/core/common/extensions/context_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/widget/text_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/widget/widget_extension.dart';
import 'package:personal_portifolio/main.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.suffix,
    this.suffixIcon,
    this.backAction,
    this.showBackText = false,
    this.withBackground = false,
  });

  final String? title;
  final Widget? suffix;
  final IconData? suffixIcon;
  final void Function()? backAction;
  final bool showBackText;
  final bool withBackground;

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    double margin = (width - contentMaxWidth) < 24 ? 24 : (width - contentMaxWidth) / 2;
    return SliverAppBar(
      backgroundColor: AppColors.blue_800,
      title: const Text(
        'Guilherme Martins',
        style: TextStyle(fontSize: 16, letterSpacing: 0.4),
      ).gradient(AppColors.gradient).pLeft(margin),
      pinned: true,
      actions: [
        const Text('111'),
        const Text('222'),
        const Text('333').pRight(margin),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 80);
}

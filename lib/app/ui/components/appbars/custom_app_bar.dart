import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:personal_portifolio/app/core/common/constants/app_colors.dart';
import 'package:personal_portifolio/app/core/common/extensions/context_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/widget/text_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/widget/widget_extension.dart';
import 'package:personal_portifolio/app/ui/components/switch/language_switch.dart';
import 'package:personal_portifolio/app/ui/components/switch/theme_switch.dart';
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
      backgroundColor: context.colorScheme.secondaryContainer,
      title: const Text(
        'Guilherme Martins',
        style: TextStyle(fontSize: 18, letterSpacing: 0.3),
      ).gradient(AppColors.gradient).pLeft(margin),
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 1),
        child: Container(
          color: context.colorScheme.tertiaryContainer,
          height: 1,
        ),
      ),
      centerTitle: false,
      pinned: true,
      actions: [
        const ThemeSwitch(),
        const Gap(16),
        const SizedBox(
          width: 100,
          child: Row(
            children: [
              LanguageSwitch(),
            ],
          ),
        ).pRight(margin),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 80);
}

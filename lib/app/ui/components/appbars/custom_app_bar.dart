import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:personal_portifolio/app/core/common/constants/app_colors.dart';
import 'package:personal_portifolio/app/core/common/constants/app_fonts.dart';
import 'package:personal_portifolio/app/core/common/extensions/context_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/locale_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/widget/text_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/widget/widget_extension.dart';
import 'package:personal_portifolio/app/core/common/utils/scroll_util.dart';
import 'package:personal_portifolio/app/modules/home/presentation/pages/sections/about_me_section.dart';
import 'package:personal_portifolio/app/modules/home/presentation/pages/sections/apresentation_section.dart';
import 'package:personal_portifolio/app/ui/components/switch/language_switch.dart';
import 'package:personal_portifolio/app/ui/components/switch/theme_switch.dart';
import 'package:personal_portifolio/main.dart';
import 'package:signals/signals_flutter.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
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
  Size get preferredSize => const Size(double.infinity, 80);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: context.colorScheme.primaryContainer,
      surfaceTintColor: context.colorScheme.primaryContainer,
      title: GestureDetector(
        onTap: () async {
          await ScrollUtil.to(ApresentationSection.currentKey.currentContext!);
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: const Text(
            'Guilherme Martins',
            style: TextStyle(fontSize: 18, letterSpacing: 0.3),
          ).gradient(AppColors.gradient).pLeft(context.pageMargin).slideFade(
                false,
                delay: 200.ms,
                active: mainAnimation,
              ),
        ),
      ),
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
        AppBarItem(
          title: 'home'.t,
          currentKey: ApresentationSection.currentKey,
          animationDelay: 400.ms,
        ),
        const Gap(8),
        AppBarItem(
          title: 'about_me'.t,
          currentKey: AboutMeSection.currentKey,
          animationDelay: 400.ms,
        ),
        const Gap(8),
        const ThemeSwitch().slideFade(false, delay: 500.ms, active: mainAnimation),
        const Gap(16),
        SizedBox(
          width: 100,
          child: Row(
            children: [
              const LanguageSwitch().slideFade(false, delay: 500.ms, active: mainAnimation),
            ],
          ),
        ).pRight(context.pageMargin),
      ],
    );
  }
}

class AppBarItem extends StatefulWidget {
  const AppBarItem({super.key, required this.title, required this.currentKey, required this.animationDelay});
  final String title;
  final GlobalKey currentKey;
  final Duration animationDelay;
  @override
  State<AppBarItem> createState() => _AppBarItemState();
}

class _AppBarItemState extends State<AppBarItem> {
  final hooved = false.toSignal();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => hooved.value = true,
      onExit: (_) => hooved.value = false,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          await ScrollUtil.to(widget.currentKey.currentContext!);
        },
        child: Container(
          color: Colors.transparent,
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Gap(3),
              AnimatedDefaultTextStyle(
                duration: 100.ms,
                style: TextStyle(
                  fontWeight: AppFonts.medium,
                  letterSpacing: 0.5,
                  fontSize: 16,
                  color: context.textTheme.titleLarge?.color?.withOpacity(hooved.watch(context) ? 1 : 0.6),
                ),
                child: Text(
                  widget.title,
                ),
              ).slideFade(
                false,
                delay: widget.animationDelay,
                active: mainAnimation,
              ),
              AnimatedContainer(
                duration: 100.ms,
                height: 3,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                ),
                width: hooved.watch(context) ? 30 : 0,
              ),
            ],
          ),
        ).pH(16),
      ),
    );
  }
}

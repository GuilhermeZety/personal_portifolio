import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:personal_portifolio/app/core/common/constants/app_colors.dart';
import 'package:personal_portifolio/app/core/common/constants/app_fonts.dart';
import 'package:personal_portifolio/app/core/common/extensions/color_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/context_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/locale_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/widget/text_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/widget/widget_extension.dart';
import 'package:personal_portifolio/app/core/common/utils/scroll_util.dart';
import 'package:personal_portifolio/app/modules/home/presentation/pages/sections/about_me_section.dart';
import 'package:personal_portifolio/app/modules/home/presentation/pages/sections/apresentation_section.dart';
import 'package:personal_portifolio/app/modules/home/presentation/pages/sections/contact_section.dart';
import 'package:personal_portifolio/app/modules/home/presentation/pages/sections/projects_section.dart';
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
      automaticallyImplyLeading: false,
      title: GestureDetector(
        onTap: () async {
          await ScrollUtil.to(ApresentationSection.currentKey.currentContext!);
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Text(
            'Guilherme Martins',
            style: TextStyle(fontSize: context.isMobile ? 14 : 18, letterSpacing: 0.3),
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
        if (context.isDesktop) ...[
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
          AppBarItem(
            title: 'projects'.t,
            currentKey: ProjectsSection.currentKey,
            animationDelay: 400.ms,
          ),
          const Gap(8),
          AppBarItem(
            title: 'contact'.t,
            currentKey: ContactSection.currentKey,
            animationDelay: 400.ms,
          ),
        ],
        const Gap(8),
        const ThemeSwitch().slideFade(false, delay: 500.ms, active: mainAnimation),
        const Gap(8),
        SizedBox(
          width: 64,
          child: Row(
            children: [
              const LanguageSwitch().slideFade(false, delay: 500.ms, active: mainAnimation),
            ],
          ),
        ),
        if (!context.isDesktop)
          IconButton(
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: const Icon(
              Icons.menu_rounded,
            ),
          ),
        Gap(context.pageMargin),
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

class _AppBarItemState extends State<AppBarItem> with SignalsMixin {
  final hooved = signal(false, debugLabel: 'APPBAR_HOOVED', autoDispose: true);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await ScrollUtil.to(widget.currentKey.currentContext!);
      },
      child: Container(
        color: Colors.transparent,
        child: MouseRegion(
          onEnter: (_) => hooved.value = true,
          onExit: (_) => hooved.value = false,
          cursor: SystemMouseCursors.click,
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
                  color: context.textTheme.titleLarge?.color?.changeOpacity(hooved.watch(context) ? 1 : 0.6),
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
          ).pH(16),
        ),
      ),
    );
  }
}

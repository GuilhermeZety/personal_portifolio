import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_portifolio/app/core/common/constants/app_assets.dart';
import 'package:personal_portifolio/app/core/common/constants/app_colors.dart';
import 'package:personal_portifolio/app/core/common/constants/app_fonts.dart';
import 'package:personal_portifolio/app/core/common/extensions/context_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/locale_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/text_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/widget/widget_extension.dart';
import 'package:personal_portifolio/app/core/common/utils/scroll_util.dart';
import 'package:personal_portifolio/app/core/shared/session_memory.dart';
import 'package:personal_portifolio/app/modules/home/presentation/pages/sections/about_me_section.dart';
import 'package:signals/signals_flutter.dart';

class ApresentationSection extends StatefulWidget {
  const ApresentationSection({super.key});

  static GlobalKey currentKey = GlobalKey();

  @override
  State<ApresentationSection> createState() => _ApresentationSectionState();
}

class _ApresentationSectionState extends State<ApresentationSection> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      key: ApresentationSection.currentKey,
      child: Container(
        height: context.height - 60 - 60,
        color: context.colorScheme.secondaryContainer,
        child: Stack(
          children: [
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildApresentation(),
                  Image.asset(
                    AppAssets.gifs.spinningCat,
                    width: 300,
                    height: 300,
                  ).hero('spinningCat'),
                ],
              ).pH(context.pageMargin),
            ),
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(
                child: IconButton(
                  onPressed: () {
                    ScrollUtil.to(AboutMeSection.currentKey.currentContext!);
                  },
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      slideAnimation(SvgPicture.memory(SessionMemory().mouseSVG, height: 18)),
                      const Text('Continuar').pH(16).pBottom(3),
                      slideAnimation(SvgPicture.memory(SessionMemory().mouseSVG, height: 18)),
                    ],
                  ).pH(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget slideAnimation(Widget child) {
    return child
        .animate(
          onComplete: (controller) => controller.repeat(reverse: true),
        )
        .slideY(
          duration: 1.seconds,
          begin: -0.1,
          end: 0.1,
        );
  }

  Widget _buildApresentation() {
    return SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'hello'.t,
            style: TextStyle(
              fontSize: 36,
              fontWeight: AppFonts.normal,
              color: context.textTheme.displaySmall?.color,
            ),
          ),
          const AnimatedName(),
          Text(
            'developer'.t,
            style: TextStyle(
              fontSize: 36,
              fontWeight: AppFonts.normal,
              color: context.textTheme.displaySmall?.color,
            ),
          ),
        ],
      ).shim(),
    );
  }
}

class AnimatedName extends StatefulWidget {
  const AnimatedName({super.key});

  @override
  State<AnimatedName> createState() => _AnimatedNameState();
}

class _AnimatedNameState extends State<AnimatedName> {
  double fontSize = 42;
  final String name = 'Guilherme Martins.';
  final show = 0.toSignal();
  final showBar = true.toSignal();

  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(100.ms, (_) {
      if (show.value == name.length) {
        timer.cancel();
      } else {
        show.value = show.value + 1;
      }
    });
    Timer.periodic(1000.ms, (_) {
      showBar.value = !showBar.value;
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch(
      (context) => Row(
        children: [
          Text(
            name.substring(0, show.value),
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: AppFonts.bold,
            ),
          ).gradient(AppColors.gradient),
          AnimatedDefaultTextStyle(
            duration: 100.ms,
            style: TextStyle(
              fontWeight: AppFonts.medium,
              fontSize: fontSize,
              color: context.textTheme.titleLarge?.color?.withOpacity(showBar.value ? 1 : 0),
            ),
            child: const Text(
              '|',
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
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
              child: OverflowBar(
                overflowDirection: VerticalDirection.up,
                alignment: MainAxisAlignment.spaceBetween,
                overflowAlignment: OverflowBarAlignment.center,
                overflowSpacing: 24,
                children: [
                  _buildApresentation(),
                  _getSpinningCat,
                ],
              ).pH(context.pageMargin).pBottom(32),
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
                      gesture(),
                      Text('continue'.t).pH(16).pBottom(3),
                      gesture(),
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

  Widget get _getSpinningCat => Image.asset(
        AppAssets.gifs.spinningCat,
        width: context.width < 696 ? 250 : 300,
        height: context.width < 696 ? 250 : 300,
      ).hero('spinningCat');

  Widget gesture() {
    return (context.isDesktop
            ? SvgPicture.memory(
                SessionMemory().mouseSVG,
                height: 18,
                colorFilter: const ColorFilter.mode(AppColors.blue_700, BlendMode.srcIn),
              )
            : Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.tertiaryContainer.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                width: 20,
                height: 20,
              ))
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
        crossAxisAlignment: context.width < 746 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
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
          AutoSizeText(
            'developer'.t,
            style: TextStyle(
              fontSize: 36,
              fontWeight: AppFonts.normal,
              color: context.textTheme.displaySmall?.color,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
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
  final show = 10.asSignal(debugLabel: 'SHOW_NAME_LENGH');
  final showBar = true.asSignal(debugLabel: 'SHOW_NAME_BOOL');

  late Timer timer;

  @override
  void initState() {
    //TODO: Recolocar

    // timer = Timer.periodic(100.ms, (_) {
    //   if (show.value == name.length) {
    //     timer.cancel();
    //   } else {
    //     show.value = show.value + 1;
    //   }
    // });
    // Timer.periodic(1000.ms, (_) {
    //   showBar.value = !showBar.value;
    // });
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: AutoSizeText(
              name.substring(0, show.value),
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: AppFonts.bold,
              ),
              maxLines: 1,
            ).gradient(AppColors.gradient),
          ),
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

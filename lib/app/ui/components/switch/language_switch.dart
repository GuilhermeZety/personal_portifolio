import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_portifolio/app/core/common/constants/app_assets.dart';
import 'package:personal_portifolio/app/core/shared/location_session.dart';
import 'package:signals/signals_flutter.dart';

class LanguageSwitch extends StatefulWidget {
  const LanguageSwitch({super.key});

  @override
  State<LanguageSwitch> createState() => _LanguageSwitchState();
}

class _LanguageSwitchState extends State<LanguageSwitch> with SignalsAutoDisposeMixin {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        LocalizationSession().switchLocale();
      },
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            languageSvg(LocalizationSession().locale.watch(context).languageCode),
            width: 30,
          ),
          const Icon(Icons.keyboard_arrow_down_rounded),
        ],
      ),
    );
  }

  String languageSvg(String value) {
    return switch (value) {
      'pt' => AppAssets.svgs.brazil,
      'en' => AppAssets.svgs.unitedStates,
      'es' => AppAssets.svgs.spain,
      _ => AppAssets.svgs.unitedStates,
    };
  }
}

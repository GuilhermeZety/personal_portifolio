import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_portifolio/app/core/shared/location_session.dart';
import 'package:personal_portifolio/app/core/shared/session_memory.dart';
import 'package:signals/signals_flutter.dart';

class LanguageSwitch extends StatefulWidget {
  const LanguageSwitch({super.key});

  @override
  State<LanguageSwitch> createState() => _LanguageSwitchState();
}

class _LanguageSwitchState extends State<LanguageSwitch> with SignalsMixin {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        LocalizationSession().switchLocale();
      },
      icon: SvgPicture.memory(
        languageSvg(LocalizationSession().locale.watch(context).languageCode),
        height: 24,
      ),
    );
  }

  Uint8List languageSvg(String value) {
    return switch (value) {
      'pt' => SessionMemory().brazilSVG,
      'en' => SessionMemory().unitedStatesSVG,
      'es' => SessionMemory().spainSVG,
      _ => SessionMemory().brazilSVG,
    };
  }
}

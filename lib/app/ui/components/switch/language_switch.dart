import 'package:flutter/material.dart';
import 'package:personal_portifolio/app/core/shared/location_session.dart';
import 'package:signals/signals_flutter.dart';

class LanguageSwitch extends StatefulWidget {
  const LanguageSwitch({super.key});

  @override
  State<LanguageSwitch> createState() => _LanguageSwitchState();
}

class _LanguageSwitchState extends State<LanguageSwitch> with SignalsAutoDisposeMixin {
  late String currentLanguageSVG;

  @override
  void initState() {
    update(LocalizatiionSession().locale.value.languageCode);
    effect(() {
      var value = LocalizatiionSession().locale.value.languageCode;
      if (value != currentLanguageSVG) {
        update(LocalizatiionSession().locale.value.languageCode);
      }
    });
    super.initState();
  }

  void update(String value) {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        LocalizatiionSession().switchLocale();
      },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.keyboard_arrow_down_rounded),
        ],
      ),
    );
  }
}

import 'dart:developer';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_portifolio/app/core/shared/location_session.dart';
import 'package:personal_portifolio/app/modules/home/presentation/pages/sections/about_me_section.dart';
import 'package:personal_portifolio/app/modules/home/presentation/pages/sections/apresentation_section.dart';
import 'package:personal_portifolio/app/ui/components/appbars/custom_app_bar.dart';
import 'package:personal_portifolio/main.dart';
import 'package:signals/signals_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool ignoreFirst = true;
  @override
  void initState() {
    LocalizationSession().locale.listen(context, () async {
      if (!ignoreFirst) {
        Future.delayed(50.ms, () {
          if (mounted) setState(() {});
          log('stt home');
        });
      } else {
        ignoreFirst = false;
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mainAnimation = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: const Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomAppBar(),
            ApresentationSection(),
            AboutMeSection(),
          ],
        ),
      ),
    );
  }
}

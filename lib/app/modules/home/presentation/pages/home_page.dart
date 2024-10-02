import 'dart:developer';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_portifolio/app/core/shared/location_session.dart';
import 'package:personal_portifolio/app/core/shared/prismic_memory.dart';
import 'package:personal_portifolio/app/modules/home/presentation/pages/sections/about_me_section.dart';
import 'package:personal_portifolio/app/modules/home/presentation/pages/sections/apresentation_section.dart';
import 'package:personal_portifolio/app/modules/home/presentation/pages/sections/contact_section.dart';
import 'package:personal_portifolio/app/modules/home/presentation/pages/sections/footer_section.dart';
import 'package:personal_portifolio/app/modules/home/presentation/pages/sections/projects_section.dart';
import 'package:personal_portifolio/app/ui/components/appbars/custom_app_bar.dart';
import 'package:personal_portifolio/app/ui/components/appbars/custom_drawer.dart';
import 'package:personal_portifolio/main.dart';
import 'package:signals/signals_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SignalsMixin {
  bool ignoreFirst = true;
  @override
  void initState() {
    log('${PrismicMemory().aboutMe}', name: 'Prismic');
    effect(() {
      log(LocalizationSession().locale.value.languageCode);
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
        endDrawer: CustomDrawer(),
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                CustomAppBar(),
                ApresentationSection(),
                AboutMeSection(),
                ProjectsSection(),
                ContactSection(),
                FooterSection(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

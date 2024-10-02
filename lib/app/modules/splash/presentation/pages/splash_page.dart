// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_portifolio/app/core/common/constants/app_assets.dart';
import 'package:personal_portifolio/app/core/common/extensions/widget/widget_extension.dart';
import 'package:personal_portifolio/app/core/common/transitions/fade_transition.dart';
import 'package:personal_portifolio/app/core/shared/prismic_memory.dart';
import 'package:personal_portifolio/app/core/shared/session_memory.dart';
import 'package:personal_portifolio/app/modules/home/presentation/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SessionMemory().load();
      await PrismicMemory().load();
      Future.delayed(1.5.seconds, () {
        Navigator.of(context).pushAndRemoveUntil(FadePageRoute(const HomePage()), (_) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Image.asset(
            AppAssets.gifs.spinningCat,
          ).hero('spinningCat'),
        ).animate().fade(delay: 500.ms),
      ),
    );
  }
}

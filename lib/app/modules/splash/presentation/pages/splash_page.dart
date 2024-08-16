// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_portifolio/app/core/common/constants/app_assets.dart';
import 'package:personal_portifolio/app/core/common/extensions/widget/widget_extension.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // Future.delayed(2.seconds, () {
    //   Navigator.of(context).pushAndRemoveUntil(FadePageRoute(const HomePage()), (_) => false);
    // });
    super.initState();
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

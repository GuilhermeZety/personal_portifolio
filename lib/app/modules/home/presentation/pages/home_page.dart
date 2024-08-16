import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_portifolio/app/core/common/extensions/locale_extension.dart';
import 'package:personal_portifolio/app/core/shared/location_session.dart';
import 'package:personal_portifolio/app/ui/components/appbars/custom_app_bar.dart';
import 'package:signals/signals_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    LocalizationSession().locale.listen(context, () async {
      Future.delayed(50.ms, () {
        if (mounted) setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const CustomAppBar(),
            SliverToBoxAdapter(
              child: Text('access'.t),
            ),
          ],
        ),
      ),
    );
  }
}

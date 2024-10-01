import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:personal_portifolio/app/core/common/constants/app_colors.dart';
import 'package:personal_portifolio/app/core/common/constants/app_theme.dart';
import 'package:personal_portifolio/app/core/common/extensions/context_extension.dart';
import 'package:signals/signals_flutter.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  ThemeMode themeMode = ThemeMode.light;
  double width = 50;
  double height = 25;

  @override
  void initState() {
    themeMode = AppTheme().themeMode.value;
    effect(() {
      var value = AppTheme().themeMode.value;
      if (value != themeMode) {
        changeTheme(value);
      }
    });
    super.initState();
  }

  void changeTheme(ThemeMode mode) {
    themeMode = mode;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitcher.switcher(
      builder: (context, switcher) => IconButton(
        onPressed: () async {
          var newTheme = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
          switcher.changeTheme(
            theme: newTheme == ThemeMode.light ? AppTheme.light : AppTheme.dark,
          );
          await AppTheme().changeThemeMode(newTheme);
        },
        icon: Container(
          alignment: Alignment.center,
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: context.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: context.colorScheme.tertiaryContainer),
          ),
          child: Row(
            children: [
              Container(
                width: (width / 2) - 4,
                height: (width / 2) - 4,
                margin: EdgeInsets.only(left: themeMode == ThemeMode.dark ? 2 : width / 2),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      if (themeMode == ThemeMode.light) ...[
                        const Color(0xFFFFD8A5),
                        const Color(0xFFE3A049),
                      ] else ...[
                        const Color(0xFF262674),
                        const Color(0xFF6D45F5),
                      ],
                    ],
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  themeMode == ThemeMode.light ? Icons.sunny : Icons.dark_mode,
                  color: AppColors.white,
                  size: (height - 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

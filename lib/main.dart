import 'package:flutter/material.dart';
import 'package:personal_portifolio/app/app_widget.dart';
import 'package:personal_portifolio/app/core/shared/current_session.dart';
import 'package:url_strategy/url_strategy.dart';

double contentMaxWidth = 1200;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  CurrentSession().init();
  runApp(
    const AppWidget(),
  );
}

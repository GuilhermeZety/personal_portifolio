import 'package:flutter/material.dart';
import 'package:personal_portifolio/app/ui/components/appbars/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppBar(),
        ],
      ),
    );
  }
}

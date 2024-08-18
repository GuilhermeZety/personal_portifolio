import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AboutMeSection extends StatefulWidget {
  const AboutMeSection({super.key});

  static GlobalKey currentKey = GlobalKey();

  @override
  State<AboutMeSection> createState() => _AboutMeSectionState();
}

class _AboutMeSectionState extends State<AboutMeSection> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      key: AboutMeSection.currentKey,
      child: Column(
        children: [
          const Gap(60),
          //TODO: Colocar numeros aqui :)
          Container(
            width: 100,
            height: 200,
            color: Colors.amber,
          ),
          Container(
            width: 100,
            height: 200,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:personal_portifolio/app/core/common/extensions/widget/widget_extension.dart';
import 'package:personal_portifolio/app/core/shared/features/prismic/models/content_model.dart';
import 'package:personal_portifolio/app/core/shared/prismic_memory.dart';

class AboutMeSection extends StatefulWidget {
  const AboutMeSection({super.key});

  static GlobalKey currentKey = GlobalKey();

  @override
  State<AboutMeSection> createState() => _AboutMeSectionState();
}

class _AboutMeSectionState extends State<AboutMeSection> {
  AboutMeContentModel? content;

  @override
  void initState() {
    content = PrismicMemory().aboutMe;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      key: AboutMeSection.currentKey,
      child: Builder(
        builder: (context) {
          if (content == null) {
            return const Center(
              child: Text('Houve um problema nessa sessão em breve sera resolvido.'),
            );
          }

          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Trocar para imagem cacheada
                Image.network(
                  content!.image,
                  width: 200,
                  height: 200,
                ),
                Text(content!.title.translated(context)),
                Text(content!.subtitle.translated(context)),
                Text(content!.description.translated(context)),
                Text(content!.description.translated(context)),
                Text(content!.curriculumLink),
                Text(content!.emailLink),
              ],
            ),
          );
        },
      ).pTop(40),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:personal_portifolio/app/core/common/constants/app_colors.dart';
import 'package:personal_portifolio/app/core/common/extensions/context_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/widget/widget_extension.dart';
import 'package:personal_portifolio/app/core/shared/features/prismic/models/content_model.dart';
import 'package:personal_portifolio/app/core/shared/prismic_memory.dart';
import 'package:personal_portifolio/app/ui/components/button.dart';
import 'package:personal_portifolio/app/ui/components/gradient_text_highlight.dart';
import 'package:personal_portifolio/main.dart';
import 'package:url_launcher/url_launcher.dart';

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

          return Wrap(
            alignment: WrapAlignment.center,
            children: [
              Stack(
                children: [
                  Lottie.asset(
                    'assets/lottie/${context.isDark ? 'circle_lottie_dark' : 'circle_lottie_light'}.json',
                    width: 280,
                    height: 280,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Image.network(
                          content!.image,
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(80),
              _buildAboutMe,
            ],
          ).pH(context.pageMargin).pV(80);
        },
      ),
    );
  }

  Widget get _buildAboutMe => Container(
        constraints: BoxConstraints(
          maxWidth: contentMaxWidth - 408,
          minWidth: 300,
        ),
        width: context.width - (context.width < 640 ? 0 : 408),
        child: SelectionArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content!.title.translated(context),
                style: context.textTheme.titleLarge,
              ),
              const Gap(16),
              Text(
                content!.subtitle.translated(context),
                style: context.textTheme.titleMedium,
              ),
              const Gap(16),
              GradientTextHighlight(
                text: content!.description.translated(context),
                spans: content!.description.translatedHighlight(context),
                gradient: AppColors.gradient,
              ),
              const Gap(40),
              Row(
                children: [
                  Button(
                    backgroundColor: context.colorScheme.tertiaryContainer,
                    onPressed: () async {
                      launchUrl(
                        Uri.parse(content!.curriculumLink),
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.download, color: AppColors.primary).pTop(2),
                        const Gap(8),
                        const Text('Curriculo', style: TextStyle(color: AppColors.primary)),
                      ],
                    ),
                  ),
                  const Gap(8),
                  Button(
                    backgroundColor: context.colorScheme.tertiaryContainer,
                    onPressed: () async {
                      launchUrl(
                        Uri.parse(content!.emailLink),
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.email_outlined, color: AppColors.secondary).pTop(2),
                        const Gap(8),
                        const Text('Email', style: TextStyle(color: AppColors.secondary)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

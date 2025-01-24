import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:personal_portifolio/app/core/common/extensions/color_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/context_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/locale_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/widget/widget_extension.dart';
import 'package:personal_portifolio/app/core/shared/features/prismic/models/contact_model.dart';
import 'package:personal_portifolio/app/core/shared/prismic_memory.dart';
import 'package:personal_portifolio/app/ui/components/panel.dart';
import 'package:personal_portifolio/main.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  static GlobalKey currentKey = GlobalKey();

  @override
  State<ContactSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<ContactSection> {
  ContactContentModel contact = PrismicMemory().contact!;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      key: ContactSection.currentKey,
      child: Container(
        color: context.colorScheme.secondaryContainer,
        child: Column(
          children: [
            const Gap(60),
            _buildTitle(),
            const Gap(20),
            Text('contact_description'.t),
            const Gap(40),
            _buildContact(),
            const Gap(80),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          'contact'.t,
          style: context.textTheme.titleLarge,
        ),
        const Gap(20),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            color: context.colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }

  Widget _buildContact() {
    return Panel(
      width: contentMaxWidth,
      withShadow: true,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
      color: context.colorScheme.primaryContainer,
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        spacing: 12,
        runSpacing: 12,
        children: contact.items
            .map(
              (e) => ContactItem(
                svg: e.icon,
                text: e.title,
                link: e.link,
                description: e.description,
                color: e.color,
              ),
            )
            .toList(),
      ),
    ).pH(24);
  }
}

class ContactItem extends StatefulWidget {
  const ContactItem({
    super.key,
    required this.svg,
    required this.text,
    required this.link,
    required this.color,
    this.description,
  });

  final String svg;
  final String text;
  final String link;
  final String? description;
  final Color color;

  @override
  State<ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> with SingleTickerProviderStateMixin {
  bool hooved = false;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  ColorFilter? _colorFilter;

  @override
  void initState() {
    _colorFilter = ColorFilter.mode(widget.color, BlendMode.srcIn);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100), // Adjust the animation duration
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: widget.color,
      end: Colors.white,
    ).animate(_controller)
      ..addListener(() {
        setState(() {
          _colorFilter = ColorFilter.mode(
            _colorAnimation.value!, // Use the animated color
            BlendMode.srcIn, // Adjust the blend mode as needed (srcIn is common for coloring)
          );
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Panel(
      width: 239,
      padding: const EdgeInsets.all(12),
      radius: BorderRadius.circular(10),
      splashColor: Colors.black.changeOpacity(context.isDark ? 0.2 : 0.1),
      onTap: () {
        launchUrlString(widget.link);
      },
      withShadow: false,
      color: Colors.transparent,
      onMouseEnter: () {
        setState(() => hooved = true);
        _controller.forward();
      },
      onMouseExit: () {
        setState(() => hooved = false);
        _controller.reverse();
      },
      child: Row(
        children: [
          AnimatedContainer(
            duration: 100.ms,
            decoration: BoxDecoration(
              color: hooved ? widget.color : Colors.transparent,
              border: Border.all(
                color: widget.color,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(1000),
            ),
            padding: const EdgeInsets.all(12),
            child: SvgPicture.network(
              widget.svg,
              width: 30,
              height: 30,
              colorFilter: _colorFilter,
            ),
          ),
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.text,
                style: context.textTheme.titleMedium,
              ),
              if (widget.description != null)
                Text(
                  widget.description!,
                  style: context.textTheme.titleSmall,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

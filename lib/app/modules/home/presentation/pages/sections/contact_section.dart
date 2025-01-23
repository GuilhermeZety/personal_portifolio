import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:personal_portifolio/app/core/common/constants/app_assets.dart';
import 'package:personal_portifolio/app/core/common/extensions/color_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/context_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/locale_extension.dart';
import 'package:personal_portifolio/app/ui/components/panel.dart';
import 'package:personal_portifolio/main.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  static GlobalKey currentKey = GlobalKey();

  @override
  State<ContactSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<ContactSection> {
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
            const Text('Estou sempre disponível!'),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ContactItem(
            svg: AppAssets.svgs.pin,
            text: 'Endereço',
            link: '+55 11 99999-9999',
            description: 'Blumenau/SC',
            color: const Color(0xFF34A068),
          ),
          ContactItem(
            svg: AppAssets.svgs.linkedin,
            text: 'Linkedin',
            link: '+55 11 99999-9999',
            description: '/guilherme-m-l-martins',
            color: const Color(0xFF1578B6),
          ),
          ContactItem(
            svg: AppAssets.svgs.github,
            text: 'Github',
            link: '+55 11 99999-9999',
            description: '@GuilhermeZety',
            color: const Color(0xFFBE2FAE),
          ),
          ContactItem(
            svg: AppAssets.svgs.discord,
            text: 'Discord',
            link: '+55 11 99999-9999',
            description: 'Zezin#9999',
            color: const Color(0xFF5669F6),
          ),
        ],
      ),
    );
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
      padding: const EdgeInsets.all(12),
      radius: BorderRadius.circular(10),
      splashColor: Colors.black.changeOpacity(0.2),
      onTap: () {},
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
            child: SvgPicture.asset(
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

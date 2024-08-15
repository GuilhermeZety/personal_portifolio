import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:personal_portifolio/app/core/common/extensions/context_extension.dart';
import 'package:personal_portifolio/app/core/common/extensions/widget/widget_extension.dart';
import 'package:personal_portifolio/app/core/common/utils/custom_dialog_utils.dart';
import 'package:personal_portifolio/app/ui/components/button.dart';

class SeeImageModal extends StatefulWidget {
  const SeeImageModal({
    super.key,
    required this.currentImage,
    required this.images,
    this.offline = false,
  });

  final String currentImage;
  final List<String> images;
  final bool offline;

  Future show(
    BuildContext context,
  ) async {
    return showCustomDialog(
      context,
      child: this,
    );
  }

  @override
  State<SeeImageModal> createState() => _SeeImageModalState();
}

class _SeeImageModalState extends State<SeeImageModal> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Gap(50),
          SizedBox(
            width: context.width,
            child: Builder(
              builder: (context) {
                if (widget.offline) {
                  return Image.file(
                    File(widget.currentImage),
                  );
                }
                return Image.file(
                  File(widget.currentImage),
                );
              },
            ),
          ).p(20),
          Button.outlined(
            onPressed: () async {
              Navigator.pop(context);
            },
            child: const Text('Fechar'),
          ).pH(20).expandedH(),
        ],
      ),
    );
  }
}

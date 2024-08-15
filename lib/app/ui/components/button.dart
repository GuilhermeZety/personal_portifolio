import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:personal_portifolio/app/core/common/constants/app_colors.dart';
import 'package:personal_portifolio/app/core/common/constants/app_fonts.dart';
import 'package:personal_portifolio/app/core/common/utils/toasting.dart';
import 'package:personal_portifolio/app/core/common/utils/vibrate.dart';
import 'package:personal_portifolio/app/ui/components/loader.dart';

// Custom buttons are created by extending the MaterialButton class
class Button extends StatefulWidget {
  final Future<void> Function()? onPressed;
  final Widget child;
  final FocusNode? focusNode;
  final VoidCallback? onLongPress;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsets padding;
  final bool outlined;
  final bool disabled;

  const Button({
    super.key,
    required this.onPressed,
    required this.child,
    this.focusNode,
    this.onLongPress,
    this.disabled = false,
    this.backgroundColor = AppColors.blue_600,
    this.foregroundColor = AppColors.white,
    this.padding = const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
  }) : outlined = false;
  const Button.outlined({
    super.key,
    required this.onPressed,
    required this.child,
    this.focusNode,
    this.onLongPress,
    this.disabled = false,
    this.backgroundColor = AppColors.white,
    this.foregroundColor = AppColors.grey_500,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
  }) : outlined = true;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool isLoading = false;
  late Future<void> Function() action;

  @override
  void initState() {
    action = () async {
      if (!mounted) return;
      if (widget.disabled) return;
      try {
        if (widget.onPressed == null) return;

        isLoading = true;
        if (!mounted) return;
        setState(() {});

        vibrate(FeedbackType.light);
        await widget.onPressed!();

        isLoading = false;
        if (!mounted) return;
        setState(() {});
      } catch (err) {
        if (!mounted) return;
        if (err is TypeError) {
          Toasting.error(context, title: 'Erro: $err', stackTrace: err.stackTrace);
          return;
        }
        if (err is Exception) {
          Toasting.error(context, title: 'Erro: $err');
          return;
        }
        Toasting.error(context, title: 'Erro: $err');
      }
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        var content = Material(
          color: widget.backgroundColor?.withOpacity(widget.disabled ? 0.5 : 1),
          child: InkWell(
            onTap: action,
            child: Padding(
              padding: widget.padding,
              child: DefaultTextStyle(
                style: TextStyle(
                  fontFamily: AppFonts.defaultFont,
                  color: widget.foregroundColor,
                  fontSize: 16,
                  fontWeight: AppFonts.medium,
                  letterSpacing: 0.3,
                ),
                child: Center(
                  child: isLoading ? const Loader(size: 16, inverted: true) : widget.child,
                ),
              ),
            ),
          ),
        );
        if (widget.outlined) {
          return Container(
            color: widget.foregroundColor,
            padding: const EdgeInsets.all(1),
            child: content,
          );
        }
        return content;
      },
    );
  }
}

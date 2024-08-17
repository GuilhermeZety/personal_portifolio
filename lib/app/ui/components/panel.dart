import 'package:flutter/material.dart';
import 'package:personal_portifolio/app/core/common/constants/app_colors.dart';
import 'package:personal_portifolio/app/core/common/extensions/context_extension.dart';

class Panel extends StatelessWidget {
  final EdgeInsets padding;
  final Widget? child;
  final double? width;
  final double? height;
  final bool withShadow;
  final bool isLoading;
  final Border? border;
  final BorderRadius? radius;
  final Color? color;
  final Color? splashColor;
  final Function()? onTap;
  final Function()? onLongPress;
  final bool? clickable;

  const Panel({
    super.key,
    this.padding = const EdgeInsets.all(20),
    this.child,
    this.withShadow = true,
    this.isLoading = false,
    this.width,
    this.height,
    this.border,
    this.onTap,
    this.onLongPress,
    this.clickable,
    this.color,
    this.splashColor,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: border,
        borderRadius: radius ?? BorderRadius.circular(10),
        boxShadow: withShadow
            ? [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.06),
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ]
            : [],
      ),
      child: Material(
        color: color ?? context.colorScheme.secondaryContainer,
        borderRadius: radius ?? BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          enableFeedback: true,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(0),
          splashColor: splashColor ?? AppColors.grey_100,
          overlayColor: WidgetStateProperty.all<Color>(
            splashColor?.withOpacity(0.5) ?? AppColors.grey_100.withOpacity(0.5),
          ),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}

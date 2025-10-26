import 'package:flutter/material.dart';
import 'package:shantika_cubit/ui/color.dart';
import 'package:shantika_cubit/ui/dimension.dart';

class CustomCardContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Gradient? gradient;
  final double borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final Color? borderColor;
  final double? borderWidth;

  const CustomCardContainer({
    super.key,
    this.child,
    this.padding,
    this.backgroundColor,
    this.gradient,
    this.borderRadius = borderRadius100,
    this.border,
    this.boxShadow,
    this.margin,
    this.width,
    this.height,
    this.borderColor,
    this.borderWidth = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? EdgeInsets.all(paddingL),
      decoration: BoxDecoration(
        color: gradient == null
            ? (backgroundColor ?? black00)
            : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
        border:
        border ??
            (borderColor != null
                ? Border.all(color: borderColor!, width: borderWidth!)
                : null),
        boxShadow:
        boxShadow ??
            [
              BoxShadow(
                color: black700_70.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
      ),
      child: child,
    );
  }
}

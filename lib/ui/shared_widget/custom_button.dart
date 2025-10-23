import 'package:flutter/material.dart';
import '../color.dart';
import '../dimension.dart';
import '../typography.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool disabled;
  final Gradient? gradient;
  final Color textColor;
  final Color textColorDisabled;
  final Size? maximumSize;
  final Color backgroundColor;
  final Color disabledColor;
  final Size? minimumSize;
  final Border? border;
  final double? width;

  const CustomButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.disabled = false,
    this.gradient,
    this.textColor = textButtonPrimary,
    this.textColorDisabled = textDisabled,
    this.maximumSize,
    this.minimumSize,
    this.backgroundColor = bgButtonInfoPressed,
    this.border,
    this.disabledColor = bgDisabled,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: border,
      ),
      child: Material(
        color: onPressed != null ? primaryColor : disabledColor,
        borderRadius: BorderRadius.circular(borderRadius300),
        child: InkWell(
          splashColor: transparentColor,
          borderRadius: BorderRadius.circular(borderRadius300),
          onTap: onPressed != null
              ? () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  onPressed!();
                }
              : null,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(borderRadius300)),
            ),
            child: DefaultTextStyle.merge(
              style: smBold.copyWith(color: onPressed != null ? textColor : textColorDisabled),
              textAlign: TextAlign.center,
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}

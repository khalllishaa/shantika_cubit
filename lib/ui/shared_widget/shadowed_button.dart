import 'package:flutter/material.dart';

import '../color.dart';
import '../dimension.dart';

class ShadowedButton extends StatelessWidget {
  final Function()? onPressed;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  final bool disabled;
  const ShadowedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.disabled = false,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: disabled || onPressed == null
            ? null
            : [
                BoxShadow(
                  color: Color(0xffB5B5B5),
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: Offset(0, 1), // changes position of shadow
                ),
                BoxShadow(
                  color: Color(0xffE3E3E3),
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: Offset(1, 0), // changes position of shadow
                ),
                BoxShadow(
                  color: Color(0xffE3E3E3),
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: Offset(-1, 0), // changes position of shadow
                ),
                BoxShadow(
                  color: Color(0xffE3E3E3),
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: Offset(0, -1), // changes position of shadow
                ),
              ],
        borderRadius: BorderRadius.circular(borderRadius300),
      ),
      child: Material(
        color: disabled || onPressed == null ? black200 : bgButtonOutlinedDefault,
        borderRadius: BorderRadius.circular(borderRadius300),
        child: InkWell(
          splashColor: bgButtonOutlinedPressed,
          borderRadius: BorderRadius.circular(borderRadius300),
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius300),
              color: backgroundColor != null
                  ? backgroundColor!
                  : (disabled ? backgroundColor : transparentColor) ?? Colors.transparent,
            ),
            padding: padding ?? EdgeInsets.all(spacing4),
            child: DefaultTextStyle.merge(
                style: TextStyle(
                    fontSize: 14,
                    color: disabled || onPressed == null ? textDisabled : textNeutralPrimary,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                child: Center(child: child)),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shantika_cubit/ui/color.dart';
import 'package:shantika_cubit/ui/dimension.dart';
import 'package:shantika_cubit/ui/typography.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final Color? lineColor;

  const SectionTitle({
    Key? key,
    required this.title,
    this.lineColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: space150,
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: lineColor ?? navy400,
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          SizedBox(width: space150),
          Text(
            title,
            style: smSemiBold,
          ),
        ],
      ),
    );
  }
}

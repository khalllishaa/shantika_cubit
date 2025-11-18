import 'package:flutter/material.dart';

import '../../ui/color.dart';
import '../../ui/typography.dart';

class InfoFleetClasses extends StatelessWidget {
  const InfoFleetClasses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black00,
        appBar: AppBar(
          backgroundColor: black00,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: black950),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Kelas Armada",
            style: xlSemiBold,
          ),
        ),
    );
  }
}

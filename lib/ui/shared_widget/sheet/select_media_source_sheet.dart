import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../color.dart';
import '../../dimension.dart';
import '../../typography.dart';

class SelectMediaSourceSheet extends StatelessWidget {
  final Function(ImageSource imageSource) onSelected;

  const SelectMediaSourceSheet({
    super.key,
    required this.onSelected,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: Column(
          children: [
            SizedBox(
              height: spacing6,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.xmark,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 16,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Select Image Source",
                        style: sBold.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: spacing5),
            ListTile(
              tileColor: transparentColor,
              onTap: () {
                Navigator.pop(context);
                onSelected(ImageSource.gallery);
              },
              leading: SvgPicture.asset(
                'assets/images/ic_folder.svg',
                color: primaryColor,
              ),
              title: Text(
                "Gallery",
                style: sBold.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ),
            ListTile(
              tileColor: transparentColor,
              onTap: () {
                Navigator.pop(context);
                onSelected(ImageSource.camera);
              },
              leading: SvgPicture.asset(
                'assets/images/ic_camera.svg',
                color: primaryColor,
              ),
              title: Text(
                "Camera",
                style: sBold.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

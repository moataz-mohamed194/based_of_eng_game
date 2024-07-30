import 'package:flutter/material.dart';

import '../../../core/phonetics_color.dart';

class HideCard extends StatelessWidget {
  final void Function() onTap;

  const HideCard({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 80,
        height: 66,
        padding: const EdgeInsets.only(top: 21, left: 9, right: 8, bottom: 20),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColorPhonetics.darkBorderColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

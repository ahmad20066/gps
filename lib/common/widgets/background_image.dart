import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_module/common/constants/app_colors.dart';

class BackGroundImage extends StatelessWidget {
  final Color? color;
  const BackGroundImage({
    Key? key,
    this.color = AppColors.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SvgPicture.asset(
        "assets/images/Background.svg",
        fit: BoxFit.cover,
        color: color?.withOpacity(0.1),
      ),
    );
  }
}

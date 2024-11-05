import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/logo/svg/logo-no-background.svg',
      height: 65,
      fit: BoxFit.cover,
    );
  }
}

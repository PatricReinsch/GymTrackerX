import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoWithNameBelow extends StatelessWidget {
  final String title; // Deklariere `title` als Instanzvariable

  const LogoWithNameBelow({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/images/logo/svg/Logo.svg',
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          SvgPicture.asset(
            'assets/images/logo/svg/Text.svg',
            height: 65,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

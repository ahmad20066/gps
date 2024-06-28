import 'package:flutter/material.dart';

class MyTabController extends TabController {
  MyTabController({
    required super.length,
    required super.vsync,
  });

  @override
  void animateTo(int value,
      {Duration? duration, Curve curve = Curves.easeInOutSine}) {
    /// your customization
    super.animateTo(value,
        duration: const Duration(seconds: 1), curve: Curves.easeInOutSine);
  }
}

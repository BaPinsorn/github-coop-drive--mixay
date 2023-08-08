import 'package:flutter/material.dart';
import 'package:flutter_coop_driver_mixay/Colors.dart/MxColors.dart';

class BorderChange {
  static OutlineInputBorder enabledBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    );
  }

  static OutlineInputBorder focusedBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: MxColors.subtitleColorBlue),
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    );
  }

  static OutlineInputBorder errorBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: MxColors.mainColorRed),
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    );
  }

  static OutlineInputBorder focusedErrorBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: MxColors.subtitleColorBlue),
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    );
  }
}

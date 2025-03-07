
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'WAColors.dart';

InputDecoration waInputDecoration({
  IconData? prefixIcon,
  IconData? suffixIcon,
  VoidCallback? onSuffixIconTap,
  String? hint,
  Color? bgColor,
  Color? borderColor,
  EdgeInsets? padding,
}) {
  return InputDecoration(
    contentPadding: padding ?? const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
    counter: const Offstage(),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: borderColor ?? color.WAPrimaryColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
    ),
    fillColor: bgColor ?? color.WATextFieldColor.withOpacity(0.5),
    hintText: hint,
    prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: color.WAPrimaryColor) : null,
    suffixIcon: suffixIcon != null
        ? GestureDetector(
      onTap: onSuffixIconTap, // Handle suffix icon tap
      child: Icon(suffixIcon, color: color.WAPrimaryColor),
    )
        : null,
    hintStyle: secondaryTextStyle(),
    filled: true,
  );
}




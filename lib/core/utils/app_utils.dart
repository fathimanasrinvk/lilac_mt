import 'dart:convert';
import 'dart:developer';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_config/app_config.dart';
import '../constants/colors.dart';
import '../constants/textstyles.dart';

class AppUtils {
  static Future<String?> getToken() async {
    log("AppUtils -> getToken()");
    final sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.get(AppConfig.token) != null) {
      final access =
      jsonDecode(sharedPreferences.get(AppConfig.token) as String);
      log("Token -> $access");
      return access;
    } else {
      return null;
    }
  }

  static oneTimeSnackBar(
      String? message, {
        int time = 2,
        Color? bgColor,
        TextStyle? textStyle,
        required BuildContext context,
        bool showOnTop = false,
      }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ///To CLEAR PREVIOUS SNACK BARS
    return ScaffoldMessenger.of(context)
    // ScaffoldMessenger.of(context??Routes.router.routerDelegate.navigatorKey.currentState!.context)
        .showSnackBar(
      SnackBar(
        /*action:SnackBarAction(label: "Ok",
        onPressed: (){
          SystemSettings.internalStorage();
        },
        ) ,*/

        behavior: showOnTop ? SnackBarBehavior.floating : null,
        backgroundColor: bgColor ?? Colors.white60,
        content: Center(
          child: Text(message!,
              style: textStyle ??
                  GLTextStyles.snackbartxt(color: ColorTheme.mainColor)),
        ),
        duration: Duration(seconds: time),
        margin: showOnTop
            ? EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20)
            : null,
      ),
    );
  }

  static void showFlushbar({
    required BuildContext context,
    required String message,
    Color backgroundColor = const Color(0xFFE0E0E0),
    Color messageColor = const Color(0xFF000000),
    IconData? icon,
    Color? iconColor,
    double? widthFactor,
    Duration duration = const Duration(seconds: 3),
    FlushbarPosition? flushbarPosition,
    BorderRadius? borderRadius,
  }) {
    Flushbar(
      maxWidth: MediaQuery.of(context).size.width * (widthFactor ?? 0.6),
      backgroundColor: backgroundColor,
      messageColor: messageColor,
      icon: icon != null
          ? Icon(
        icon,
        color: iconColor ?? const Color(0xffFF595C),
        // Default icon color if not provided
        size: 25,
      )
          : null,
      // Icon will be null if not provided
      message: message,
      duration: duration,
      flushbarPosition: flushbarPosition ?? FlushbarPosition.TOP,
      borderRadius: borderRadius,
    ).show(context);
  }
}
import 'dart:convert';
import 'dart:developer';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_config/app_config.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/otp_verify_screen/service/otp_verify_screen_service.dart';
import '../../all_message_list_screen/view/all-message_list_screen.dart';


class VerificationController with ChangeNotifier {
  String _otpCode = '';
  bool _isLoading = false;

  String get otpCode => _otpCode;
  bool get isLoading => _isLoading;

  late SharedPreferences sharedPreferences;

  void setOtpCode(String code) {
    _otpCode = code;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> verifyOtp(String phone, String otpCode, BuildContext context) async {
    log("VerificationController -> verifyOtp() started");

    if (otpCode.isEmpty || otpCode.length < 4) {
      AppUtils.oneTimeSnackBar(
        "Please enter a valid OTP",
        context: context,
      );
      return;
    }

    setLoading(true);

    // Get device information
    Map<String, dynamic> deviceMeta = {
      "type": "web",
      "name": "HP Pavilion 14-EP0068TU",
      "os": "Linux x86_64",
      "browser": "Mozilla Firefox Snap for Ubuntu (64-bit)",
      "browser_version": "112.0.2",
      "user_agent": "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/112.0",
      "screen_resolution": "1600x900",
      "language": "en-GB"
    };

    // Prepare request data
    var data = {
      "data": {
        "type": "registration_otp_codes",
        "attributes": {
          "phone": phone,
          "otp": int.parse(otpCode),
          "device_meta": deviceMeta
        }
      }
    };

    try {
      var response = await VerificationService.verifyOtp(data);
      setLoading(false);

      if (response != null && response["data"] != null) {
        // Store user data and token
        storeUserData(response["data"]);

        // Navigate to messages screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MessagesListScreen()),
              (route) => false,
        );
      } else {
        Flushbar(
          maxWidth: .55.sw,
          backgroundColor: Colors.grey.shade100,
          messageColor: ColorTheme.black,
          icon: Icon(
            Icons.close,
            color: ColorTheme.red,
            size: 20.sp,
          ),
          message: 'Invalid OTP. Please try again.',
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
        ).show(context);
      }
    } catch (e) {
      setLoading(false);
      log("Error verifying OTP: $e");

      Flushbar(
        maxWidth: .55.sw,
        backgroundColor: Colors.grey.shade100,
        messageColor: ColorTheme.black,
        icon: Icon(
          Icons.close,
          color: ColorTheme.red,
          size: 20.sp,
        ),
        message: 'Verification failed. Please try again.',
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
    }
  }

  Future<void> resendOtp(String phone, BuildContext context) async {
    log("VerificationController -> resendOtp() started");

    var data = {
      "data": {
        "type": "registration_otp_codes",
        "attributes": {"phone": phone}
      }
    };

    try {
      var response = await VerificationService.resendOtp(data);

      if (response != null && response["status"] == true) {
        Flushbar(
          maxWidth: .55.sw,
          backgroundColor: Colors.grey.shade100,
          messageColor: ColorTheme.black,
          icon: Icon(
            Icons.check_circle,
            color: ColorTheme.mainColor,
            size: 20.sp,
          ),
          message: 'OTP sent successfully',
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
        ).show(context);
      } else {
        Flushbar(
          maxWidth: .55.sw,
          backgroundColor: Colors.grey.shade100,
          messageColor: ColorTheme.black,
          icon: Icon(
            Icons.close,
            color: ColorTheme.red,
            size: 20.sp,
          ),
          message: 'Failed to resend OTP',
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
        ).show(context);
      }
    } catch (e) {
      log("Error resending OTP: $e");

      Flushbar(
        maxWidth: .55.sw,
        backgroundColor: Colors.grey.shade100,
        messageColor: ColorTheme.black,
        icon: Icon(
          Icons.close,
          color: ColorTheme.red,
          size: 20.sp,
        ),
        message: 'Failed to resend OTP',
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
    }
  }

  void storeUserData(userData) async {
    log("storeUserData");
    sharedPreferences = await SharedPreferences.getInstance();

    // Store user profile data
    String userDataString = jsonEncode(userData);
    sharedPreferences.setString(AppConfig.userData, userDataString);

    // Store auth token
    if (userData["attributes"] != null &&
        userData["attributes"]["auth_status"] != null &&
        userData["attributes"]["auth_status"]["access_token"] != null) {
      String token = userData["attributes"]["auth_status"]["access_token"];
      sharedPreferences.setString(AppConfig.token, token);
    }

    // Set logged in status
    sharedPreferences.setBool(AppConfig.loggedIn, true);
  }
}
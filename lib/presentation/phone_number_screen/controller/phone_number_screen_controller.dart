import 'dart:convert';
import 'dart:developer';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lilac_infotech/presentation/otp_screen/view/otp-screen.dart';
import 'package:lilac_infotech/repository/api/phone_number_screen/service/phone_number_screen_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_config/app_config.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';

class PhoneNumberController with ChangeNotifier {
  String _phoneNumber = '';

  String get phoneNumber => _phoneNumber;


  late SharedPreferences sharedPreferences;

  Future postPhoneNumber(String phone, BuildContext context) async {
    log("PhoneNumberController -> postPhoneNumber() started");

    if (phone.isEmpty) {
      AppUtils.oneTimeSnackBar(
        "Phone number is required",
        context: context,
      );
      return;
    }

    var data = {
      "data": {
        "type": "registration_otp_codes",
        "attributes": {"phone": phone}
      }
    };

    PhoneNumberScreenService.postPhoneNumber(data).then((response) {
      if (response["status"] == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => VerificationScreen(phoneNumber: phone)),
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
          message: 'Failed to send otp',
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
        ).show(context);
      }
    });
  }
  void setPhoneNumber(String number) {
    _phoneNumber = number;
    notifyListeners();
  }

  void clearPhoneNumber() {
    _phoneNumber = '';
    notifyListeners();
  }


  void storeLoginData(loginReceivedData) async {
    log("storeLoginData");
    sharedPreferences = await SharedPreferences.getInstance();
    String storeData = jsonEncode(loginReceivedData);
    sharedPreferences.setString(AppConfig.loginData, storeData);
    sharedPreferences.setBool(AppConfig.loggedIn, true);
  }

  void storeUserToken(resData) async {
    log("storeUserToken");
    sharedPreferences = await SharedPreferences.getInstance();
    String dataUser = json.encode(resData);
    sharedPreferences.setString(AppConfig.token, dataUser);
  }
}
import 'dart:developer';
import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class VerificationService {
  static Future<dynamic> verifyOtp(Map<String, dynamic> data) async {
    try {
      var decodedData = await ApiHelper.postData(
          endPoint: "/auth/registration-otp-codes/actions/phone/verify-otp",
          header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
          body: data);
      return decodedData;
    } catch (e) {
      log("$e");
      return null;
    }
  }

  static Future<dynamic> resendOtp(Map<String, dynamic> data) async {
    try {
      var decodedData = await ApiHelper.postData(
          endPoint: "/auth/registration-otp-codes/actions/phone/send-otp",
          header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
          body: data);
      return decodedData;
    } catch (e) {
      log("$e");
      return null;
    }
  }
}
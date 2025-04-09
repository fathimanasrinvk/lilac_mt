import 'dart:developer';
import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class MessagesService {
  static Future<dynamic> getChatProfiles() async {
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "/chat/chat-messages/queries/contact-users",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("Error fetching chat profiles: $e");
      return null;
    }
  }
}
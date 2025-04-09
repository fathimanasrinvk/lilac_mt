import 'dart:convert';
import 'dart:developer';
import '../../../helper/api_helper.dart';
import '../model/all_message_list_screen_model.dart';

class MessageListService {
  static Future<List<MessageModel>?> getContactUsers() async {
    try {
      final rawResponse = await ApiHelper.getData(
        endPoint: "/chat/chat-messages/queries/contact-users",
        header: ApiHelper.getApiHeader(
            access: "117|KfuqqNXivj5Kztyf8cqwU11XJXlpmraS0mayLqu58a3bf708"),
      );

      if (rawResponse != null) {
        log("Raw response: $rawResponse");

        return messageModelFromJson(jsonEncode(rawResponse["data"]));
      } else {
        log("getContactUsers: Response is null");
        return null;
      }
    } catch (e) {
      log("getContactUsers error: $e");
      return null;
    }
  }
}

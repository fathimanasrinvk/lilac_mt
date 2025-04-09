import 'dart:convert';
import 'dart:developer';
import 'package:japx/japx.dart';

import '../../../helper/api_helper.dart';
import '../model/chat_details_screen_model.dart';


class ChatService {
  static Future<List<ChatModel>?> getChats() async {
    try {
      final rawResponse = await ApiHelper.getData(
        endPoint: "/chat/chat-messages/queries/chat-between-users/55/81",
        header: ApiHelper.getApiHeader(
            access: "117|KfuqqNXivj5Kztyf8cqwU11XJXlpmraS0mayLqu58a3bf708"),
      );

      if (rawResponse != null) {
        log("Raw response: $rawResponse");

        return chatModelFromJson(jsonEncode(rawResponse["data"]));
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
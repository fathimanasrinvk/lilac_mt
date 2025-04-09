import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/chat_details_screen/model/chat_details_screen_model.dart';
import '../../../repository/api/chat_details_screen/service/chat_details_screen_service.dart';
class ChatController with ChangeNotifier {
  bool isLoading = false;
  List<ChatModel> chatList = [];

  Future<void> fetchChats(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await ChatService.getChats();

      if (response != null) {
        chatList = response;
      } else {
        AppUtils.oneTimeSnackBar(
          "Unable to fetch Data",
          context: context,
          bgColor: ColorTheme.red,
        );
      }
    } catch (e) {
      log("Error in fetchMessages: $e");
      AppUtils.oneTimeSnackBar(
        "Something went wrong",
        context: context,
        bgColor: ColorTheme.red,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
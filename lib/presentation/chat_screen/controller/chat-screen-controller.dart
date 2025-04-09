import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../repository/api/chatlist_screen/model/chat_screen_model.dart';
import '../../../repository/api/chatlist_screen/service/chatlist_screen_service.dart';


class MessagesController with ChangeNotifier {
  List<ChatProfile> _chatProfiles = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<ChatProfile> get chatProfiles => _filterProfiles();
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<ChatProfile> _filterProfiles() {
    if (_searchQuery.isEmpty) {
      return _chatProfiles;
    }

    return _chatProfiles.where((profile) {
      return profile.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  Future<void> fetchChatProfiles() async {
    log("MessagesController -> fetchChatProfiles() started");

    _isLoading = true;
    notifyListeners();

    try {
      var response = await MessagesService.getChatProfiles();

      if (response != null && response["data"] != null) {
        _chatProfiles = List<ChatProfile>.from(
            response["data"].map((profile) => ChatProfile.fromJson(profile))
        );
      } else {
        _chatProfiles = [];
      }
    } catch (e) {
      log("Error processing chat profiles: $e");
      _chatProfiles = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
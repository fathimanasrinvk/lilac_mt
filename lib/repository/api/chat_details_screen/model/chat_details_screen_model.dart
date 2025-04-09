// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

List<ChatModel> chatModelFromJson(String str) => List<ChatModel>.from(json.decode(str).map((x) => ChatModel.fromJson(x)));

String chatModelToJson(List<ChatModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatModel {
  String? type;
  String? id;
  Attributes? attributes;
  Relationships? relationships;

  ChatModel({
    this.type,
    this.id,
    this.attributes,
    this.relationships,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    type: json["type"],
    id: json["id"],
    attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
    relationships: json["relationships"] == null ? null : Relationships.fromJson(json["relationships"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
    "attributes": attributes?.toJson(),
    "relationships": relationships?.toJson(),
  };
}

class Attributes {
  int? chatThreadId;
  int? chatMessageTypeId;
  int? senderId;
  int? receiverId;
  String? message;
  dynamic mediaMeta;
  bool? isOneTimeView;
  bool? isOnVanishMode;
  dynamic scheduledAt;
  DateTime? sentAt;
  DateTime? deliveredAt;
  dynamic viewedAt;
  dynamic stickerId;
  dynamic giftOrderId;
  dynamic senderCoinTransactionId;
  dynamic receiverCoinTransactionId;
  dynamic transferCoins;
  dynamic deletedForSenderBy;
  dynamic deletedForSenderAt;
  dynamic deletedForReceiverBy;
  dynamic deletedForReceiverAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic mediaUrl;

  Attributes({
    this.chatThreadId,
    this.chatMessageTypeId,
    this.senderId,
    this.receiverId,
    this.message,
    this.mediaMeta,
    this.isOneTimeView,
    this.isOnVanishMode,
    this.scheduledAt,
    this.sentAt,
    this.deliveredAt,
    this.viewedAt,
    this.stickerId,
    this.giftOrderId,
    this.senderCoinTransactionId,
    this.receiverCoinTransactionId,
    this.transferCoins,
    this.deletedForSenderBy,
    this.deletedForSenderAt,
    this.deletedForReceiverBy,
    this.deletedForReceiverAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.mediaUrl,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    chatThreadId: json["chat_thread_id"],
    chatMessageTypeId: json["chat_message_type_id"],
    senderId: json["sender_id"],
    receiverId: json["receiver_id"],
    message: json["message"],
    mediaMeta: json["media_meta"],
    isOneTimeView: json["is_one_time_view"],
    isOnVanishMode: json["is_on_vanish_mode"],
    scheduledAt: json["scheduled_at"],
    sentAt: json["sent_at"] == null ? null : DateTime.parse(json["sent_at"]),
    deliveredAt: json["delivered_at"] == null ? null : DateTime.parse(json["delivered_at"]),
    viewedAt: json["viewed_at"],
    stickerId: json["sticker_id"],
    giftOrderId: json["gift_order_id"],
    senderCoinTransactionId: json["sender_coin_transaction_id"],
    receiverCoinTransactionId: json["receiver_coin_transaction_id"],
    transferCoins: json["transfer_coins"],
    deletedForSenderBy: json["deleted_for_sender_by"],
    deletedForSenderAt: json["deleted_for_sender_at"],
    deletedForReceiverBy: json["deleted_for_receiver_by"],
    deletedForReceiverAt: json["deleted_for_receiver_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    mediaUrl: json["media_url"],
  );

  Map<String, dynamic> toJson() => {
    "chat_thread_id": chatThreadId,
    "chat_message_type_id": chatMessageTypeId,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "message": message,
    "media_meta": mediaMeta,
    "is_one_time_view": isOneTimeView,
    "is_on_vanish_mode": isOnVanishMode,
    "scheduled_at": scheduledAt,
    "sent_at": sentAt?.toIso8601String(),
    "delivered_at": deliveredAt?.toIso8601String(),
    "viewed_at": viewedAt,
    "sticker_id": stickerId,
    "gift_order_id": giftOrderId,
    "sender_coin_transaction_id": senderCoinTransactionId,
    "receiver_coin_transaction_id": receiverCoinTransactionId,
    "transfer_coins": transferCoins,
    "deleted_for_sender_by": deletedForSenderBy,
    "deleted_for_sender_at": deletedForSenderAt,
    "deleted_for_receiver_by": deletedForReceiverBy,
    "deleted_for_receiver_at": deletedForReceiverAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "media_url": mediaUrl,
  };
}

class Relationships {
  GiftOrder? sender;
  GiftOrder? sticker;
  GiftOrder? giftOrder;

  Relationships({
    this.sender,
    this.sticker,
    this.giftOrder,
  });

  factory Relationships.fromJson(Map<String, dynamic> json) => Relationships(
    sender: json["sender"] == null ? null : GiftOrder.fromJson(json["sender"]),
    sticker: json["sticker"] == null ? null : GiftOrder.fromJson(json["sticker"]),
    giftOrder: json["giftOrder"] == null ? null : GiftOrder.fromJson(json["giftOrder"]),
  );

  Map<String, dynamic> toJson() => {
    "sender": sender?.toJson(),
    "sticker": sticker?.toJson(),
    "giftOrder": giftOrder?.toJson(),
  };
}

class GiftOrder {
  Data? data;

  GiftOrder({
    this.data,
  });

  factory GiftOrder.fromJson(Map<String, dynamic> json) => GiftOrder(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  String? type;
  String? id;

  Data({
    this.type,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    type: json["type"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
  };
}
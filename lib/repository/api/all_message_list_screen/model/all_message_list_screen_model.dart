// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

List<MessageModel> messageModelFromJson(String str) => List<MessageModel>.from(json.decode(str).map((x) => MessageModel.fromJson(x)));

String messageModelToJson(List<MessageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageModel {
  String? type;
  String? id;
  Attributes? attributes;

  MessageModel({
    this.type,
    this.id,
    this.attributes,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    type: json["type"],
    id: json["id"],
    attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
    "attributes": attributes?.toJson(),
  };
}

class Attributes {
  DateTime? messageReceivedFromPartnerAt;
  int? authUserId;
  String? name;
  String? username;
  String? email;
  dynamic profilePhotoPath;
  dynamic profilePhotoId;
  String? phone;
  String? gender;
  int? countryId;
  String? countryName;
  int? stateId;
  String? stateName;
  int? cityId;
  String? cityName;
  String? customCityName;
  bool? isActive;
  String? customerCode;
  bool? isPremiumCustomer;
  bool? isOnline;
  dynamic bioIntroText;
  dynamic lastActiveAt;
  DateTime? dateOfBirth;
  int? nativeLanguageId;
  String? nativeLanguageName;
  dynamic referralCode;
  dynamic referredBy;
  dynamic referredId;
  String? profilePhotoUrl;
  String? square100ProfilePhotoUrl;
  String? square300ProfilePhotoUrl;
  String? square500ProfilePhotoUrl;
  int? age;

  Attributes({
    this.messageReceivedFromPartnerAt,
    this.authUserId,
    this.name,
    this.username,
    this.email,
    this.profilePhotoPath,
    this.profilePhotoId,
    this.phone,
    this.gender,
    this.countryId,
    this.countryName,
    this.stateId,
    this.stateName,
    this.cityId,
    this.cityName,
    this.customCityName,
    this.isActive,
    this.customerCode,
    this.isPremiumCustomer,
    this.isOnline,
    this.bioIntroText,
    this.lastActiveAt,
    this.dateOfBirth,
    this.nativeLanguageId,
    this.nativeLanguageName,
    this.referralCode,
    this.referredBy,
    this.referredId,
    this.profilePhotoUrl,
    this.square100ProfilePhotoUrl,
    this.square300ProfilePhotoUrl,
    this.square500ProfilePhotoUrl,
    this.age,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    messageReceivedFromPartnerAt: json["message_received_from_partner_at"] == null ? null : DateTime.parse(json["message_received_from_partner_at"]),
    authUserId: json["auth_user_id"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    profilePhotoPath: json["profile_photo_path"],
    profilePhotoId: json["profile_photo_id"],
    phone: json["phone"],
    gender: json["gender"],
    countryId: json["country_id"],
    countryName: json["country_name"],
    stateId: json["state_id"],
    stateName: json["state_name"],
    cityId: json["city_id"],
    cityName: json["city_name"],
    customCityName: json["custom_city_name"],
    isActive: json["is_active"],
    customerCode: json["customer_code"],
    isPremiumCustomer: json["is_premium_customer"],
    isOnline: json["is_online"],
    bioIntroText: json["bio_intro_text"],
    lastActiveAt: json["last_active_at"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    nativeLanguageId: json["native_language_id"],
    nativeLanguageName: json["native_language_name"],
    referralCode: json["referral_code"],
    referredBy: json["referred_by"],
    referredId: json["referred_id"],
    profilePhotoUrl: json["profile_photo_url"],
    square100ProfilePhotoUrl: json["square100_profile_photo_url"],
    square300ProfilePhotoUrl: json["square300_profile_photo_url"],
    square500ProfilePhotoUrl: json["square500_profile_photo_url"],
    age: json["age"],
  );

  Map<String, dynamic> toJson() => {
    "message_received_from_partner_at": messageReceivedFromPartnerAt?.toIso8601String(),
    "auth_user_id": authUserId,
    "name": name,
    "username": username,
    "email": email,
    "profile_photo_path": profilePhotoPath,
    "profile_photo_id": profilePhotoId,
    "phone": phone,
    "gender": gender,
    "country_id": countryId,
    "country_name": countryName,
    "state_id": stateId,
    "state_name": stateName,
    "city_id": cityId,
    "city_name": cityName,
    "custom_city_name": customCityName,
    "is_active": isActive,
    "customer_code": customerCode,
    "is_premium_customer": isPremiumCustomer,
    "is_online": isOnline,
    "bio_intro_text": bioIntroText,
    "last_active_at": lastActiveAt,
    "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "native_language_id": nativeLanguageId,
    "native_language_name": nativeLanguageName,
    "referral_code": referralCode,
    "referred_by": referredBy,
    "referred_id": referredId,
    "profile_photo_url": profilePhotoUrl,
    "square100_profile_photo_url": square100ProfilePhotoUrl,
    "square300_profile_photo_url": square300ProfilePhotoUrl,
    "square500_profile_photo_url": square500ProfilePhotoUrl,
    "age": age,
  };
}

class ChatProfile {
  final String id;
  final String name;
  final String username;
  final String email;
  final String? phone;
  final String? profilePhotoUrl;
  final String? lastMessageAt;
  final int? age;
  final bool isOnline;

  ChatProfile({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.phone,
    this.profilePhotoUrl,
    this.lastMessageAt,
    this.age,
    this.isOnline = false,
  });

  factory ChatProfile.fromJson(Map<String, dynamic> json) {
    return ChatProfile(
      id: json['id'] ?? '',
      name: json['attributes']['name'] ?? '',
      username: json['attributes']['username'] ?? '',
      email: json['attributes']['email'] ?? '',
      phone: json['attributes']['phone'],
      profilePhotoUrl: json['attributes']['profile_photo_url'],
      lastMessageAt: json['attributes']['message_received_from_partner_at'],
      age: json['attributes']['age'],
      isOnline: json['attributes']['is_online'] ?? false,
    );
  }
}
class Setting {
  final String appleLink;
  final String googleLink;
  final String email;
  final String phoneNumber;

  Setting({
    required this.appleLink,
    required this.googleLink,
    required this.email,
    required this.phoneNumber,
  });

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      appleLink: json['AppleLink'],
      googleLink: json['GoogleLink'],
      email: json['Email'],
      phoneNumber: json['PhoneNumber'],
    );
  }
}

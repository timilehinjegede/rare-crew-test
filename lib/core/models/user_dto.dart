class User {
  User({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
  });

  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phone;

  User copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
  }) {
    return User(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["email"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      phone: json["phone"],
    );
  }

  @override
  String toString() {
    return '$email, $firstName, $lastName, $phone';
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
      };
}

class User {
  User({
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.token,
  });

  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? token;

  User copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    String? token,
  }) {
    return User(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      token: token ?? this.token,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      token: json['token'],
    );
  }

  @override
  String toString() {
    return '$email, $firstName, $lastName, $phone';
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        if (token != null) 'token': token,
      };
}

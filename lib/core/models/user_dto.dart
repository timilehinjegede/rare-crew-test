class User {
  User({
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.token,
    this.password,
  });

  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? token;
  final String? password;

  User copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    String? token,
    String? password,
  }) {
    return User(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      token: token ?? this.token,
      password: password ?? this.password,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      token: json['token'],
      password: json['password'],
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
        'password': password,
        if (token != null) 'token': token,
      };
}

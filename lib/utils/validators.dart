bool isEmailAddressValid(String email) {
  final regex = RegExp(
    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
  );
  return regex.hasMatch(email);
}

bool isInputValid(String value) {
  return value.trim().isNotEmpty;
}

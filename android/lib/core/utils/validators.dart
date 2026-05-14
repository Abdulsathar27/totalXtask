class Validators {
  static String? validatePhone(
    String? value,
  ) {
    if (value == null ||
        value.trim().isEmpty) {
      return 'Enter phone number';
    }

    final phone =
        value.trim();

    // Only numbers
    if (!RegExp(r'^[0-9]+$')
        .hasMatch(phone)) {
      return 'Phone must contain only numbers';
    }

    // Exactly 10 digits
    if (phone.length != 10) {
      return 'Phone number must be 10 digits';
    }

    return null;
  }


  static String? validateName(
  String? value,
) {
  if (value == null ||
      value.trim().isEmpty) {
    return 'Enter name';
  }

  final name =
      value.trim();

  // Only letters and spaces
  if (!RegExp(r'^[a-zA-Z ]+$')
      .hasMatch(name)) {
    return 'Name must contain only letters';
  }

  // Minimum length
  if (name.length < 3) {
    return 'Name is too short';
  }

  return null;
}

static String? validateAge(
  String? value,
) {
  if (value == null ||
      value.trim().isEmpty) {
    return 'Enter age';
  }

  final age =
      int.tryParse(
    value.trim(),
  );

  // Must be valid number
  if (age == null) {
    return 'Enter valid age';
  }

  // Minimum age
  if (age < 1) {
    return 'Age must be greater than 0';
  }

  // Maximum age
  if (age > 120) {
    return 'Enter realistic age';
  }

  return null;
}
}
extension EmailValidator on String {
  String? get validateEmail {
    // Expresión regular básica para validar emails
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(pattern);

    if (!regex.hasMatch(this)) {
      return 'Enter a valid email';
    }
    return null;
  }
}

extension ValueEmpty on String {
  String? get validateValue {
    if (isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }
}

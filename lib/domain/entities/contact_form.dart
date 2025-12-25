class ContactForm {
  final String name;
  final String phone;
  final String email;
  final String message;

  const ContactForm({
    required this.name,
    required this.phone,
    required this.email,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'message': message,
    };
  }
}


class Contact {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  int phone;

  Contact(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      required this.phone});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          email == other.email &&
          phone == other.phone;

  @override
  int get hashCode =>
      firstName.hashCode ^ lastName.hashCode ^ email.hashCode ^ phone.hashCode;

  Contact.clone(Contact other)
      : this(
            id: other.id,
            firstName: other.firstName,
            lastName: other.lastName,
            email: other.email,
            phone: other.phone);

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
        id: json["id"] as int,
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["first_name"] = firstName;
    data["last_name"] = lastName;
    data["email"] = email;
    data["phone"] = phone;
    return data;
  }
}

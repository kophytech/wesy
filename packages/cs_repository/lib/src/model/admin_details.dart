class AdminDetails {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? region;

  const AdminDetails({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.region,
  });

  factory AdminDetails.fromJson(Map<String, dynamic> json) => AdminDetails(
        id: json['_id'] as String?,
        email: json['email'] as String?,
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        region: json['region'] as String?,
      );
}

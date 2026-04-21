class UserModel {
  final String fullName;
  final String email;
  final String id;
  final String? imageUrl;
  final String? publicId;

  UserModel({required this.fullName, required this.email, required this.id, this.imageUrl, this.publicId});

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      fullName: (json['fullName'] ?? '').toString().trim(),
      email: (json['email'] ?? '').toString().trim(),
      imageUrl: (json['imageUrl']?.toString().trim()),
      publicId: (json['publicId']?.toString().trim()),
    );
  }

  Map<String, dynamic> toJson() {
    return {'fullName': fullName, 'email': email, 'imageUrl': imageUrl, 'publicId': publicId};
  }
}

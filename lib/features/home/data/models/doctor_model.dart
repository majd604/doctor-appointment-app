class DoctorModel {
  final String id;
  final String name;
  final String specialty;
  final double rating;
  final String imageUrl;
  String? about;
  String? phone;
  double? callPrice;
  double? bookingPrice;
  double? messagePrice;
  DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.imageUrl,
    this.about,
    this.phone,
    this.callPrice,
    this.bookingPrice,
    this.messagePrice,
  });
  factory DoctorModel.fromJson(Map<String, dynamic> json, String id) {
    return DoctorModel(
      id: id,
      name: json['name'] as String,
      specialty: json['specialty'] as String,
      rating: (json['rating'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      about: json['about'] as String?,
      phone: json['phone'] as String?,
      callPrice: (json['callPrice'] as num?)?.toDouble(),
      bookingPrice: (json['bookingPrice'] as num?)?.toDouble(),
      messagePrice: (json['messagePrice'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'specialty': specialty,
      'rating': rating,
      'imageUrl': imageUrl,
      'about': about,
      'phone': phone,
      'callPrice': callPrice,
      'bookingPrice': bookingPrice,
      'messagePrice': messagePrice,
    };
  }
}

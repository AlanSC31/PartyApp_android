class Profile {
  final String name;
  final String genre;
  final String availability;
  final String rate;
  final String uid;

  Profile({
    required this.name,
    required this.genre,
    required this.availability,
    required this.rate,
    required this.uid,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] ?? '',
      genre: json['genre'] ?? '',
      availability: json['availability'] ?? '',
      rate: json['rate'] ?? '',
      uid:json['uid'] ?? '',
    );
  }
}

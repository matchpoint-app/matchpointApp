class ProfileInformation {
  String id;
  String name;
  String photoUrl;
  String description;
  String location;
  double rating;
  List<Map<String, double>> sports;
  List<dynamic> groups;
  List<dynamic> friends;

  ProfileInformation(
      {this.id,
      this.name,
      this.photoUrl,
      this.description,
      this.location,
      this.rating,
      this.sports,
      this.groups,
      this.friends});

  factory ProfileInformation.fromJson(dynamic json) {
    return ProfileInformation(
        id: json['id'] as String,
        name: json['name'] as String,
        photoUrl: json["photoUrl"] as String,
        description: json['description'] as String,
        location: json['location'] as String,
        rating: json['rating'] as double,
        sports: json['sports'] as dynamic,
        groups: json['groups'] as dynamic,
        friends: json['friends'] as List<dynamic>);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'photoUrl': photoUrl,
        'description': description,
        'location': location,
        'rating': rating,
        'sports': sports,
        'groups': groups,
        'friends': friends
      };
}

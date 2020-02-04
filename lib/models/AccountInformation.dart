class AccountInformation {
  String id;
  String name;
  String description;
  String location;
  double rating;
  List<Map<String, double>> sports;
  List<String> groups;
  List<String> friends;

  AccountInformation(
      {this.id,
      this.name,
      this.description,
      this.location,
      this.rating,
      this.sports,
      this.groups,
      this.friends});

  factory AccountInformation.fromJson(dynamic json) {
    return AccountInformation(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        location: json['location'] as String,
        rating: json['rating'] as double,
        sports: json['sports'] as dynamic,
        groups: json['groups'] as dynamic,
        friends: json['friends'] as dynamic);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'location': location,
        'rating': rating,
        'sports': sports,
        'groups': groups,
        'friends': friends
      };
}

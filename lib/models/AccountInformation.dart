class AccountInformation {
  final String id;
  final String userName;
  final String location;
  final double rating;
  final Map<String, double> sports;
  final List<String> groups;
  final List<String> friends;

  AccountInformation(
      {this.id,
      this.userName,
      this.location,
      this.rating,
      this.sports,
      this.groups,
      this.friends});

  factory AccountInformation.fromJson(dynamic json) {
    return AccountInformation(
        id: json['id'] as String,
        userName: json['userName'] as String,
        location: json['location'] as String,
        rating: json['rating'] as double,
        sports: json['sports'] as dynamic,
        groups: json['groups'] as dynamic,
        friends: json['friends'] as dynamic);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
        'location': location,
        'rating': rating,
        'sports': sports,
        'groups': groups,
        'friends': friends
      };
}

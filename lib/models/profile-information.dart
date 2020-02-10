import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matchpoint/models/sport.dart';

class ProfileInformation {
  String id;
  String name;
  String email;
  String photoUrl;
  String description;
  String location;
  double rating;
  List<Sport> sports;
  List<dynamic> groups;
  List<dynamic> friends;

  ProfileInformation(
      {this.id,
      this.name,
      this.email,
      this.photoUrl,
      this.description,
      this.location,
      this.rating,
      this.sports,
      this.groups,
      this.friends});

  factory ProfileInformation.fromJson(DocumentSnapshot doc) {
    var data = doc.data;

    return ProfileInformation(
        id: data['id'] as String,
        name: data['name'] as String,
        email: data['email'] as String,
        photoUrl: data["photoUrl"] as String,
        description: data['description'] as String,
        location: data['location'] as String,
        rating: data['rating'] as double,
        sports: (data['sports'] as List)
            .map((sport) => Sport.fromJson(sport))
            .toList(),
        groups: data['groups'] as List<dynamic>,
        friends: data['friends'] as List<dynamic>);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
        'description': description,
        'location': location,
        'rating': rating,
        'sports': sports,
        'groups': groups,
        'friends': friends
      };
}

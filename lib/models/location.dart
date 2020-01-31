class Location {
  final String name;
  final int latitude;
  final int longitude;

  Location(
      {this.name,
      this.latitude,
      this.longitude});

factory Location.fromJson(dynamic json) {
    return Location(
        name: json['name'] as String,
        latitude: json['latitude'] as int,
        longitude: json['longitude'] as int);
    }

   Map<String, dynamic> toJson() =>
  {
    'name': name,
    'latitude': latitude,
    'longitude': longitude
  };
}
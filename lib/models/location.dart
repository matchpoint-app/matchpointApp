class Location {
  final String name;
  final double latitude;
  final double longitude;

  Location(
      {this.name,
      this.latitude,
      this.longitude});

factory Location.fromJson(dynamic json) {
    return Location(
        name: json['name'] as String,
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double);
    }

   Map<String, dynamic> toJson() =>
  {
    'name': name,
    'latitude': latitude,
    'longitude': longitude
  };
}
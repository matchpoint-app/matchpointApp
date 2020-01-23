class Location {
  String name = 'Enskede Rackethall';
  int latitude = 10;
  int longitude = 20;

   Map<String, dynamic> toJson() =>
  {
    'name': name,
    'latitude': latitude,
    'longitude': longitude
  };
}
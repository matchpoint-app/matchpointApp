class Sport {
  String id;
  String name;

  Sport(
      {this.id,
      this.name});

  factory Sport.fromJson(dynamic json) {
    return Sport(
        id: json['id'] as String,
        name: json['name'] as String);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name
      };
}

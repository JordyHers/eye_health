import 'dart:convert';

class AppsModel {
  String name;
  String type;
  String usage;
  bool isfavourite;
  String image;

  AppsModel({
    this.name,
    this.type,
    this.usage,
    this.isfavourite,
    this.image,
  });

  AppsModel AppsModelcopyWith({
    String name,
    String type,
    String usage,
    bool isfavourite,
    String image,
  }) =>
      AppsModel(
        name: name ?? this.name,
        type: type ?? this.type,
        usage: usage ?? this.usage,
        isfavourite: isfavourite ?? this.isfavourite,
        image: image ?? this.image,
      );

  factory AppsModel.fromRawJson(String str) => AppsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AppsModel.fromJson(Map<String, dynamic> json) => AppsModel(
    // ignore: prefer_if_null_operators
    name: json['name'] == null ? null : json['name'],
    type: json['type'] == null ? null : json['type'],
    usage: json['usage'] == null ? null : json['usage'],
    isfavourite: json['isfavourite'] == null ? null : json["isfavourite"],
    image: json['image'] == null ? null : json['image'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'type':  type,
    'usage':  usage,
    'isfavourite':  isfavourite,
    'image':  image,
  };
}





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

  AppsModelcopyWith({
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
    name: json["name"] == null ? null : json["name"],
    type: json["type"] == null ? null : json["type"],
    usage: json["usage"] == null ? null : json["usage"],
    isfavourite: json["isfavourite"] == null ? null : json["isfavourite"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "type": type == null ? null : type,
    "usage": usage == null ? null : usage,
    "isfavourite": isfavourite == null ? null : isfavourite,
    "image": image == null ? null : image,
  };
}


import 'dart:convert';

RestaurantModel resturantModelFromJson(String str) => RestaurantModel.fromJson(json.decode(str));

String resturantModelToJson(RestaurantModel data) => json.encode(data.toJson());

class RestaurantModel {
  String status;
  String code;
  List<Details> data;

  RestaurantModel({
    required this.status,
    required this.code,
    required this.data,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) => RestaurantModel(
    status: json["status"],
    code: json["code"],
    data: List<Details>.from(json["data"].map((x) => Details.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Details {
  String id;
  String name;
  String tags;
  String rating;
  String discount;
  String primaryImage;
  String distance;

  Details({
    required this.id,
    required this.name,
    required this.tags,
    required this.rating,
    required this.discount,
    required this.primaryImage,
    required this.distance,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    id: json["id"],
    name: json["name"],
    tags: json["tags"],
    rating: json["rating"],
    discount: json["discount"],
    primaryImage: json["primary_image"],
    distance: json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "tags": tags,
    "rating": rating,
    "discount": discount,
    "primary_image": primaryImage,
    "distance": distance,
  };
}

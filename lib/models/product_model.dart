import 'dart:convert';

class ProductModel {
  ProductModel({
    required this.code,
    required this.data,
  });

  int code;
  List<Product> data;

  factory ProductModel.fromJson(String str) =>
      ProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        code: json["code"],
        data: List<Product>.from(json["data"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Product {
  Product(
      {required this.id,
      required this.title,
      required this.price,
      this.description,
      required this.category,
      required this.image});

  int id;
  String title;
  double price;
  String? description;
  String category;
  String image;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
      id: json["id"],
      title: json["title"],
      price: json["price"].toDouble(),
      description: json["description"],
      category: json["category"],
      image: json["image"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
      };
}

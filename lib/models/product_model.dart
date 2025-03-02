class ProductModel {
  int? totalSize;
  int? typeId;
  int? offset;
  List<Products>? productList;

  ProductModel({
    this.totalSize,
    this.typeId,
    this.offset,
    this.productList,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      totalSize: json["total_size"],
      typeId: json["type_id"],
      offset: json["offset"],
      productList: List<Products>.from(
          json["products"].map((e) => Products.fromJson(e))),
    );
  }
}

class Products {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  Products(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.stars,
      this.img,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.typeId});

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      stars: json['stars'],
      img: json['img'],
      location: json['location'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      typeId: json['type_id'],
    );
  }

  @override
  String toString() {
    return 'Products{id: $id, name: $name, description: $description, price: $price, stars: $stars, img: $img, location: $location, createdAt: $createdAt, updatedAt: $updatedAt, typeId: $typeId}';
  }
}

class HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel.FromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.FromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductsModel> products = [];

  HomeDataModel.FromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.FromJson(element));
    });

    json['products'].forEach((element) {
      products.add(ProductsModel.FromJson(element));
    });
  }
}

class BannerModel {
  int? id;
  String? image;

  BannerModel.FromJson(Map<String, dynamic> json) {
    id = json['id'];

    image = json['image'];
  }
}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic oldprice;
  int? discount;
  String? image;
  String? name;
  bool? favorites;
  bool? cart;

  ProductsModel.FromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldprice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    favorites = json['in_favorites'];
    cart = json['in_cart'];
  }
}

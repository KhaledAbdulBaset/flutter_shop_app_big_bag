class homeModel {
   bool? status;
   String? message;
  HomeData? homedata;

  homeModel.fromJson(Map<String,dynamic> jsonMap){
    this.status=jsonMap['status'];
    this.message=jsonMap['message'];
    this.homedata=HomeData.fromJson(jsonMap['data']);
  }
}

class HomeData {

  List<HomeDataBanar> homeDataBanar=[];
  List<HomeDataProduct> homeDataProduct=[];

  HomeData.fromJson(Map<String,dynamic> jsonMap){

    jsonMap['banners']
        .forEach((element){
      homeDataBanar.add(HomeDataBanar.fromJson(element));
                          });
    jsonMap['products']
        .forEach((element){
      homeDataProduct.add(HomeDataProduct.fromJson(element));
    });

  // this.homeDataBanar=HomeDataBanar.fromJson(jsonMap['banners']);
  // this.homeDataProduct=HomeDataProduct.fromJson(jsonMap['products']);
  }
}

class HomeDataBanar {

    int? id;
   String? image;
   // String? category;
   // String? product;

  HomeDataBanar.fromJson(Map<String,dynamic> jsonMap){
    this.id=jsonMap['id'];
    this.image=jsonMap['image'];
    // this.category=jsonMap['category'];
    // this.product=jsonMap['products'];
  }
}
class HomeDataProduct{
   dynamic? id;
   dynamic? price;
   dynamic? old_price;
   dynamic? discount;
   dynamic? image;
   dynamic? name;
   dynamic? in_favorites;
   dynamic? in_cart;

  HomeDataProduct.fromJson(Map<String,dynamic> jsonMap){
    this.id=jsonMap['id'];
    this.price=jsonMap['price'];
    this.old_price=jsonMap['old_price'];
    this.discount=jsonMap['discount'];
    this.image=jsonMap['image'];
    this.name=jsonMap['name'];
    this.in_favorites=jsonMap['in_favorites'];
    this.in_cart=jsonMap['in_cart'];
  }


}
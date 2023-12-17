class CategoriesModel{
  bool? status;
  String? message;
  CategoriesData? categoriesData;

  CategoriesModel.fromJson(Map<String,dynamic> jsonMap)
  {
    this.status=jsonMap['status'];
    this.message=jsonMap['message'];
    this.categoriesData=CategoriesData.fromJson(jsonMap['data']);
  }


}

class CategoriesData {
  int? currentPage;
  List<CategoryData> categoriesData = [];

  CategoriesData.fromJson(Map<String, dynamic> jsonMap){
    this.currentPage = jsonMap['current_page'];
    jsonMap['data'].forEach((element) {
      categoriesData.add(CategoryData.fromJson(element));
    });
  }
}

class CategoryData {
  int? id;
  String? name;
  String? image;

  CategoryData.fromJson(Map<String,dynamic> jsonMap){
  this.id=jsonMap['id'];
  this.name=jsonMap['name'];
  this.image=jsonMap['image'];
  }


}


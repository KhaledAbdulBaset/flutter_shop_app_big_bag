class FavModel{
  dynamic status;
  dynamic message;

  FavModel.fromJson(Map<String,dynamic> jsonMap){
  this.status=jsonMap['status'];
  this.message=jsonMap['message'];
  }
}

class AllFavModel{

  dynamic? status;
  dynamic? message;
   AllFavData? allFavData;

  AllFavModel.fromJson(Map<String,dynamic> jsonMap){
    this.status=jsonMap['status'];
    this.message=jsonMap['message'];
    allFavData=AllFavData.fromJson(jsonMap['data']);}
}
class AllFavData {

  dynamic? currentPage;
  List<FavDataItem> FavDataList = [];

  AllFavData.fromJson(Map<String,dynamic> jsonMap){
    this.currentPage=jsonMap['current_page'];
    jsonMap['data'].forEach((element){
      FavDataList.add(FavDataItem.fromJson(element));
    });
  }
  }


class FavDataItem{
    dynamic? id;
    FavDataItemDetails? favDataItemDetails;

    FavDataItem.fromJson(Map<String,dynamic> jsonMap){
      this.id=jsonMap['id'];
      this.favDataItemDetails=FavDataItemDetails.fromJson(jsonMap['product']);}
    }



class FavDataItemDetails{
  dynamic? id;
    dynamic? price;
    dynamic? oldPrice;
    dynamic? discount;
    dynamic? image;
    dynamic? name;

    FavDataItemDetails.fromJson(Map<String,dynamic> jsonMap){
      this.id=jsonMap['id'];
      this.price=jsonMap['price'];
      this.oldPrice=jsonMap['old_price'];
      this.discount=jsonMap['discount'];
      this.image=jsonMap['image'];
      this.name=jsonMap['name'];
    }
    }




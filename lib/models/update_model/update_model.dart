class updateModel{
  bool? status;
  String? message;
  UpdatedData? updatedData;

  updateModel.fromJson(Map<String,dynamic> jsonMap){
    this.status=jsonMap['status'];
    this.message=jsonMap['message'];
    this.updatedData=jsonMap['data']!=null?UpdatedData.fromJson(jsonMap['data']):null;
  }

}

class UpdatedData{

  String? name;
  String? phone;
  String? email;

  UpdatedData.fromJson(Map<String,dynamic> jsonMap){
    this.name=jsonMap['name'];
    this.phone=jsonMap['phone'];
    this.email=jsonMap['email'];
  }
}
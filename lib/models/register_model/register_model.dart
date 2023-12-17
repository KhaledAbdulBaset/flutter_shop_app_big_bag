class registerModel{
  bool? status;
  String? message;

  registerModel.fromJson(Map<String,dynamic> jsonMap){
    this.status=jsonMap['status'];
    this.message=jsonMap['message'];
  }
}

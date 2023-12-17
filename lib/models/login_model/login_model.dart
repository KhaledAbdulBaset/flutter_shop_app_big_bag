class loginModel{
  bool? status;
  String? message;
  userData? data;

  loginModel.fromJson(Map<String,dynamic> jsonMap)
  {
    status=jsonMap['status'];
    message=jsonMap['message'];
    data=jsonMap['data']!=null?userData.fromJson(jsonMap['data']):null;

  }

}
class userData{
  dynamic? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  dynamic? points;
  dynamic? credit;
  String? token;

  userData({required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credit,
    required this.token});

  userData.fromJson(Map<String,dynamic> jsonMap)
  {
    id = jsonMap['id'];
    name = jsonMap['name'];
    email = jsonMap['email'];
    phone = jsonMap['phone'];
    image = jsonMap['image'];
    points = jsonMap['points'];
    credit = jsonMap['credit'];
    token = jsonMap['token'];
  }




//named constructor



}

/*

 "status": true,
    "message": "تم تسجيل الدخول بنجاح",
    "data": {
        "id": 60397,
        "name": "Khalid Ssok",
        "email": "khalid654@gmail.com",
        "phone": "01236547890",
        "image": "https://student.valuxapps.com/storage/uploads/users/CQLTL3Loa4_1700097768.jpeg",
        "points": 0,
        "credit": 0,
        "token": "cOJE4y9uM3999BEvegmky02uhUb4wOp6ACzzlTj0tVGVRimwG6I3oFR5MdgMpY0e6gmRgU"
    }
}

 */
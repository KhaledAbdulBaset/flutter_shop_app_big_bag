import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/shared/network/local/cash_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class openingScreen extends StatelessWidget{
  var openingScreenController = PageController();

  List<openiningScreenModel> openiningScreenModelList =[
    openiningScreenModel(image: "assets/images/shp1.PNG", title: "screen 1", body: "body 1"),
    openiningScreenModel(image: "assets/images/shp2.PNG", title: "screen 2", body: "body 2"),
    openiningScreenModel(image: "assets/images/shp3.PNG", title: "screen 3", body: "body 3"),
  ];
  bool isLastOpeniningScreen=false;

  void Skip(context){
    cashHelper.saveDataIntoSharedPref(key: 'skipOnBoarding', value: true)
        .then((value) {
      if(value){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => loginScreen(),)
            ,(route) {return false;});
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          MaterialButton(onPressed: (){
            Skip(context);
          },child: Text("Skip",style: TextStyle(color: Color(0xff650015),fontSize: 20,fontWeight: FontWeight.w700),))

        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            Expanded(
              child: PageView.builder(
                onPageChanged: (index){
                  if(index==openiningScreenModelList.length-1){
                    isLastOpeniningScreen=true;
                  }
                  else{
                    isLastOpeniningScreen=false;

                  }
                },
                physics: BouncingScrollPhysics(),
                itemCount: openiningScreenModelList.length,
                controller: openingScreenController,
                itemBuilder: (context, index) {return openingItem(openiningScreenModelList[index]);},),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: openingScreenController,
                    count: openiningScreenModelList.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.deepOrange,
                    dotWidth: 10,
                    dotHeight: 10,
                    spacing: 4,
                    dotColor: Colors.grey
                  ),


                ),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if(isLastOpeniningScreen){
                    Skip(context);
                  }
                  else{
                    openingScreenController.nextPage(duration: Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);
                  }

                },
                  child: Icon(Icons.arrow_forward_ios),backgroundColor: Color(0xff650015),
                )
              ],
            )



          ],
        ),
      )

    );
    
  }
  
  
  Widget openingItem(
      openiningScreenModel model
      )=> Container(
    alignment: Alignment.center,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 300,
              height: 300,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // boxShadow: [BoxShadow(
                //     color: Colors.amberAccent,
                //     offset: Offset(1, 1),
                //     blurRadius: 1,
                //     spreadRadius: 1
                // )],
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,

              child: Image(image: AssetImage(model.image))),
          SizedBox(height: 30,),
          Text(model.title,style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
          SizedBox(height: 15,),
          Text(model.body,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
         
        ]),
  );
  
}

class openiningScreenModel{
  final String image;
  final String title;
  final String body;

  openiningScreenModel({required this.image,required this.title,required this.body});
}
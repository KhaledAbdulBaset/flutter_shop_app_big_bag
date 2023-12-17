import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class bottomSheetItem extends StatelessWidget{



  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.pink,
            ),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.black,
            ),
            Stack(
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  child: Row(children: [
                    Expanded(child: MaterialButton(onPressed: (){
                    },child: Container(height: 100,width: 90,decoration: BoxDecoration(color: Colors.purple,shape: BoxShape.circle),))),
                    SizedBox(width: 80,),
                    Expanded(child: Container(height: 100,width: 90,decoration: BoxDecoration(color: Colors.pink,shape: BoxShape.circle),))
                    ,SizedBox(width: 75,),
                    Expanded(child: Container(height: 100,width: 90,decoration: BoxDecoration(color: Colors.amberAccent,shape: BoxShape.circle),))

                  ]),
                ),
                ClipPath(
                  clipper: CustomClipperClass(),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

class CustomClipperClass extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
   double w = size.width;
   double h = size.height;
   final path = Path();

   path.moveTo(0, 0.5*h);
   path.quadraticBezierTo(0.1*w, h, 0.2*w, 0.5*h);
   path.quadraticBezierTo(0.3*w, 0, 0.4*w, 0.3*h);

   // path.lineTo(0.3*w, 0.2*h);
   path.quadraticBezierTo(0.5*w, h, 0.6*w, 0.5*h);
   path.quadraticBezierTo(0.7*w, 0, 0.8*w, 0.5*h);

   path.quadraticBezierTo(0.9*w, h, w, 0.5*h);

   // path.lineTo(0.1*w, h);
   // path.lineTo(0.2*w, 0.15*h);
   // path.lineTo(w, 0.3*h);
   path.lineTo(w, h);
   path.lineTo(0, h);


   return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
   return true;
  }

}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:simple_animated_button/elevated_layer_button.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic userData;
  Future<dynamic> fetchImage() async {
    final String url = 'https://dog.ceo/api/breeds/image/random';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      setState(() {
        userData = json;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight.r),
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(color: Colors.black),
            ),
            title: Center(
              child: Text(
                'Random Dog Images',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 30),
              ),
            ),
          )),
      body: Container(
        width: double.infinity.r,
        height: double.infinity.r,
        child: Column(
          children: [
            70.verticalSpace,
            if (userData == null)
              Text(
                'Press the Button',
                style: TextStyle(color: Colors.white),
              ),
            if (userData != null)
              Stack(children: [
                Center(
                  child: Container(
                    width: 250.r,
                    height: 240.r,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(300),
                    ),
                    child: Center(
                      child: Text(
                        'Loading...',
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5).r,
                    child: Container(
                      width: 240.r,
                      height: 230.r,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(150).r,
                          image: DecorationImage(
                              image: NetworkImage(userData['message']),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ),
              ]),


            // 30.verticalSpace,
            // Container(
            //   width: 200.r,
            //   height: 40.r,
            //   decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(30).r),
            //   child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //           backgroundColor: Colors.white),
            //       onPressed: () {
            //         setState(() {
            //           fetchImage();
            //         });
            //       },
            //       child: Text(
            //         'Next',
            //         style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),
            //       )),
            // ),
            30.verticalSpace,
            ElevatedLayerButton(
              onClick: () {
                setState(() {
                  fetchImage();
                });
              },
              buttonHeight: 60,
              buttonWidth: 200,
              animationDuration: const Duration(milliseconds: 200),
              animationCurve: Curves.ease,
              topDecoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
              ),
              topLayerChild: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Next",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10,),
                  Icon(Icons.arrow_forward_sharp)
                ],
              ),
              baseDecoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(),
              ),
            ),
            150.verticalSpace,
            Text('"Random Dog Images\n      Using Dog Api"',
                style: GoogleFonts.podkova(color: Colors.white, fontSize: 30)),
          ],
        ),
      ),
    );
  }
}

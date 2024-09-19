import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

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
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.purple, Colors.blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
            ),
            title: Text(
              'Random Dog Images',
              style: TextStyle(color: Colors.white),
            ),
          )),
      body: Container(
        width: double.infinity.r,
        height: double.infinity.r,
        child: Column(
          children: [
            20.verticalSpace,
            if (userData == null)
              Text(
                'Press the Button',
                style: TextStyle(color: Colors.white),
              ),
            if (userData != null)
              Stack(children: [
                Center(
                  child: Container(
                    width: 350.r,
                    height: 340.r,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(200),
                        gradient: LinearGradient(
                            colors: [Colors.purple, Colors.blue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight)),
                    child: Center(
                      child: Text(
                        '🐶Loading...',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0).r,
                    child: Container(
                      width: 300.r,
                      height: 300.r,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(150).r,
                          image: DecorationImage(
                              image: NetworkImage(userData['message']),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ),
              ]),
            30.verticalSpace,
            Container(
              width: 200.r,
              height: 40.r,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.purple, Colors.blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(30).r),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent),
                  onPressed: () {
                    setState(() {
                      fetchImage();
                    });
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            50.verticalSpace,
            ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                            colors: [Colors.purple, Colors.blue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight)
                        .createShader(
                      bounds,
                    ),
                child: Text('Dogs are Lovely Creatures',
                    style: GoogleFonts.italiana(
                        color: Colors.white, fontSize: 30))),
          ],
        ),
      ),
    );
  }
}

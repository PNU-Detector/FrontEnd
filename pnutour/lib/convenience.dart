import 'package:flutter/material.dart';

class convenience extends StatelessWidget {
  const convenience({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:Scaffold(
            appBar: AppBar(
              title: Text(
                  "편의시설",
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 2.0,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  )
              ),
              centerTitle: true,
              backgroundColor: Color.fromRGBO(15, 85, 190, 1),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
            body: Text("내용")
        )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:postapi/post_login.dart';

void main() {
  runApp(new MyApp());
}




class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Home()
    );
  }
}

class Home extends StatelessWidget{


  String url = "http://13.250.59.224:56321/api/users/login";
  callAPI(){
    Post post = Post();
    createPost(post, url).then((response){
      if(response.statusCode > 200) {
        print(response.body);
      }
      else {
        print(response.statusCode);
      }
    }).catchError((error){
      print('error : $error');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body : FutureBuilder<Post>(
            future: getPost(url, "OAISJFAOISFJASF"),
            builder: (context, snapshot) {
              callAPI();
              if(snapshot.connectionState == ConnectionState.done) {
                if(snapshot.hasError){
                  return Text("Error");
                }
                return Text('UserID JSON : ${snapshot.data.userID}');
              }
              else
                return CircularProgressIndicator();
            }
        )
    );
  }

}
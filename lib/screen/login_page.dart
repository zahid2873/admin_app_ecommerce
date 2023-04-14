import 'dart:convert';

import 'package:admin_app_ecommerce/screen/navbar/home_page.dart';
import 'package:admin_app_ecommerce/screen/navbar/nav_bar_page.dart';
import 'package:admin_app_ecommerce/widget/custome_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String baseUrl = "http://temp.techsolutions-bd.com/api/admin/";

  bool isObscure=true;
  int pressCount=0;


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      opacity: .2,
      blur: .5,
      progressIndicator: spinkit,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Login",style: textStyle(28,Colors.blue,FontWeight.bold),),
              Form(key:_formKey, child: Column(
                children: [
                  SizedBox(height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      border: OutlineInputBorder(),
                    ),
                    validator:(value){
                      if(value == null || value.isEmpty || !value.contains('@') || !value.contains('.')){
                        return 'Invalid Email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      suffixIcon:IconButton(onPressed: (){
                        setState(() {
                          if(pressCount % 2==0){
                            isObscure=false;
                          }else{
                            isObscure=true;
                          }
                          pressCount++;
                        }
                        );
                      }, icon: pressCount%2==0? Icon(Icons.visibility): Icon(Icons.visibility_off)
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator:(value){
                      if(value!.isEmpty) {
                        return "Please enter password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  MaterialButton(
                    height: 60,
                    minWidth: double.infinity,
                    color: Colors.blue,
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        getLogin();
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                      }

                    },
                    child: Text('Login'),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
  bool isLoading=false;
  getLogin()async{
    try{
      setState(() {
        isLoading=true;
      });
      String url = "${baseUrl}sign-in";
      var map = Map<String, dynamic>();
      map["email"] = emailController.text.toString();
      map["password"] = passwordController.text.toString();
      var responce = await http.post(Uri.parse(url),body: map);
      var data = jsonDecode(responce.body);
      setState(() {
        isLoading=false;
        // if(responce.statusCode==200){
        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        // }else{
        //   print("Api integration is unsuccessful");
        // }
      });
      print("Responce is ${data}");
      print("Status code is ${responce.statusCode}");

      if(responce.statusCode==200){
        showInToast("Login Successfull");
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('token', data["access_token"]);
        print("Saved token is  ${sharedPreferences.getString("token")}");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBarPage()));

      }else{
        showInToast("Invalid email or password");
      }


    }catch(e){
      print("Something wrong $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    isLogin();
    super.initState();
  }


  isLogin()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    if(token!=null){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBarPage()));
    }
  }


}

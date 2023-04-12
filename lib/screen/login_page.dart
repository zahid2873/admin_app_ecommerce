import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure=true;
  int pressCount=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Login",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Enter your email",
                border: OutlineInputBorder(),
              ),
              validator:(emailController){},
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
                    isObscure=false;}
                    else{
                      isObscure=true;
                    };
                    pressCount++;
                  }
                  );
                }, icon: pressCount%2==0? Icon(Icons.visibility): Icon(Icons.visibility_off)
                ),
                border: OutlineInputBorder(),
              ),
              validator:(emailController){},
            ),
            SizedBox(height: 20,),
            MaterialButton(
              height: 60,
              minWidth: double.infinity,
              color: Colors.blue,
              onPressed: (){},
              child: Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}

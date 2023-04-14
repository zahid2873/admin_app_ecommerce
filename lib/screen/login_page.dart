import 'package:admin_app_ecommerce/screen/navbar/home_page.dart';
import 'package:admin_app_ecommerce/widget/custome_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                    }

                  },
                  child: Text('Login'),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

}

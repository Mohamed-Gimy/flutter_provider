import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';


void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Tips',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {

  bool showBottomMenu = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  bool _emailError = false, _passError = false, _loading = false;
  bool isDealer = true;

  @override
  Widget build(BuildContext context) {
    ThemeData _currentTheme = Theme.of(context);

    double height = MediaQuery.of(context).size.height;

    var thershold = 100;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlue ,
        body: GestureDetector(
          onPanEnd: (details){
           if(details.velocity.pixelsPerSecond.dy > thershold){
             this.setState(() {
               showBottomMenu = false;
             });
           }else if(details.velocity.pixelsPerSecond.dy < -thershold){
             this.setState(() {
               showBottomMenu = true;
             });
           }
          },
          child: Container(
            height: height,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    child: Container(
                      //height: MediaQuery.of(context).size.height * 0.80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Text("Judy♥", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.black),),
                          ),
                          SizedBox(height: 10,),
                          TextField(
                            maxLines: 1,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: _currentTheme.accentColor,
                            decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Colors.white,
                              ),
                              errorText: (_emailError) ? "Invalid Email" : null,
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          TextField(
                            maxLines: 1,
                            controller: _passController,
                            obscureText: true,
                            cursorColor: _currentTheme.accentColor,
                            decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.white,
                              ),
                              errorText: (_passError) ? "Invalid Password" : null,
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                              filled: false,
                            ),
                          ),
                          TextField(
                            maxLines: 1,
                            controller: _passController,
                            obscureText: true,
                            cursorColor: _currentTheme.accentColor,
                            decoration: InputDecoration(
                              hintText: "Confirmed Password",
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              errorText: (_emailError) ? "Invalid Password" : null,
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                              filled: false,
                            ),
                          ),
                          SizedBox(height: 10,),
                          TextField(
                            maxLines: 1,
                            controller: _passController,
                            obscureText: true,
                            cursorColor: _currentTheme.accentColor,
                            decoration: InputDecoration(
                              hintText: "Full Name",
                              prefixIcon: Icon(
                                Icons.person_pin,
                                color: Colors.white,
                              ),
                              errorText: (_passError) ? "Invalid Password" : null,
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                              filled: false,
                            ),
                          ),
                          SizedBox(height: 10,),
                          AbsorbPointer(
                            absorbing: _loading,
                            child: SizedBox(
                              width: double.infinity,
                              child: MaterialButton(
                                color: Colors.green,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("LOGIN", style: TextStyle(color: Colors.white),),
                                      SizedBox(width: 10,),
                                    ],
                                  ),
                                ),
                                onPressed: (){
                                  String email = _emailController.text.trim();
                                  String pass = _passController.text.trim();
                                  this.setState(() {
                                    _emailError = email == "";
                                    _passError = pass == "";
                                  });
                                  if(!(_emailError || _passError)) {}
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: (){},
                                    child: Text("Forget Password ? ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 15),),
                                  ),
                                 GestureDetector(
                                   onTap: () {},
                                   child: Text("Skip Login > ", style: TextStyle(fontSize: 15, color: Colors.black,),),
                                 )
                                ],
                              ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                AnimatedOpacity(
                    duration: Duration(milliseconds: 200),
                    opacity: (showBottomMenu)?1.0:0.0,
                  child: BackdropFilter(
                    filter:
                    ImageFilter.blur(sigmaY: 5.0, sigmaX: 5.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: 200),
                  left: 0,
                  bottom: (showBottomMenu)?-50:-(height/3),
                  child: MenuWidget(),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      child: Container(
          color: Colors.pinkAccent,
        width: width,
        height: height/3 + 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
          child: Column(
            children: [
              Icon(Icons.keyboard_arrow_up, size: 20,),
              Text("Social Logins", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
              Text("Choose Whichever you use frequently!"),
              SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Login With Google", style: TextStyle(color: Colors.white),),
                        SizedBox(width: 10,),
                      ],
                    ),
                  ),
                  onPressed: (){},
                ),
              ),
              SizedBox(width: double.infinity,
                child: MaterialButton(
                  color: Colors.lightBlue.shade900,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Login With Facebook", style: TextStyle(color: Colors.white),),
                        SizedBox(width: 10,),
                      ],
                    ),
                  ),
                  onPressed: (){},
                ),
              ),
              SizedBox(width: double.infinity,
              child: MaterialButton(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Login With Twitter", style: TextStyle(color: Colors.white),),
                    SizedBox(width: 10,),
                  ],
                ),
              ),
              onPressed: (){},
            ),
              )
             ],
              ),
        )
      ),
    );
  }
}

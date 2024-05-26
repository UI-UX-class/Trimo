import 'package:flutter/material.dart';
import './SignUp.dart';
import './main.dart';

class SignInTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignIn();
  }
}

class _SignIn extends State<SignIn> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(' '),
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30.0, bottom: 40.0),
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.blueAccent, Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    'TRIMO',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Center(
                  child: SizedBox(
                      width: 300,
                      child: Column(children: [
                        Container(
                          child: Stack(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(3.0),
                                child: Row(children: [
                                  Image.asset(
                                    'assets/login_back.png',
                                    height: 220,
                                    width: 300,
                                    fit: BoxFit.fill,
                                  ),
                                ]),
                              ),
                              Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 20, left: 20, bottom: 10),
                                      child: Text(
                                        '아이디',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, bottom: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: SizedBox(
                                        height: 40,
                                        width: 270,
                                        child: TextField(
                                          controller: _idController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'ID',
                                            contentPadding: EdgeInsets.all(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, bottom: 10),
                                      child: Text(
                                        '비밀번호',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, bottom: 35),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: SizedBox(
                                        height: 40,
                                        width: 270,
                                        child: TextField(
                                          controller: _passwordController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Password',
                                            contentPadding: EdgeInsets.all(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xAA1A4066),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () {
                              String id = _idController.text;
                              String password = _passwordController.text;
                              print('ID: $id, Password: $password');
                              Navigator.pushNamed(context, '/mainPage');
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 2.0,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 20, right: 5),
                                  child: Text(
                                    "계정이 없으신가요?",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/signUpPage');
                                  },
                                  child: Text(
                                    "회원가입  ->",
                                    style: TextStyle(
                                      color: Colors.blueAccent[700],
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ])))
            ]),
      ),
    );
  }
}

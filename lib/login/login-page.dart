import 'package:Iloop/Utility/Utility.dart';
import 'package:Iloop/models/login-models.dart';
import 'package:Iloop/models/response.dart';
import 'package:Iloop/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:Iloop/home/home-page.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  IloopService get service => GetIt.I<IloopService>();
  UtilityClass get utility => GetIt.I<UtilityClass>();
  var userField = TextEditingController();
  var passworkField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final logo = Container(
      alignment: AlignmentDirectional.topCenter,
      child: CircleAvatar(
        radius: 100,
        backgroundColor: Colors.transparent,
        child: Image.asset('assets/img/logo_veripark1.png'),
      ),
    );

    final user = Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: userField,
        autofocus: false,
        style: TextStyle(color: Colors.black, fontSize: 15),
        decoration: InputDecoration(
          hintText: "VPHQ\\***",
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(74, 186, 173, 1))),
          icon: Icon(
            Icons.mail,
            color: Colors.grey,
          ),
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
      ),
    );

    final password = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      padding: EdgeInsets.fromLTRB(0, 0, 20.0, 0),
      child: TextFormField(
        controller: passworkField,
        autofocus: false,
        obscureText: true,
        style: TextStyle(color: Colors.black, fontSize: 15),
        decoration: InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(74, 186, 173, 1))),
          hintText: "******",
          icon: Icon(
            Icons.vpn_key,
            color: Colors.grey,
          ),
          filled: true,
          focusColor: Colors.white,
          fillColor: Colors.white,
          //contentPadding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
      ),
    );
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: () {
          loginClick();
        },
        padding: EdgeInsets.all(12),
        color: Color.fromRGBO(74, 186, 173, 1),
        child: Text('Login', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Image.asset(
          "assets/img/background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        logo,
        Center(
            child: Container(
          margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.4), blurRadius: 10.0)
            ],
          ),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              SizedBox(height: 10.0),
              Text( 
                "Login",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 38.0),
              Text(
                "User Name",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins-Bold"),
              ),
              user,
              SizedBox(height: 8.0),
              Text(
                "Password",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins-Bold"),
              ),
              password,
              SizedBox(height: 24.0),
              loginButton
            ],
          ),
        )),
      ],
    ));
  }

  Future<String> _asyncInputDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.all(12),
            title: Text("You entered incorrect customer number or password. Please check and retry."),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "OK",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins-Bold"),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]);
      },
    );
  }

  void loginClick() async {
    UserModelRequest userModel = UserModelRequest(
        userName: userField.text.replaceAll(" ", ""), password: passworkField.text.replaceAll(" ", ""));
    utility.onLoading(context);
    APIResponse<UserModelResponse> response = await service.login(userModel);
    Navigator.pop(context); 
    if (response.data.authenticated) {
      var router = new MaterialPageRoute(builder: (BuildContext context)=> new HomePage(response.data.fullName));
      Navigator.of(context).push(router);
    } else {
      await _asyncInputDialog(context);
    }
  } 
}

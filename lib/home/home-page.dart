import 'package:Iloop/Utility/CustomClipper.dart';
import 'package:flutter/material.dart';
import 'package:Iloop/expense-create/expense-create-page.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  String userName;
  HomePage(this.userName);
  @override
  _HomePageState createState() => new _HomePageState(this.userName);
}

class _HomePageState extends State<HomePage> {
  String userName;
  _HomePageState(this.userName);
  @override
  Widget build(BuildContext context) {
    final logo = Container(
        alignment: AlignmentDirectional.topCenter,
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.transparent,
              child: Image.asset('assets/img/logo_veripark1.png'),
            ),
            Text(
              "WELCOME",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              userName,
              style: TextStyle(fontSize: 20, color: Colors.white),
            )
          ],
        ));
    final expenseButton = Positioned(
      width: MediaQuery.of(context).size.width-20,
      top:MediaQuery.of(context).size.height/ 3*2+30,
      left: 10,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        onPressed: () {
          expenseCreate();
        },
        padding: EdgeInsets.all(12),
        color: Colors.white,
        child: Text('SUBMİT NEW EXPENSE', style: TextStyle(color: Colors.black,fontSize: 17)),
      ),
    );

    return Scaffold(
        body: Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomMainClipper(),
          child: Image.asset(
            "assets/img/background.png",
            height: MediaQuery.of(context).size.height / 3*2,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),
        logo,
        expenseButton
      ],
    ));
  }

  void expenseCreate() {
    var router = new MaterialPageRoute(builder: (BuildContext context)=> new ExpenseCreate(userName!= null ? userName:""));
      Navigator.of(context).push(router);
  }
}

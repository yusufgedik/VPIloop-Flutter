import 'package:Iloop/home/home-page.dart';
import 'package:Iloop/models/expense-model.dart';
import 'package:Iloop/models/response.dart';
import 'package:Iloop/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class ExpenseCreate extends StatefulWidget {
  static String tag = 'expense-create';
  String userName;
  ExpenseCreate(this.userName);
  @override
  _ExpenseCreate createState() => _ExpenseCreate(this.userName);
}

class _ExpenseCreate extends State<ExpenseCreate> {
  IloopService get service => GetIt.I<IloopService>();
  String userName;
  _ExpenseCreate(this.userName) {
    initialize();
  }
  static String tag = 'home-page';
  static var format = new DateFormat.yMMMd("en_US");
  String _selectedDate = format.format(DateTime.now());
  final expensefield = TextEditingController();
  final datefield = TextEditingController();
  final billnofield = TextEditingController();
  final descriptionField = TextEditingController();
  List<String> poListItem = ["------"];
  var poSelectedItem = "------";
  List<String> projectListItem = ["No Project"];
  var projectSelectedItem = "No Project";
  List<String> currencyListItem = ["TL"];
  var currencySelectedItem = "TL";
  List<KeyValuePairs> currencyResponse;
  List<KeyValuePairs> projectResponse;
  @override
  Widget build(BuildContext context) {
    datefield.text = _selectedDate;
    final header = AppBar(
      title: Text("New Expense"),
      backgroundColor: Color.fromRGBO(74, 186, 173, 1),
      actions: <Widget>[
        // FlatButton(
        //   textColor: Colors.white,
        //   onPressed: () {},
        //   child: Icon(
        //     Icons.photo_camera,
        //     color: Colors.white,
        //     size: 34,
        //   ),
        //   shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
        // ),
      ],
    );
    final dateView = Container(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("DATE",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          Stack(
            children: <Widget>[
              FlatButton(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: TextFormField(
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.datetime,
                    controller: datefield,
                    enabled: false,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      filled: true,
                      focusColor: Colors.transparent,
                      disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(74, 186, 173, 1))),
                      contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0),
                    ),
                  )),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0),
                    child: Icon(
                      Icons.calendar_today,
                      size: 25,
                      color: Colors.grey,
                    ),
                  ))
            ],
          )
        ],
      ),
    );
    final billNoView = Container(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("PLUG",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          TextFormField(
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            controller: billnofield,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              fillColor: Colors.transparent,
              filled: true,
              focusColor: Colors.transparent,
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(74, 186, 173, 1))),
              contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0),
            ),
          )
        ],
      ),
    );
    final pOView = Container(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("PO",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          Column(children: <Widget>[
            DropdownButton<String>(
              isExpanded: true,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              value: poSelectedItem,
              items: poListItem
                  .map((code) =>
                      new DropdownMenuItem(value: code, child: new Text(code)))
                  .toList(),
              onChanged: (String newValue) {
                poListChange(newValue);
              },
              underline: Container(
                height: 2,
                color: Colors.grey,
              ),
              iconSize: 24,
            )
          ])
        ],
      ),
    );
    final projectListView = Container(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("PROJECT",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          Column(children: <Widget>[
            DropdownButton<String>(
              isExpanded: true,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              value: projectSelectedItem,
              items: projectListItem
                  .map((code) =>
                      new DropdownMenuItem(value: code, child: new Text(code)))
                  .toList(),
              onChanged: (String newValue) {
                projectListChange(newValue);
              },
              underline: Container(
                height: 2,
                color: Colors.grey,
              ),
              iconSize: 24,
            )
          ])
        ],
      ),
    );
    final expenseView = Container(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("EXPENSE",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          TextFormField(
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            controller: expensefield,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              fillColor: Colors.transparent,
              filled: true,
              focusColor: Colors.transparent,
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(74, 186, 173, 1))),
              contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            ),
          )
        ],
      ),
    );
    final currencyListView = Container(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("CURRENCY",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          Column(children: <Widget>[
            DropdownButton<String>(
              isExpanded: true,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              value: currencySelectedItem,
              items: currencyListItem
                  .map((code) =>
                      new DropdownMenuItem(value: code, child: new Text(code)))
                  .toList(),
              onChanged: (String newValue) {
                currencyListChange(newValue);
              },
              underline: Container(
                height: 2,
                color: Colors.grey,
              ),
              iconSize: 24,
            )
          ])
        ],
      ),
    );
    final descriptionView = Container(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("DESCRIPTION",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          TextFormField(
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            controller: descriptionField,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              fillColor: Colors.transparent,
              filled: true,
              focusColor: Colors.transparent,
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(74, 186, 173, 1))),
              contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            ),
          )
        ],
      ),
    );
    final actionView = Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
        child: Row(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              onPressed: () {
                cancelExpense(context);
              },
              padding: EdgeInsets.all(22),
              color: Colors.red,
              child: Text('CANCEL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  )),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              onPressed: () {
                saveExpense(context);
              },
              padding: EdgeInsets.all(22),
              color: Colors.white,
              child: Text('SAVE',
                  style: TextStyle(color: Colors.black, fontSize: 17)),
            ),
          )
        ]));

    final body = Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              header,
              dateView,
              billNoView,
              pOView,
              projectListView,
              expenseView,
              currencyListView,
              descriptionView,
              actionView
            ],
          ),
        ));

    return Scaffold(
      body: body,
    );
  }

  void saveExpense(context) async {
      ExpenseRequest request = new ExpenseRequest();
      request.id = "0";
      request.expense = expensefield.text;
      request.description = descriptionField.text;
      request.plug = billnofield.text;
      request.isvisible = "true"; 
      request.currency = currencySelectedItem;
      request.currencyKey = currencyResponse
          .singleWhere((i) => i.value == currencySelectedItem)
          .key;
      request.project = projectSelectedItem;
      request.projectKey = projectResponse
          .singleWhere((i) => i.value == projectSelectedItem)
          .key;
      request.date = "date " +
          datefield.text 
              .replaceAll("/", " ")
              .replaceAll(",", " ").replaceAll("  ", " "); 
    APIResponse<KeyValuePairs> save = await service.saveExpense(request);
    await _asyncInputDialog(context,
          save.data.value );
  }

  Future<String> _asyncInputDialog(BuildContext context, text) async {
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.all(12),
            title: Text(text),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime d = await showDatePicker(
      //we wait for the dialog to return
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );
    if (d != null) //if the user has selected a date
      setState(() {
        _selectedDate = new DateFormat.yMMMd("en_US").format(d);
      });
  }

  void poListChange(String newValue) {
    setState(() {
      poSelectedItem = newValue;
    });
  }

  void projectListChange(String newValue) {
    setState(() {
      projectSelectedItem = newValue;
    });
  }

  void currencyListChange(String newValue) {
    setState(() {
      currencySelectedItem = newValue;
    });
  }

  void cancelExpense(context) {
    var router = new MaterialPageRoute(
        builder: (BuildContext context) =>
            new HomePage(userName != null ? userName : ""));
    Navigator.of(context).push(router);
  }

  List<String> parseResponse(list) {
    List<String> listItem = [];
    if (list.data.hasError) {
      cancelExpense(context);
    }
    for (var item in list.data.keyValuePairs) {
      listItem.add(item.value);
    }
    return listItem;
  }

  void initialize() async {
    var projects = await service.getProjectsService();
    var currency = await service.getCurrencyService();
    setState(() {
      currencyResponse = currency.data.keyValuePairs;
      projectResponse = projects.data.keyValuePairs;
      projectListItem = parseResponse(projects);
      projectSelectedItem = projectListItem[0];
      currencyListItem = parseResponse(currency);
      currencySelectedItem = currencyListItem[0];
    });
  }
}

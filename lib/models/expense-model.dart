import 'package:flutter/cupertino.dart';

class ExpenseResponse {
  List<KeyValuePairs> keyValuePairs;
  bool hasError;

  ExpenseResponse({this.keyValuePairs,this.hasError});
  factory ExpenseResponse.fromJson(Map<String, dynamic> item) {
    return ExpenseResponse(
        keyValuePairs: item['keyValuePairs'],
        hasError: item['hasError']);
  }
}

class KeyValuePairs {
  String key;
  String value;
  KeyValuePairs({this.key,this.value});
  factory KeyValuePairs.fromJson(Map<String, dynamic> item) {
    return KeyValuePairs(
        key: item['key'],
        value: item['value']);
  }
}

class ExpenseRequest {
String id;
String project;
String projectKey;
String date;
String currency; 
String currencyKey;
String plug;
String expense;
String description;
String isvisible;

  ExpenseRequest({@required this.id, @required this.project, @required this.projectKey, @required this.date, @required this.currency, @required this.currencyKey, @required this.plug, @required this.expense, @required this.description, @required this.isvisible});
  Map<String, dynamic> toJson() => {
        'id': id,
        'Project': project,
        'ProjectKey': projectKey,
        'Date': date,
        'Currency': currency,
        'CurrencyKey': currencyKey,
        'Plug': plug,
        'Expense': expense,
        'Description': description,
        'Isvisible': isvisible,
      };
}
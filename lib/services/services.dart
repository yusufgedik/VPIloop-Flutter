import 'dart:convert';
import 'dart:io';
import 'package:Iloop/models/expense-model.dart';
import 'package:Iloop/models/login-models.dart';
import 'package:Iloop/models/response.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

const service = 'https://ilooppowerapps.veripark.com';
//const service = 'http://192.168.1.38/Iloop.WebApi';
class IloopService {
  static const saveActivityUrl = service + '/api/Activity/SaveActivity';
  static const loginUrl = service + '/api/auth/post';
  static const missingDayUrl = service + '/api/Activity/GetMissingDays';
  static const getActivityTypeUrl = service + '/api/Activity/GetActivityTypes';
  static const getProjectUrl = service + '/api/Activity/GetProjects';
  static const getSubProjectUrl = service + '/api/Activity/GetSubProject';
  static const getCustomerUrl = service + '/api/Activity/GetCustomers';
  static const getActivities = service + '/api/Activity/GetActivities';
  static const getActivityCount = service + '/api/Activity/GetActivityCount';
  static const getAudit = service + '/api/User/GetAudit';
  static const getExpenseProjectUrl = service + '/api/User/GetExpenseProjects';
  static const getExpenseCurrencyUrl = service + '/api/User/GetExpenseCurrency';
  static const saveExpenseUrl = service + '/api/User/SaveExpense';
  static const serverUpLoadImgUrl = service + '/api/User/UPLoadImage';
  Map<String, String> headers = {'Content-Type': 'application/json'};

  Future<APIResponse<UserModelResponse>> login(UserModelRequest post) async {
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = new IOClient(httpClient);
    final dyn = post.toJson();
    final postJson = json.encode(dyn);
    final data = await ioClient.post(loginUrl,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: postJson);
    String rawCookie = data.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
    return APIResponse<UserModelResponse>(
        data: UserModelResponse.fromJson(json.decode(data.body)));
  }

  Future<APIResponse<ExpenseResponse>> getProjectsService() async {
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = new IOClient(httpClient);
    final data = await ioClient.get(getExpenseProjectUrl, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.cookieHeader: headers["cookie"]
    });
    final jsonData = json.decode(data.body);
    final projects = <KeyValuePairs>[];
    for (var item in jsonData['keyValuePairs']) {
      projects.add(KeyValuePairs.fromJson(item));
    }
    final responseOb = new ExpenseResponse();
    responseOb.hasError = jsonData['hasError'];
    responseOb.keyValuePairs = projects;
    return APIResponse<ExpenseResponse>(data: responseOb);
  }

  Future<APIResponse<ExpenseResponse>> getCurrencyService() async {
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = new IOClient(httpClient);
    final data = await ioClient.get(getExpenseCurrencyUrl, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.cookieHeader: headers["cookie"]
    });
    final jsonData = json.decode(data.body);
    final projects = <KeyValuePairs>[];
    for (var item in jsonData['keyValuePairs']) {
      projects.add(KeyValuePairs.fromJson(item));
    }
    final responseOb = new ExpenseResponse();
    responseOb.hasError = jsonData['hasError'];
    responseOb.keyValuePairs = projects;
    return APIResponse<ExpenseResponse>(data: responseOb);
  }

  Future<APIResponse<KeyValuePairs>> saveExpense(ExpenseRequest post) async {
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = new IOClient(httpClient);
    final dyn = post.toJson();
    final postJson = "["+json.encode(dyn)+"]";
    final data = await ioClient.post(saveExpenseUrl,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.cookieHeader: headers["cookie"]
        },
        body: postJson);
    return APIResponse<KeyValuePairs>(
        data: KeyValuePairs.fromJson(json.decode(data.body)));
  }
 }

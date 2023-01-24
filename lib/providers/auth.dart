import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../secrets/secrets.dart';
import '../model/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String authMethod) async {
    try {
      final url =
          'https://identitytoolkit.googleapis.com/v1/accounts:${(authMethod == 'signup') ? 'signUp' : 'signInWithPassword'}?key=${Secrets().apiKey}';

      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password,
      [Future<Object> pushReplacement]) async {
    return _authenticate(email, password, 'signup');
    // final url =
    //     'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${Secrets().apiKey}';

    // final response = await http.post(
    //   url,
    //   body: json.encode(
    //     {
    //       'email': email,
    //       'password': password,
    //       'returnSecureToken': true,
    //     },
    //   ),
    // );
    // print(json.decode(response.body));
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'login');
    // final url =
    //     'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${Secrets().apiKey}';

    // final response = await http.post(
    //   url,
    //   body: json.encode(
    //     {
    //       'email': email,
    //       'password': password,
    //       'returnSecureToken': true,
    //     },
    //   ),
    // );
    // print(json.decode(response.body));
  }
}

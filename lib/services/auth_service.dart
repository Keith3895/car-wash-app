import 'package:car_wash/models/user_details.dart';
import 'package:car_wash/repos/authRepo.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class AuthService extends ChangeNotifier {
  AuthService._();
  static final instance = AuthService._();

  final storageBox = Hive.box('auth_service_box');
  String? _accessToken;
  String? _refreshToken;
  DateTime? _accessTokenExpiry;
  String get accessToken => _accessToken?.isNotEmpty ?? true ? '$_accessToken' : '';

  Future<String> getAccessToken() async {
    if (_accessTokenExpiry != null && DateTime.now().isAfter(_accessTokenExpiry!)) {
      // The access token has expired, refresh it
      accessToken = await getNewtoken(refreshToken);
    }
    return accessToken;
  }

  set accessToken(String token) {
    assert(token.isNotEmpty, 'Access token cannot be empty');
    _accessToken = token;
    storageBox.put('access_token', token);
    final jwt = JWT.decode(token);
    _accessTokenExpiry = DateTime.fromMillisecondsSinceEpoch(jwt.payload['exp'] * 1000);
    storageBox.put('access_token_expiry', _accessTokenExpiry!.toIso8601String());
  }

  String get refreshToken => _refreshToken?.isNotEmpty ?? true ? '$_refreshToken' : '';
  set refreshToken(String token) {
    assert(token.isNotEmpty, 'Refresh token cannot be empty');
    _refreshToken = token;
    storageBox.put('refresh_token', token);
  }

  UserDetails? _currentUser;
  bool get isRegistered => _accessToken != null;
  bool get isLoggedIn => _currentUser != null && isRegistered;
  UserDetails? get currentUser => _currentUser;

  void initialize() {
    final accessToken = storageBox.get('access_token') as String?;
    if (accessToken?.isNotEmpty ?? false) _accessToken = accessToken;
    final refreshToken = storageBox.get('refresh_token') as String?;
    if (refreshToken?.isNotEmpty ?? false) _refreshToken = refreshToken;

    final user = storageBox.get('current_user');
    if (user != null) _currentUser = user;
  }

  Future<void> updateCurrentUser(UserDetails user) async {
    _currentUser = user;
    await storageBox.put('current_user', user);
    // log(currentUser.toString());
    notifyListeners();
  }

  Future<String> getNewtoken(String refreshToken) async {
    return AuthRepo().refreshToken(refreshToken);
  }

  /// Resets all the components of the current logged in session. (called at Logout)
  Future<void> terminate() async {
    _refreshToken = null;
    _accessToken = null;
    _currentUser = null;
    _accessTokenExpiry = null;

    await storageBox
        .deleteAll(['current_user', 'access_token', 'refresh_token', 'access_token_expiry']);
  }
}

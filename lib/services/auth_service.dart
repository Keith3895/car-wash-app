import 'package:car_wash/models/user_details.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthService extends ChangeNotifier {
  AuthService._();
  static final instance = AuthService._();

  final storageBox = Hive.box('auth_service_box');
  String? _accessToken;
  String? _refreshToken;

  String get accessToken => _accessToken?.isNotEmpty ?? true ? '$_accessToken' : '';
  set accessToken(String token) {
    print(token);
    assert(token.isNotEmpty, 'Access token cannot be empty');
    _accessToken = token;
    storageBox.put('access_token', token);
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

  /// Resets all the components of the current logged in session. (called at Logout)
  Future<void> terminate() async {
    _refreshToken = null;
    _accessToken = null;
    _currentUser = null;

    await storageBox.deleteAll(['current_user', 'access_token', 'refresh_token']);
  }
}

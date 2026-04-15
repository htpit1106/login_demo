import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_demo/core/data/model/entities/account_entity.dart';

class SecureStorageHelper {
  static const _accesSession = 'access_session';
  static const _userInfo = "user_info";
  late final FlutterSecureStorage _storage;

  SecureStorageHelper._(this._storage);

  static final SecureStorageHelper _instance = SecureStorageHelper._(
    const FlutterSecureStorage(),
  );

  static SecureStorageHelper get instance => _instance;

  void refreshStorage() {
    clearSession();
    clearUserInfo();
  }

  // save userInfo
  Future<void> saveUserInfo(Map<String, dynamic> userInfo) async {
    await _storage.write(key: _userInfo, value: jsonEncode(userInfo));
  }

  // get userInfo
  Future<AccountEntity?> getUserInfo() async {
    final value = await _storage.read(key: _userInfo);
    return value != null ? AccountEntity.fromJson(jsonDecode(value)) : null;
  }

  // clear
  Future<void> clearUserInfo() async {
    await _storage.delete(key: _userInfo);
  }

  Future<void> saveAccessToken({
    required String username,
    required String sessionToken,
  }) async {
    final data = {
      "username": username,
      "sessionToken": sessionToken,
      "loginTime": DateTime.now().millisecondsSinceEpoch,
    };
    await _storage.write(key: _accesSession, value: jsonEncode(data));
  }

  Future<Map<String, dynamic>?> getAccessToken() async {
    final value = await _storage.read(key: _accesSession);
    if (value != null) {
      return jsonDecode(value);
    }
    return null;
  }

  Future<void> clearSession() async {
    await _storage.delete(key: _accesSession);
  }
}

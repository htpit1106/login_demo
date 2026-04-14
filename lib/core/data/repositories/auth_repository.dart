import 'package:login_demo/core/data/database/hive_helper.dart';
import 'package:login_demo/core/data/database/secure_storage_helper.dart';
import 'package:login_demo/core/data/model/entities/account_entity.dart';
import 'package:login_demo/core/services/firebase_service.dart';
import 'package:login_demo/core/utils/utils.dart';

abstract class AuthRepository {
  Future<void> createAccount(AccountEntity account);

  Future<AccountEntity?> login(String taxIdOrId);

  Future<List<AccountEntity>?> getListAccount();
}

class AuthRepositoryImpl extends AuthRepository {
  final FirestoreService _firestoreService = FirestoreService.instance;

  @override
  Future<void> createAccount(AccountEntity account) async {
    try {
      await _firestoreService.createAccount(account);
      SecureStorageHelper.instance.saveUserInfo(account.toJson());
    } catch (e) {
      // silent error handle
    }
  }

  @override
  Future<AccountEntity?> login(String taxIdOrId) async {
    try {
      final isConnectInternet = await checkInternetConnect();
      if (isConnectInternet) {
        final accountFirebase = await _firestoreService.getAccountByTaxIdOrId(
          taxIdOrId,
        );
        if (accountFirebase != null) {
          return accountFirebase;
        }
        final accountHive = await HiveHelper.getAccount(taxIdOrId);
        return accountHive;
      } else {
        final accountHive = await HiveHelper.getAccount(taxIdOrId);
        if (accountHive != null) {
          return accountHive;
        }
      }
      return null;
    } catch (e) {
      // silent error handle
    }
    return null;
  }

  @override
  Future<List<AccountEntity>?> getListAccount() async {
    try {
      final listAccount = await _firestoreService.getListAccounts();
      return listAccount;
    } catch (e) {
      // silent error handle
      return null;
    }
  }
}

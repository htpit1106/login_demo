import 'package:login_demo/core/data/model/entities/account_entity.dart';
import 'package:login_demo/core/services/firebase_service.dart';

abstract class AuthRepository {
  Future<void> createAccount(AccountEntity account);

  Future<AccountEntity?> login(String taxIdOrId);
}

class AuthRepositoryImpl extends AuthRepository {
  final FirestoreService _firestoreService = FirestoreService.instance;

  @override
  Future<void> createAccount(AccountEntity account) async {
    try {
      await _firestoreService.createAccount(account);
    } catch (e) {
      // silent error handle
    }
  }

  @override
  Future<AccountEntity?> login(String taxIdOrId) async {
    try {
      final accountFirebase = await _firestoreService.getAccountByTaxIdOrId(
        taxIdOrId,
      );
      return accountFirebase;
    } catch (e) {
      // silent error handle
    }
  }
}

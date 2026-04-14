import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_demo/core/data/model/entities/account_entity.dart';

class FirestoreService {
  FirestoreService._privateConstructor();

  // Singleton instance.
  static final FirestoreService _instance =
      FirestoreService._privateConstructor();

  // Factory constructor returns the singleton instance.
  factory FirestoreService() {
    return _instance;
  }

  static FirestoreService get instance => _instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createAccount(AccountEntity account) async {
    try {
      await _firestore
          .collection('accounts')
          .doc(account.taxIdOrId)
          .set(account.toJson());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<AccountEntity?> getAccountByTaxIdOrId(String taxIdOrId) async {
    try {
      final account = await _firestore
          .collection('accounts')
          .doc(taxIdOrId)
          .get();
      return AccountEntity.fromJson(account.data() as Map<String, dynamic>);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

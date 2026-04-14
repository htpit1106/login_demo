import 'package:hive/hive.dart';
import 'package:login_demo/core/data/model/entities/account_entity.dart';

class HiveHelper {
  HiveHelper._();

  static final HiveHelper _instance = HiveHelper._();

  static HiveHelper get instance => _instance;

  static const _boxName = "accounts";

  static Future<Box> _openBox() async {
    return await Hive.openBox(_boxName);
  }

  static Future<void> saveAccounts(List<AccountEntity>? accounts) async {
    final box = await Hive.openBox('accounts');

    if (accounts == null) return;
    for (var acc in accounts) {
      await box.put(acc.taxIdOrId, acc.toJson());
    }
  }

  static Future<AccountEntity?> getAccount(String taxIdOrId) async {
    final box = await _openBox();
    final data = box.get(taxIdOrId);

    if (data == null) return null;

    return AccountEntity.fromJson(Map<String, dynamic>.from(data));
  }

  static Future<void> clear() async {
    final box = await _openBox();
    await box.clear();
  }
}

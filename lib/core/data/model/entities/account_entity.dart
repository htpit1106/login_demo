class AccountEntity {
  final String? taxIdOrId;
  final String? username;
  final String? passwordHash;
  final String? salt;
  final String? fullName;
  final bool? enable;
  final DateTime? updateAt;

  AccountEntity({
    this.taxIdOrId,
    this.username,
    this.passwordHash,
    this.salt,
    this.fullName,
    this.enable,
    this.updateAt,
  });

  // from json
  factory AccountEntity.fromJson(Map<String, dynamic> json) {
    return AccountEntity(
      taxIdOrId: json['tax_id_or_id'] as String?,
      username: json['username'] as String?,
      passwordHash: json['password_hash'] as String?,
      salt: json['salt'] as String?,
      fullName: json['full_name'] as String?,
      enable: json['enable'] as bool?,
      updateAt: json['update_at'] != null
          ? DateTime.tryParse(json['update_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tax_id_or_id': taxIdOrId,
      'username': username,
      'password_hash': passwordHash,
      'salt': salt,
      'full_name': fullName,
      'enable': enable,
      'update_at': updateAt?.toIso8601String(),
    };
  }
}

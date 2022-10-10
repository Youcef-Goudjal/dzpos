// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class User extends DataClass implements Insertable<User> {
  final int userId;
  final String firebaseUid;
  final String username;
  final String password;
  final String phone;
  final AccountType accountType;
  const User(
      {required this.userId,
      required this.firebaseUid,
      required this.username,
      required this.password,
      required this.phone,
      required this.accountType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<int>(userId);
    map['firebase_uid'] = Variable<String>(firebaseUid);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    map['phone'] = Variable<String>(phone);
    {
      final converter = $UsersTable.$converter0;
      map['account_type'] = Variable<int>(converter.toSql(accountType));
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      userId: Value(userId),
      firebaseUid: Value(firebaseUid),
      username: Value(username),
      password: Value(password),
      phone: Value(phone),
      accountType: Value(accountType),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      userId: serializer.fromJson<int>(json['userId']),
      firebaseUid: serializer.fromJson<String>(json['firebaseUid']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      phone: serializer.fromJson<String>(json['phone']),
      accountType: serializer.fromJson<AccountType>(json['accountType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<int>(userId),
      'firebaseUid': serializer.toJson<String>(firebaseUid),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'phone': serializer.toJson<String>(phone),
      'accountType': serializer.toJson<AccountType>(accountType),
    };
  }

  User copyWith(
          {int? userId,
          String? firebaseUid,
          String? username,
          String? password,
          String? phone,
          AccountType? accountType}) =>
      User(
        userId: userId ?? this.userId,
        firebaseUid: firebaseUid ?? this.firebaseUid,
        username: username ?? this.username,
        password: password ?? this.password,
        phone: phone ?? this.phone,
        accountType: accountType ?? this.accountType,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('userId: $userId, ')
          ..write('firebaseUid: $firebaseUid, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('phone: $phone, ')
          ..write('accountType: $accountType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(userId, firebaseUid, username, password, phone, accountType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.userId == this.userId &&
          other.firebaseUid == this.firebaseUid &&
          other.username == this.username &&
          other.password == this.password &&
          other.phone == this.phone &&
          other.accountType == this.accountType);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> userId;
  final Value<String> firebaseUid;
  final Value<String> username;
  final Value<String> password;
  final Value<String> phone;
  final Value<AccountType> accountType;
  const UsersCompanion({
    this.userId = const Value.absent(),
    this.firebaseUid = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.phone = const Value.absent(),
    this.accountType = const Value.absent(),
  });
  UsersCompanion.insert({
    this.userId = const Value.absent(),
    required String firebaseUid,
    required String username,
    required String password,
    required String phone,
    required AccountType accountType,
  })  : firebaseUid = Value(firebaseUid),
        username = Value(username),
        password = Value(password),
        phone = Value(phone),
        accountType = Value(accountType);
  static Insertable<User> custom({
    Expression<int>? userId,
    Expression<String>? firebaseUid,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? phone,
    Expression<int>? accountType,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (firebaseUid != null) 'firebase_uid': firebaseUid,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (phone != null) 'phone': phone,
      if (accountType != null) 'account_type': accountType,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? userId,
      Value<String>? firebaseUid,
      Value<String>? username,
      Value<String>? password,
      Value<String>? phone,
      Value<AccountType>? accountType}) {
    return UsersCompanion(
      userId: userId ?? this.userId,
      firebaseUid: firebaseUid ?? this.firebaseUid,
      username: username ?? this.username,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      accountType: accountType ?? this.accountType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (firebaseUid.present) {
      map['firebase_uid'] = Variable<String>(firebaseUid.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (accountType.present) {
      final converter = $UsersTable.$converter0;
      map['account_type'] = Variable<int>(converter.toSql(accountType.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('userId: $userId, ')
          ..write('firebaseUid: $firebaseUid, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('phone: $phone, ')
          ..write('accountType: $accountType')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _firebaseUidMeta =
      const VerificationMeta('firebaseUid');
  @override
  late final GeneratedColumn<String> firebaseUid = GeneratedColumn<String>(
      'firebase_uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  final VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  final VerificationMeta _accountTypeMeta =
      const VerificationMeta('accountType');
  @override
  late final GeneratedColumnWithTypeConverter<AccountType, int> accountType =
      GeneratedColumn<int>('account_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<AccountType>($UsersTable.$converter0);
  @override
  List<GeneratedColumn> get $columns =>
      [userId, firebaseUid, username, password, phone, accountType];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('firebase_uid')) {
      context.handle(
          _firebaseUidMeta,
          firebaseUid.isAcceptableOrUnknown(
              data['firebase_uid']!, _firebaseUidMeta));
    } else if (isInserting) {
      context.missing(_firebaseUidMeta);
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    context.handle(_accountTypeMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      userId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      firebaseUid: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}firebase_uid'])!,
      username: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      password: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      phone: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}phone'])!,
      accountType: $UsersTable.$converter0.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.int, data['${effectivePrefix}account_type'])!),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountType, int> $converter0 =
      const EnumIndexConverter<AccountType>(AccountType.values);
}

class ProductUnit extends DataClass implements Insertable<ProductUnit> {
  final int unitId;
  final String unitName;
  const ProductUnit({required this.unitId, required this.unitName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['unit_id'] = Variable<int>(unitId);
    map['unit_name'] = Variable<String>(unitName);
    return map;
  }

  ProductUnitsCompanion toCompanion(bool nullToAbsent) {
    return ProductUnitsCompanion(
      unitId: Value(unitId),
      unitName: Value(unitName),
    );
  }

  factory ProductUnit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductUnit(
      unitId: serializer.fromJson<int>(json['unitId']),
      unitName: serializer.fromJson<String>(json['unitName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'unitId': serializer.toJson<int>(unitId),
      'unitName': serializer.toJson<String>(unitName),
    };
  }

  ProductUnit copyWith({int? unitId, String? unitName}) => ProductUnit(
        unitId: unitId ?? this.unitId,
        unitName: unitName ?? this.unitName,
      );
  @override
  String toString() {
    return (StringBuffer('ProductUnit(')
          ..write('unitId: $unitId, ')
          ..write('unitName: $unitName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(unitId, unitName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductUnit &&
          other.unitId == this.unitId &&
          other.unitName == this.unitName);
}

class ProductUnitsCompanion extends UpdateCompanion<ProductUnit> {
  final Value<int> unitId;
  final Value<String> unitName;
  const ProductUnitsCompanion({
    this.unitId = const Value.absent(),
    this.unitName = const Value.absent(),
  });
  ProductUnitsCompanion.insert({
    this.unitId = const Value.absent(),
    required String unitName,
  }) : unitName = Value(unitName);
  static Insertable<ProductUnit> custom({
    Expression<int>? unitId,
    Expression<String>? unitName,
  }) {
    return RawValuesInsertable({
      if (unitId != null) 'unit_id': unitId,
      if (unitName != null) 'unit_name': unitName,
    });
  }

  ProductUnitsCompanion copyWith(
      {Value<int>? unitId, Value<String>? unitName}) {
    return ProductUnitsCompanion(
      unitId: unitId ?? this.unitId,
      unitName: unitName ?? this.unitName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (unitId.present) {
      map['unit_id'] = Variable<int>(unitId.value);
    }
    if (unitName.present) {
      map['unit_name'] = Variable<String>(unitName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductUnitsCompanion(')
          ..write('unitId: $unitId, ')
          ..write('unitName: $unitName')
          ..write(')'))
        .toString();
  }
}

class $ProductUnitsTable extends ProductUnits
    with TableInfo<$ProductUnitsTable, ProductUnit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductUnitsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<int> unitId = GeneratedColumn<int>(
      'unit_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _unitNameMeta = const VerificationMeta('unitName');
  @override
  late final GeneratedColumn<String> unitName = GeneratedColumn<String>(
      'unit_name', aliasedName, false,
      check: () => unitName.isNotNull(),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [unitId, unitName];
  @override
  String get aliasedName => _alias ?? 'product_units';
  @override
  String get actualTableName => 'product_units';
  @override
  VerificationContext validateIntegrity(Insertable<ProductUnit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('unit_id')) {
      context.handle(_unitIdMeta,
          unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta));
    }
    if (data.containsKey('unit_name')) {
      context.handle(_unitNameMeta,
          unitName.isAcceptableOrUnknown(data['unit_name']!, _unitNameMeta));
    } else if (isInserting) {
      context.missing(_unitNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {unitId};
  @override
  ProductUnit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductUnit(
      unitId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}unit_id'])!,
      unitName: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}unit_name'])!,
    );
  }

  @override
  $ProductUnitsTable createAlias(String alias) {
    return $ProductUnitsTable(attachedDatabase, alias);
  }
}

class ProductCategory extends DataClass implements Insertable<ProductCategory> {
  final int categoryId;
  final String categoryName;
  const ProductCategory({required this.categoryId, required this.categoryName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['category_id'] = Variable<int>(categoryId);
    map['category_name'] = Variable<String>(categoryName);
    return map;
  }

  ProductCategoriesCompanion toCompanion(bool nullToAbsent) {
    return ProductCategoriesCompanion(
      categoryId: Value(categoryId),
      categoryName: Value(categoryName),
    );
  }

  factory ProductCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductCategory(
      categoryId: serializer.fromJson<int>(json['categoryId']),
      categoryName: serializer.fromJson<String>(json['categoryName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'categoryId': serializer.toJson<int>(categoryId),
      'categoryName': serializer.toJson<String>(categoryName),
    };
  }

  ProductCategory copyWith({int? categoryId, String? categoryName}) =>
      ProductCategory(
        categoryId: categoryId ?? this.categoryId,
        categoryName: categoryName ?? this.categoryName,
      );
  @override
  String toString() {
    return (StringBuffer('ProductCategory(')
          ..write('categoryId: $categoryId, ')
          ..write('categoryName: $categoryName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(categoryId, categoryName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductCategory &&
          other.categoryId == this.categoryId &&
          other.categoryName == this.categoryName);
}

class ProductCategoriesCompanion extends UpdateCompanion<ProductCategory> {
  final Value<int> categoryId;
  final Value<String> categoryName;
  const ProductCategoriesCompanion({
    this.categoryId = const Value.absent(),
    this.categoryName = const Value.absent(),
  });
  ProductCategoriesCompanion.insert({
    this.categoryId = const Value.absent(),
    required String categoryName,
  }) : categoryName = Value(categoryName);
  static Insertable<ProductCategory> custom({
    Expression<int>? categoryId,
    Expression<String>? categoryName,
  }) {
    return RawValuesInsertable({
      if (categoryId != null) 'category_id': categoryId,
      if (categoryName != null) 'category_name': categoryName,
    });
  }

  ProductCategoriesCompanion copyWith(
      {Value<int>? categoryId, Value<String>? categoryName}) {
    return ProductCategoriesCompanion(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (categoryName.present) {
      map['category_name'] = Variable<String>(categoryName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductCategoriesCompanion(')
          ..write('categoryId: $categoryId, ')
          ..write('categoryName: $categoryName')
          ..write(')'))
        .toString();
  }
}

class $ProductCategoriesTable extends ProductCategories
    with TableInfo<$ProductCategoriesTable, ProductCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductCategoriesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _categoryNameMeta =
      const VerificationMeta('categoryName');
  @override
  late final GeneratedColumn<String> categoryName = GeneratedColumn<String>(
      'category_name', aliasedName, false,
      check: () => categoryName.isNotNull(),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [categoryId, categoryName];
  @override
  String get aliasedName => _alias ?? 'product_categories';
  @override
  String get actualTableName => 'product_categories';
  @override
  VerificationContext validateIntegrity(Insertable<ProductCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('category_name')) {
      context.handle(
          _categoryNameMeta,
          categoryName.isAcceptableOrUnknown(
              data['category_name']!, _categoryNameMeta));
    } else if (isInserting) {
      context.missing(_categoryNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {categoryId};
  @override
  ProductCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductCategory(
      categoryId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      categoryName: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}category_name'])!,
    );
  }

  @override
  $ProductCategoriesTable createAlias(String alias) {
    return $ProductCategoriesTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int productId;
  final String productCode;
  final String productName;
  final int unitId;
  final int categoryId;
  final double unitInStock;
  final double unitPrice;
  final double discountPercentage;
  final double reorderLevel;
  final int userId;
  const Product(
      {required this.productId,
      required this.productCode,
      required this.productName,
      required this.unitId,
      required this.categoryId,
      required this.unitInStock,
      required this.unitPrice,
      required this.discountPercentage,
      required this.reorderLevel,
      required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<int>(productId);
    map['product_code'] = Variable<String>(productCode);
    map['product_name'] = Variable<String>(productName);
    map['unit_id'] = Variable<int>(unitId);
    map['category_id'] = Variable<int>(categoryId);
    map['unit_in_stock'] = Variable<double>(unitInStock);
    map['unit_price'] = Variable<double>(unitPrice);
    map['discount_percentage'] = Variable<double>(discountPercentage);
    map['reorder_level'] = Variable<double>(reorderLevel);
    map['user_id'] = Variable<int>(userId);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      productId: Value(productId),
      productCode: Value(productCode),
      productName: Value(productName),
      unitId: Value(unitId),
      categoryId: Value(categoryId),
      unitInStock: Value(unitInStock),
      unitPrice: Value(unitPrice),
      discountPercentage: Value(discountPercentage),
      reorderLevel: Value(reorderLevel),
      userId: Value(userId),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      productId: serializer.fromJson<int>(json['productId']),
      productCode: serializer.fromJson<String>(json['productCode']),
      productName: serializer.fromJson<String>(json['productName']),
      unitId: serializer.fromJson<int>(json['unitId']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      unitInStock: serializer.fromJson<double>(json['unitInStock']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      discountPercentage:
          serializer.fromJson<double>(json['discountPercentage']),
      reorderLevel: serializer.fromJson<double>(json['reorderLevel']),
      userId: serializer.fromJson<int>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<int>(productId),
      'productCode': serializer.toJson<String>(productCode),
      'productName': serializer.toJson<String>(productName),
      'unitId': serializer.toJson<int>(unitId),
      'categoryId': serializer.toJson<int>(categoryId),
      'unitInStock': serializer.toJson<double>(unitInStock),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'discountPercentage': serializer.toJson<double>(discountPercentage),
      'reorderLevel': serializer.toJson<double>(reorderLevel),
      'userId': serializer.toJson<int>(userId),
    };
  }

  Product copyWith(
          {int? productId,
          String? productCode,
          String? productName,
          int? unitId,
          int? categoryId,
          double? unitInStock,
          double? unitPrice,
          double? discountPercentage,
          double? reorderLevel,
          int? userId}) =>
      Product(
        productId: productId ?? this.productId,
        productCode: productCode ?? this.productCode,
        productName: productName ?? this.productName,
        unitId: unitId ?? this.unitId,
        categoryId: categoryId ?? this.categoryId,
        unitInStock: unitInStock ?? this.unitInStock,
        unitPrice: unitPrice ?? this.unitPrice,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        reorderLevel: reorderLevel ?? this.reorderLevel,
        userId: userId ?? this.userId,
      );
  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('productId: $productId, ')
          ..write('productCode: $productCode, ')
          ..write('productName: $productName, ')
          ..write('unitId: $unitId, ')
          ..write('categoryId: $categoryId, ')
          ..write('unitInStock: $unitInStock, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('discountPercentage: $discountPercentage, ')
          ..write('reorderLevel: $reorderLevel, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      productId,
      productCode,
      productName,
      unitId,
      categoryId,
      unitInStock,
      unitPrice,
      discountPercentage,
      reorderLevel,
      userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.productId == this.productId &&
          other.productCode == this.productCode &&
          other.productName == this.productName &&
          other.unitId == this.unitId &&
          other.categoryId == this.categoryId &&
          other.unitInStock == this.unitInStock &&
          other.unitPrice == this.unitPrice &&
          other.discountPercentage == this.discountPercentage &&
          other.reorderLevel == this.reorderLevel &&
          other.userId == this.userId);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> productId;
  final Value<String> productCode;
  final Value<String> productName;
  final Value<int> unitId;
  final Value<int> categoryId;
  final Value<double> unitInStock;
  final Value<double> unitPrice;
  final Value<double> discountPercentage;
  final Value<double> reorderLevel;
  final Value<int> userId;
  const ProductsCompanion({
    this.productId = const Value.absent(),
    this.productCode = const Value.absent(),
    this.productName = const Value.absent(),
    this.unitId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.unitInStock = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.discountPercentage = const Value.absent(),
    this.reorderLevel = const Value.absent(),
    this.userId = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.productId = const Value.absent(),
    required String productCode,
    required String productName,
    required int unitId,
    required int categoryId,
    required double unitInStock,
    required double unitPrice,
    required double discountPercentage,
    required double reorderLevel,
    required int userId,
  })  : productCode = Value(productCode),
        productName = Value(productName),
        unitId = Value(unitId),
        categoryId = Value(categoryId),
        unitInStock = Value(unitInStock),
        unitPrice = Value(unitPrice),
        discountPercentage = Value(discountPercentage),
        reorderLevel = Value(reorderLevel),
        userId = Value(userId);
  static Insertable<Product> custom({
    Expression<int>? productId,
    Expression<String>? productCode,
    Expression<String>? productName,
    Expression<int>? unitId,
    Expression<int>? categoryId,
    Expression<double>? unitInStock,
    Expression<double>? unitPrice,
    Expression<double>? discountPercentage,
    Expression<double>? reorderLevel,
    Expression<int>? userId,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (productCode != null) 'product_code': productCode,
      if (productName != null) 'product_name': productName,
      if (unitId != null) 'unit_id': unitId,
      if (categoryId != null) 'category_id': categoryId,
      if (unitInStock != null) 'unit_in_stock': unitInStock,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (discountPercentage != null) 'discount_percentage': discountPercentage,
      if (reorderLevel != null) 'reorder_level': reorderLevel,
      if (userId != null) 'user_id': userId,
    });
  }

  ProductsCompanion copyWith(
      {Value<int>? productId,
      Value<String>? productCode,
      Value<String>? productName,
      Value<int>? unitId,
      Value<int>? categoryId,
      Value<double>? unitInStock,
      Value<double>? unitPrice,
      Value<double>? discountPercentage,
      Value<double>? reorderLevel,
      Value<int>? userId}) {
    return ProductsCompanion(
      productId: productId ?? this.productId,
      productCode: productCode ?? this.productCode,
      productName: productName ?? this.productName,
      unitId: unitId ?? this.unitId,
      categoryId: categoryId ?? this.categoryId,
      unitInStock: unitInStock ?? this.unitInStock,
      unitPrice: unitPrice ?? this.unitPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      reorderLevel: reorderLevel ?? this.reorderLevel,
      userId: userId ?? this.userId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (productCode.present) {
      map['product_code'] = Variable<String>(productCode.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<int>(unitId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (unitInStock.present) {
      map['unit_in_stock'] = Variable<double>(unitInStock.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (discountPercentage.present) {
      map['discount_percentage'] = Variable<double>(discountPercentage.value);
    }
    if (reorderLevel.present) {
      map['reorder_level'] = Variable<double>(reorderLevel.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('productId: $productId, ')
          ..write('productCode: $productCode, ')
          ..write('productName: $productName, ')
          ..write('unitId: $unitId, ')
          ..write('categoryId: $categoryId, ')
          ..write('unitInStock: $unitInStock, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('discountPercentage: $discountPercentage, ')
          ..write('reorderLevel: $reorderLevel, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _productCodeMeta =
      const VerificationMeta('productCode');
  @override
  late final GeneratedColumn<String> productCode = GeneratedColumn<String>(
      'product_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
      'product_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<int> unitId = GeneratedColumn<int>(
      'unit_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "product_units" ("unit_id")');
  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "product_categories" ("category_id")');
  final VerificationMeta _unitInStockMeta =
      const VerificationMeta('unitInStock');
  @override
  late final GeneratedColumn<double> unitInStock = GeneratedColumn<double>(
      'unit_in_stock', aliasedName, false,
      check: () => unitInStock.isNotNull(),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  final VerificationMeta _unitPriceMeta = const VerificationMeta('unitPrice');
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
      'unit_price', aliasedName, false,
      check: () => unitPrice.isNotNull(),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  final VerificationMeta _discountPercentageMeta =
      const VerificationMeta('discountPercentage');
  @override
  late final GeneratedColumn<double> discountPercentage =
      GeneratedColumn<double>('discount_percentage', aliasedName, false,
          check: () => discountPercentage.isNotNull(),
          type: DriftSqlType.double,
          requiredDuringInsert: true);
  final VerificationMeta _reorderLevelMeta =
      const VerificationMeta('reorderLevel');
  @override
  late final GeneratedColumn<double> reorderLevel = GeneratedColumn<double>(
      'reorder_level', aliasedName, false,
      check: () => reorderLevel.isNotNull(),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "users" ("user_id")');
  @override
  List<GeneratedColumn> get $columns => [
        productId,
        productCode,
        productName,
        unitId,
        categoryId,
        unitInStock,
        unitPrice,
        discountPercentage,
        reorderLevel,
        userId
      ];
  @override
  String get aliasedName => _alias ?? 'products';
  @override
  String get actualTableName => 'products';
  @override
  VerificationContext validateIntegrity(Insertable<Product> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    }
    if (data.containsKey('product_code')) {
      context.handle(
          _productCodeMeta,
          productCode.isAcceptableOrUnknown(
              data['product_code']!, _productCodeMeta));
    } else if (isInserting) {
      context.missing(_productCodeMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name']!, _productNameMeta));
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(_unitIdMeta,
          unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta));
    } else if (isInserting) {
      context.missing(_unitIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('unit_in_stock')) {
      context.handle(
          _unitInStockMeta,
          unitInStock.isAcceptableOrUnknown(
              data['unit_in_stock']!, _unitInStockMeta));
    } else if (isInserting) {
      context.missing(_unitInStockMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(_unitPriceMeta,
          unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta));
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('discount_percentage')) {
      context.handle(
          _discountPercentageMeta,
          discountPercentage.isAcceptableOrUnknown(
              data['discount_percentage']!, _discountPercentageMeta));
    } else if (isInserting) {
      context.missing(_discountPercentageMeta);
    }
    if (data.containsKey('reorder_level')) {
      context.handle(
          _reorderLevelMeta,
          reorderLevel.isAcceptableOrUnknown(
              data['reorder_level']!, _reorderLevelMeta));
    } else if (isInserting) {
      context.missing(_reorderLevelMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productId};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      productId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      productCode: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}product_code'])!,
      productName: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}product_name'])!,
      unitId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}unit_id'])!,
      categoryId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      unitInStock: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}unit_in_stock'])!,
      unitPrice: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}unit_price'])!,
      discountPercentage: attachedDatabase.options.types.read(
          DriftSqlType.double, data['${effectivePrefix}discount_percentage'])!,
      reorderLevel: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}reorder_level'])!,
      userId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Sale extends DataClass implements Insertable<Sale> {
  final int salesId;
  final int invoiceId;
  final int productId;
  final double quantity;
  final double unitPrice;
  final double subTotal;
  const Sale(
      {required this.salesId,
      required this.invoiceId,
      required this.productId,
      required this.quantity,
      required this.unitPrice,
      required this.subTotal});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['sales_id'] = Variable<int>(salesId);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['product_id'] = Variable<int>(productId);
    map['quantity'] = Variable<double>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    return map;
  }

  SalesCompanion toCompanion(bool nullToAbsent) {
    return SalesCompanion(
      salesId: Value(salesId),
      invoiceId: Value(invoiceId),
      productId: Value(productId),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
    );
  }

  factory Sale.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sale(
      salesId: serializer.fromJson<int>(json['salesId']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      productId: serializer.fromJson<int>(json['productId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      subTotal: serializer.fromJson<double>(json['subTotal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'salesId': serializer.toJson<int>(salesId),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'productId': serializer.toJson<int>(productId),
      'quantity': serializer.toJson<double>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'subTotal': serializer.toJson<double>(subTotal),
    };
  }

  Sale copyWith(
          {int? salesId,
          int? invoiceId,
          int? productId,
          double? quantity,
          double? unitPrice,
          double? subTotal}) =>
      Sale(
        salesId: salesId ?? this.salesId,
        invoiceId: invoiceId ?? this.invoiceId,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        unitPrice: unitPrice ?? this.unitPrice,
        subTotal: subTotal ?? this.subTotal,
      );
  @override
  String toString() {
    return (StringBuffer('Sale(')
          ..write('salesId: $salesId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('subTotal: $subTotal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(salesId, invoiceId, productId, quantity, unitPrice, subTotal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sale &&
          other.salesId == this.salesId &&
          other.invoiceId == this.invoiceId &&
          other.productId == this.productId &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.subTotal == this.subTotal);
}

class SalesCompanion extends UpdateCompanion<Sale> {
  final Value<int> salesId;
  final Value<int> invoiceId;
  final Value<int> productId;
  final Value<double> quantity;
  final Value<double> unitPrice;
  const SalesCompanion({
    this.salesId = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.productId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
  });
  SalesCompanion.insert({
    this.salesId = const Value.absent(),
    required int invoiceId,
    required int productId,
    required double quantity,
    required double unitPrice,
  })  : invoiceId = Value(invoiceId),
        productId = Value(productId),
        quantity = Value(quantity),
        unitPrice = Value(unitPrice);
  static Insertable<Sale> custom({
    Expression<int>? salesId,
    Expression<int>? invoiceId,
    Expression<int>? productId,
    Expression<double>? quantity,
    Expression<double>? unitPrice,
  }) {
    return RawValuesInsertable({
      if (salesId != null) 'sales_id': salesId,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (productId != null) 'product_id': productId,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
    });
  }

  SalesCompanion copyWith(
      {Value<int>? salesId,
      Value<int>? invoiceId,
      Value<int>? productId,
      Value<double>? quantity,
      Value<double>? unitPrice}) {
    return SalesCompanion(
      salesId: salesId ?? this.salesId,
      invoiceId: invoiceId ?? this.invoiceId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (salesId.present) {
      map['sales_id'] = Variable<int>(salesId.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesCompanion(')
          ..write('salesId: $salesId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice')
          ..write(')'))
        .toString();
  }
}

class $SalesTable extends Sales with TableInfo<$SalesTable, Sale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _salesIdMeta = const VerificationMeta('salesId');
  @override
  late final GeneratedColumn<int> salesId = GeneratedColumn<int>(
      'sales_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _invoiceIdMeta = const VerificationMeta('invoiceId');
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
      'invoice_id', aliasedName, false,
      check: () => invoiceId.isNotNull(),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      check: () => productId.isNotNull(),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, false,
      check: () => quantity.isNotNull(),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  final VerificationMeta _unitPriceMeta = const VerificationMeta('unitPrice');
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
      'unit_price', aliasedName, false,
      check: () => unitPrice.isNotNull(),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  final VerificationMeta _subTotalMeta = const VerificationMeta('subTotal');
  @override
  late final GeneratedColumn<double> subTotal = GeneratedColumn<double>(
      'sub_total', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      generatedAs: GeneratedAs(quantity * unitPrice, false));
  @override
  List<GeneratedColumn> get $columns =>
      [salesId, invoiceId, productId, quantity, unitPrice, subTotal];
  @override
  String get aliasedName => _alias ?? 'sales';
  @override
  String get actualTableName => 'sales';
  @override
  VerificationContext validateIntegrity(Insertable<Sale> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('sales_id')) {
      context.handle(_salesIdMeta,
          salesId.isAcceptableOrUnknown(data['sales_id']!, _salesIdMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(_invoiceIdMeta,
          invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta));
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(_unitPriceMeta,
          unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta));
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('sub_total')) {
      context.handle(_subTotalMeta,
          subTotal.isAcceptableOrUnknown(data['sub_total']!, _subTotalMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {salesId};
  @override
  Sale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sale(
      salesId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}sales_id'])!,
      invoiceId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}invoice_id'])!,
      productId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      quantity: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}quantity'])!,
      unitPrice: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}unit_price'])!,
      subTotal: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}sub_total'])!,
    );
  }

  @override
  $SalesTable createAlias(String alias) {
    return $SalesTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int customerId;
  final String customerCode;
  final String customerName;
  final String contact;
  final String address;
  const Customer(
      {required this.customerId,
      required this.customerCode,
      required this.customerName,
      required this.contact,
      required this.address});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['customer_id'] = Variable<int>(customerId);
    map['customer_code'] = Variable<String>(customerCode);
    map['customer_name'] = Variable<String>(customerName);
    map['contact'] = Variable<String>(contact);
    map['address'] = Variable<String>(address);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      customerId: Value(customerId),
      customerCode: Value(customerCode),
      customerName: Value(customerName),
      contact: Value(contact),
      address: Value(address),
    );
  }

  factory Customer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      customerId: serializer.fromJson<int>(json['customerId']),
      customerCode: serializer.fromJson<String>(json['customerCode']),
      customerName: serializer.fromJson<String>(json['customerName']),
      contact: serializer.fromJson<String>(json['contact']),
      address: serializer.fromJson<String>(json['address']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'customerId': serializer.toJson<int>(customerId),
      'customerCode': serializer.toJson<String>(customerCode),
      'customerName': serializer.toJson<String>(customerName),
      'contact': serializer.toJson<String>(contact),
      'address': serializer.toJson<String>(address),
    };
  }

  Customer copyWith(
          {int? customerId,
          String? customerCode,
          String? customerName,
          String? contact,
          String? address}) =>
      Customer(
        customerId: customerId ?? this.customerId,
        customerCode: customerCode ?? this.customerCode,
        customerName: customerName ?? this.customerName,
        contact: contact ?? this.contact,
        address: address ?? this.address,
      );
  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('customerId: $customerId, ')
          ..write('customerCode: $customerCode, ')
          ..write('customerName: $customerName, ')
          ..write('contact: $contact, ')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(customerId, customerCode, customerName, contact, address);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.customerId == this.customerId &&
          other.customerCode == this.customerCode &&
          other.customerName == this.customerName &&
          other.contact == this.contact &&
          other.address == this.address);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> customerId;
  final Value<String> customerCode;
  final Value<String> customerName;
  final Value<String> contact;
  final Value<String> address;
  const CustomersCompanion({
    this.customerId = const Value.absent(),
    this.customerCode = const Value.absent(),
    this.customerName = const Value.absent(),
    this.contact = const Value.absent(),
    this.address = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.customerId = const Value.absent(),
    required String customerCode,
    required String customerName,
    required String contact,
    required String address,
  })  : customerCode = Value(customerCode),
        customerName = Value(customerName),
        contact = Value(contact),
        address = Value(address);
  static Insertable<Customer> custom({
    Expression<int>? customerId,
    Expression<String>? customerCode,
    Expression<String>? customerName,
    Expression<String>? contact,
    Expression<String>? address,
  }) {
    return RawValuesInsertable({
      if (customerId != null) 'customer_id': customerId,
      if (customerCode != null) 'customer_code': customerCode,
      if (customerName != null) 'customer_name': customerName,
      if (contact != null) 'contact': contact,
      if (address != null) 'address': address,
    });
  }

  CustomersCompanion copyWith(
      {Value<int>? customerId,
      Value<String>? customerCode,
      Value<String>? customerName,
      Value<String>? contact,
      Value<String>? address}) {
    return CustomersCompanion(
      customerId: customerId ?? this.customerId,
      customerCode: customerCode ?? this.customerCode,
      customerName: customerName ?? this.customerName,
      contact: contact ?? this.contact,
      address: address ?? this.address,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (customerCode.present) {
      map['customer_code'] = Variable<String>(customerCode.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (contact.present) {
      map['contact'] = Variable<String>(contact.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('customerId: $customerId, ')
          ..write('customerCode: $customerCode, ')
          ..write('customerName: $customerName, ')
          ..write('contact: $contact, ')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _customerIdMeta = const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
      'customer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _customerCodeMeta =
      const VerificationMeta('customerCode');
  @override
  late final GeneratedColumn<String> customerCode = GeneratedColumn<String>(
      'customer_code', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 25),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  final VerificationMeta _customerNameMeta =
      const VerificationMeta('customerName');
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
      'customer_name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  final VerificationMeta _contactMeta = const VerificationMeta('contact');
  @override
  late final GeneratedColumn<String> contact = GeneratedColumn<String>(
      'contact', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  final VerificationMeta _addressMeta = const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [customerId, customerCode, customerName, contact, address];
  @override
  String get aliasedName => _alias ?? 'customers';
  @override
  String get actualTableName => 'customers';
  @override
  VerificationContext validateIntegrity(Insertable<Customer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    }
    if (data.containsKey('customer_code')) {
      context.handle(
          _customerCodeMeta,
          customerCode.isAcceptableOrUnknown(
              data['customer_code']!, _customerCodeMeta));
    } else if (isInserting) {
      context.missing(_customerCodeMeta);
    }
    if (data.containsKey('customer_name')) {
      context.handle(
          _customerNameMeta,
          customerName.isAcceptableOrUnknown(
              data['customer_name']!, _customerNameMeta));
    } else if (isInserting) {
      context.missing(_customerNameMeta);
    }
    if (data.containsKey('contact')) {
      context.handle(_contactMeta,
          contact.isAcceptableOrUnknown(data['contact']!, _contactMeta));
    } else if (isInserting) {
      context.missing(_contactMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {customerId};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      customerId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}customer_id'])!,
      customerCode: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}customer_code'])!,
      customerName: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}customer_name'])!,
      contact: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}contact'])!,
      address: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Invoice extends DataClass implements Insertable<Invoice> {
  final int invoiceId;
  final int customerId;
  final PaymentType paymentType;
  final double totalAmount;
  final double amountTendered;
  final DateTime dateRecorded;
  final int userId;
  const Invoice(
      {required this.invoiceId,
      required this.customerId,
      required this.paymentType,
      required this.totalAmount,
      required this.amountTendered,
      required this.dateRecorded,
      required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['invoice_id'] = Variable<int>(invoiceId);
    map['customer_id'] = Variable<int>(customerId);
    {
      final converter = $InvoicesTable.$converter0;
      map['payment_type'] = Variable<int>(converter.toSql(paymentType));
    }
    map['total_amount'] = Variable<double>(totalAmount);
    map['amount_tendered'] = Variable<double>(amountTendered);
    map['date_recorded'] = Variable<DateTime>(dateRecorded);
    map['user_id'] = Variable<int>(userId);
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      invoiceId: Value(invoiceId),
      customerId: Value(customerId),
      paymentType: Value(paymentType),
      totalAmount: Value(totalAmount),
      amountTendered: Value(amountTendered),
      dateRecorded: Value(dateRecorded),
      userId: Value(userId),
    );
  }

  factory Invoice.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Invoice(
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      customerId: serializer.fromJson<int>(json['customerId']),
      paymentType: serializer.fromJson<PaymentType>(json['paymentType']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      amountTendered: serializer.fromJson<double>(json['amountTendered']),
      dateRecorded: serializer.fromJson<DateTime>(json['dateRecorded']),
      userId: serializer.fromJson<int>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'invoiceId': serializer.toJson<int>(invoiceId),
      'customerId': serializer.toJson<int>(customerId),
      'paymentType': serializer.toJson<PaymentType>(paymentType),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'amountTendered': serializer.toJson<double>(amountTendered),
      'dateRecorded': serializer.toJson<DateTime>(dateRecorded),
      'userId': serializer.toJson<int>(userId),
    };
  }

  Invoice copyWith(
          {int? invoiceId,
          int? customerId,
          PaymentType? paymentType,
          double? totalAmount,
          double? amountTendered,
          DateTime? dateRecorded,
          int? userId}) =>
      Invoice(
        invoiceId: invoiceId ?? this.invoiceId,
        customerId: customerId ?? this.customerId,
        paymentType: paymentType ?? this.paymentType,
        totalAmount: totalAmount ?? this.totalAmount,
        amountTendered: amountTendered ?? this.amountTendered,
        dateRecorded: dateRecorded ?? this.dateRecorded,
        userId: userId ?? this.userId,
      );
  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('invoiceId: $invoiceId, ')
          ..write('customerId: $customerId, ')
          ..write('paymentType: $paymentType, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('amountTendered: $amountTendered, ')
          ..write('dateRecorded: $dateRecorded, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(invoiceId, customerId, paymentType,
      totalAmount, amountTendered, dateRecorded, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.invoiceId == this.invoiceId &&
          other.customerId == this.customerId &&
          other.paymentType == this.paymentType &&
          other.totalAmount == this.totalAmount &&
          other.amountTendered == this.amountTendered &&
          other.dateRecorded == this.dateRecorded &&
          other.userId == this.userId);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<int> invoiceId;
  final Value<int> customerId;
  final Value<PaymentType> paymentType;
  final Value<double> totalAmount;
  final Value<double> amountTendered;
  final Value<DateTime> dateRecorded;
  final Value<int> userId;
  const InvoicesCompanion({
    this.invoiceId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.paymentType = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.amountTendered = const Value.absent(),
    this.dateRecorded = const Value.absent(),
    this.userId = const Value.absent(),
  });
  InvoicesCompanion.insert({
    this.invoiceId = const Value.absent(),
    required int customerId,
    required PaymentType paymentType,
    required double totalAmount,
    required double amountTendered,
    required DateTime dateRecorded,
    required int userId,
  })  : customerId = Value(customerId),
        paymentType = Value(paymentType),
        totalAmount = Value(totalAmount),
        amountTendered = Value(amountTendered),
        dateRecorded = Value(dateRecorded),
        userId = Value(userId);
  static Insertable<Invoice> custom({
    Expression<int>? invoiceId,
    Expression<int>? customerId,
    Expression<int>? paymentType,
    Expression<double>? totalAmount,
    Expression<double>? amountTendered,
    Expression<DateTime>? dateRecorded,
    Expression<int>? userId,
  }) {
    return RawValuesInsertable({
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (customerId != null) 'customer_id': customerId,
      if (paymentType != null) 'payment_type': paymentType,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (amountTendered != null) 'amount_tendered': amountTendered,
      if (dateRecorded != null) 'date_recorded': dateRecorded,
      if (userId != null) 'user_id': userId,
    });
  }

  InvoicesCompanion copyWith(
      {Value<int>? invoiceId,
      Value<int>? customerId,
      Value<PaymentType>? paymentType,
      Value<double>? totalAmount,
      Value<double>? amountTendered,
      Value<DateTime>? dateRecorded,
      Value<int>? userId}) {
    return InvoicesCompanion(
      invoiceId: invoiceId ?? this.invoiceId,
      customerId: customerId ?? this.customerId,
      paymentType: paymentType ?? this.paymentType,
      totalAmount: totalAmount ?? this.totalAmount,
      amountTendered: amountTendered ?? this.amountTendered,
      dateRecorded: dateRecorded ?? this.dateRecorded,
      userId: userId ?? this.userId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (paymentType.present) {
      final converter = $InvoicesTable.$converter0;
      map['payment_type'] = Variable<int>(converter.toSql(paymentType.value));
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (amountTendered.present) {
      map['amount_tendered'] = Variable<double>(amountTendered.value);
    }
    if (dateRecorded.present) {
      map['date_recorded'] = Variable<DateTime>(dateRecorded.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('invoiceId: $invoiceId, ')
          ..write('customerId: $customerId, ')
          ..write('paymentType: $paymentType, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('amountTendered: $amountTendered, ')
          ..write('dateRecorded: $dateRecorded, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices with TableInfo<$InvoicesTable, Invoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _invoiceIdMeta = const VerificationMeta('invoiceId');
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
      'invoice_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _customerIdMeta = const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
      'customer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "customers" ("customer_id")');
  final VerificationMeta _paymentTypeMeta =
      const VerificationMeta('paymentType');
  @override
  late final GeneratedColumnWithTypeConverter<PaymentType, int> paymentType =
      GeneratedColumn<int>('payment_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<PaymentType>($InvoicesTable.$converter0);
  final VerificationMeta _totalAmountMeta =
      const VerificationMeta('totalAmount');
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
      'total_amount', aliasedName, false,
      check: () => totalAmount.isNotNull(),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  final VerificationMeta _amountTenderedMeta =
      const VerificationMeta('amountTendered');
  @override
  late final GeneratedColumn<double> amountTendered = GeneratedColumn<double>(
      'amount_tendered', aliasedName, false,
      check: () => amountTendered.isNotNull(),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  final VerificationMeta _dateRecordedMeta =
      const VerificationMeta('dateRecorded');
  @override
  late final GeneratedColumn<DateTime> dateRecorded = GeneratedColumn<DateTime>(
      'date_recorded', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "users" ("user_id")');
  @override
  List<GeneratedColumn> get $columns => [
        invoiceId,
        customerId,
        paymentType,
        totalAmount,
        amountTendered,
        dateRecorded,
        userId
      ];
  @override
  String get aliasedName => _alias ?? 'invoices';
  @override
  String get actualTableName => 'invoices';
  @override
  VerificationContext validateIntegrity(Insertable<Invoice> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('invoice_id')) {
      context.handle(_invoiceIdMeta,
          invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    context.handle(_paymentTypeMeta, const VerificationResult.success());
    if (data.containsKey('total_amount')) {
      context.handle(
          _totalAmountMeta,
          totalAmount.isAcceptableOrUnknown(
              data['total_amount']!, _totalAmountMeta));
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('amount_tendered')) {
      context.handle(
          _amountTenderedMeta,
          amountTendered.isAcceptableOrUnknown(
              data['amount_tendered']!, _amountTenderedMeta));
    } else if (isInserting) {
      context.missing(_amountTenderedMeta);
    }
    if (data.containsKey('date_recorded')) {
      context.handle(
          _dateRecordedMeta,
          dateRecorded.isAcceptableOrUnknown(
              data['date_recorded']!, _dateRecordedMeta));
    } else if (isInserting) {
      context.missing(_dateRecordedMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {invoiceId};
  @override
  Invoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Invoice(
      invoiceId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}invoice_id'])!,
      customerId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}customer_id'])!,
      paymentType: $InvoicesTable.$converter0.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.int, data['${effectivePrefix}payment_type'])!),
      totalAmount: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}total_amount'])!,
      amountTendered: attachedDatabase.options.types.read(
          DriftSqlType.double, data['${effectivePrefix}amount_tendered'])!,
      dateRecorded: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_recorded'])!,
      userId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }

  static TypeConverter<PaymentType, int> $converter0 =
      const EnumIndexConverter<PaymentType>(PaymentType.values);
}

class Supplier extends DataClass implements Insertable<Supplier> {
  final int supplierId;
  final String supplierCode;
  final String supplierName;
  final String supplierContact;
  final String supplierAddress;
  final String supplierEmail;
  const Supplier(
      {required this.supplierId,
      required this.supplierCode,
      required this.supplierName,
      required this.supplierContact,
      required this.supplierAddress,
      required this.supplierEmail});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['supplier_id'] = Variable<int>(supplierId);
    map['supplier_code'] = Variable<String>(supplierCode);
    map['supplier_name'] = Variable<String>(supplierName);
    map['supplier_contact'] = Variable<String>(supplierContact);
    map['supplier_address'] = Variable<String>(supplierAddress);
    map['supplier_email'] = Variable<String>(supplierEmail);
    return map;
  }

  SuppliersCompanion toCompanion(bool nullToAbsent) {
    return SuppliersCompanion(
      supplierId: Value(supplierId),
      supplierCode: Value(supplierCode),
      supplierName: Value(supplierName),
      supplierContact: Value(supplierContact),
      supplierAddress: Value(supplierAddress),
      supplierEmail: Value(supplierEmail),
    );
  }

  factory Supplier.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Supplier(
      supplierId: serializer.fromJson<int>(json['supplierId']),
      supplierCode: serializer.fromJson<String>(json['supplierCode']),
      supplierName: serializer.fromJson<String>(json['supplierName']),
      supplierContact: serializer.fromJson<String>(json['supplierContact']),
      supplierAddress: serializer.fromJson<String>(json['supplierAddress']),
      supplierEmail: serializer.fromJson<String>(json['supplierEmail']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'supplierId': serializer.toJson<int>(supplierId),
      'supplierCode': serializer.toJson<String>(supplierCode),
      'supplierName': serializer.toJson<String>(supplierName),
      'supplierContact': serializer.toJson<String>(supplierContact),
      'supplierAddress': serializer.toJson<String>(supplierAddress),
      'supplierEmail': serializer.toJson<String>(supplierEmail),
    };
  }

  Supplier copyWith(
          {int? supplierId,
          String? supplierCode,
          String? supplierName,
          String? supplierContact,
          String? supplierAddress,
          String? supplierEmail}) =>
      Supplier(
        supplierId: supplierId ?? this.supplierId,
        supplierCode: supplierCode ?? this.supplierCode,
        supplierName: supplierName ?? this.supplierName,
        supplierContact: supplierContact ?? this.supplierContact,
        supplierAddress: supplierAddress ?? this.supplierAddress,
        supplierEmail: supplierEmail ?? this.supplierEmail,
      );
  @override
  String toString() {
    return (StringBuffer('Supplier(')
          ..write('supplierId: $supplierId, ')
          ..write('supplierCode: $supplierCode, ')
          ..write('supplierName: $supplierName, ')
          ..write('supplierContact: $supplierContact, ')
          ..write('supplierAddress: $supplierAddress, ')
          ..write('supplierEmail: $supplierEmail')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(supplierId, supplierCode, supplierName,
      supplierContact, supplierAddress, supplierEmail);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Supplier &&
          other.supplierId == this.supplierId &&
          other.supplierCode == this.supplierCode &&
          other.supplierName == this.supplierName &&
          other.supplierContact == this.supplierContact &&
          other.supplierAddress == this.supplierAddress &&
          other.supplierEmail == this.supplierEmail);
}

class SuppliersCompanion extends UpdateCompanion<Supplier> {
  final Value<int> supplierId;
  final Value<String> supplierCode;
  final Value<String> supplierName;
  final Value<String> supplierContact;
  final Value<String> supplierAddress;
  final Value<String> supplierEmail;
  const SuppliersCompanion({
    this.supplierId = const Value.absent(),
    this.supplierCode = const Value.absent(),
    this.supplierName = const Value.absent(),
    this.supplierContact = const Value.absent(),
    this.supplierAddress = const Value.absent(),
    this.supplierEmail = const Value.absent(),
  });
  SuppliersCompanion.insert({
    this.supplierId = const Value.absent(),
    required String supplierCode,
    required String supplierName,
    required String supplierContact,
    required String supplierAddress,
    required String supplierEmail,
  })  : supplierCode = Value(supplierCode),
        supplierName = Value(supplierName),
        supplierContact = Value(supplierContact),
        supplierAddress = Value(supplierAddress),
        supplierEmail = Value(supplierEmail);
  static Insertable<Supplier> custom({
    Expression<int>? supplierId,
    Expression<String>? supplierCode,
    Expression<String>? supplierName,
    Expression<String>? supplierContact,
    Expression<String>? supplierAddress,
    Expression<String>? supplierEmail,
  }) {
    return RawValuesInsertable({
      if (supplierId != null) 'supplier_id': supplierId,
      if (supplierCode != null) 'supplier_code': supplierCode,
      if (supplierName != null) 'supplier_name': supplierName,
      if (supplierContact != null) 'supplier_contact': supplierContact,
      if (supplierAddress != null) 'supplier_address': supplierAddress,
      if (supplierEmail != null) 'supplier_email': supplierEmail,
    });
  }

  SuppliersCompanion copyWith(
      {Value<int>? supplierId,
      Value<String>? supplierCode,
      Value<String>? supplierName,
      Value<String>? supplierContact,
      Value<String>? supplierAddress,
      Value<String>? supplierEmail}) {
    return SuppliersCompanion(
      supplierId: supplierId ?? this.supplierId,
      supplierCode: supplierCode ?? this.supplierCode,
      supplierName: supplierName ?? this.supplierName,
      supplierContact: supplierContact ?? this.supplierContact,
      supplierAddress: supplierAddress ?? this.supplierAddress,
      supplierEmail: supplierEmail ?? this.supplierEmail,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (supplierId.present) {
      map['supplier_id'] = Variable<int>(supplierId.value);
    }
    if (supplierCode.present) {
      map['supplier_code'] = Variable<String>(supplierCode.value);
    }
    if (supplierName.present) {
      map['supplier_name'] = Variable<String>(supplierName.value);
    }
    if (supplierContact.present) {
      map['supplier_contact'] = Variable<String>(supplierContact.value);
    }
    if (supplierAddress.present) {
      map['supplier_address'] = Variable<String>(supplierAddress.value);
    }
    if (supplierEmail.present) {
      map['supplier_email'] = Variable<String>(supplierEmail.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersCompanion(')
          ..write('supplierId: $supplierId, ')
          ..write('supplierCode: $supplierCode, ')
          ..write('supplierName: $supplierName, ')
          ..write('supplierContact: $supplierContact, ')
          ..write('supplierAddress: $supplierAddress, ')
          ..write('supplierEmail: $supplierEmail')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTable extends Suppliers
    with TableInfo<$SuppliersTable, Supplier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _supplierIdMeta = const VerificationMeta('supplierId');
  @override
  late final GeneratedColumn<int> supplierId = GeneratedColumn<int>(
      'supplier_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _supplierCodeMeta =
      const VerificationMeta('supplierCode');
  @override
  late final GeneratedColumn<String> supplierCode = GeneratedColumn<String>(
      'supplier_code', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 25),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  final VerificationMeta _supplierNameMeta =
      const VerificationMeta('supplierName');
  @override
  late final GeneratedColumn<String> supplierName = GeneratedColumn<String>(
      'supplier_name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  final VerificationMeta _supplierContactMeta =
      const VerificationMeta('supplierContact');
  @override
  late final GeneratedColumn<String> supplierContact = GeneratedColumn<String>(
      'supplier_contact', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  final VerificationMeta _supplierAddressMeta =
      const VerificationMeta('supplierAddress');
  @override
  late final GeneratedColumn<String> supplierAddress = GeneratedColumn<String>(
      'supplier_address', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  final VerificationMeta _supplierEmailMeta =
      const VerificationMeta('supplierEmail');
  @override
  late final GeneratedColumn<String> supplierEmail = GeneratedColumn<String>(
      'supplier_email', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        supplierId,
        supplierCode,
        supplierName,
        supplierContact,
        supplierAddress,
        supplierEmail
      ];
  @override
  String get aliasedName => _alias ?? 'suppliers';
  @override
  String get actualTableName => 'suppliers';
  @override
  VerificationContext validateIntegrity(Insertable<Supplier> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('supplier_id')) {
      context.handle(
          _supplierIdMeta,
          supplierId.isAcceptableOrUnknown(
              data['supplier_id']!, _supplierIdMeta));
    }
    if (data.containsKey('supplier_code')) {
      context.handle(
          _supplierCodeMeta,
          supplierCode.isAcceptableOrUnknown(
              data['supplier_code']!, _supplierCodeMeta));
    } else if (isInserting) {
      context.missing(_supplierCodeMeta);
    }
    if (data.containsKey('supplier_name')) {
      context.handle(
          _supplierNameMeta,
          supplierName.isAcceptableOrUnknown(
              data['supplier_name']!, _supplierNameMeta));
    } else if (isInserting) {
      context.missing(_supplierNameMeta);
    }
    if (data.containsKey('supplier_contact')) {
      context.handle(
          _supplierContactMeta,
          supplierContact.isAcceptableOrUnknown(
              data['supplier_contact']!, _supplierContactMeta));
    } else if (isInserting) {
      context.missing(_supplierContactMeta);
    }
    if (data.containsKey('supplier_address')) {
      context.handle(
          _supplierAddressMeta,
          supplierAddress.isAcceptableOrUnknown(
              data['supplier_address']!, _supplierAddressMeta));
    } else if (isInserting) {
      context.missing(_supplierAddressMeta);
    }
    if (data.containsKey('supplier_email')) {
      context.handle(
          _supplierEmailMeta,
          supplierEmail.isAcceptableOrUnknown(
              data['supplier_email']!, _supplierEmailMeta));
    } else if (isInserting) {
      context.missing(_supplierEmailMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {supplierId};
  @override
  Supplier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Supplier(
      supplierId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}supplier_id'])!,
      supplierCode: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}supplier_code'])!,
      supplierName: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}supplier_name'])!,
      supplierContact: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}supplier_contact'])!,
      supplierAddress: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}supplier_address'])!,
      supplierEmail: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}supplier_email'])!,
    );
  }

  @override
  $SuppliersTable createAlias(String alias) {
    return $SuppliersTable(attachedDatabase, alias);
  }
}

class ReceiveProduct extends DataClass implements Insertable<ReceiveProduct> {
  final int receiveProductId;
  final int productId;
  final double quantity;
  final double unitPrice;
  final double subTotal;
  final int supplierId;
  final DateTime receivedDate;
  final int userId;
  const ReceiveProduct(
      {required this.receiveProductId,
      required this.productId,
      required this.quantity,
      required this.unitPrice,
      required this.subTotal,
      required this.supplierId,
      required this.receivedDate,
      required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['receive_product_id'] = Variable<int>(receiveProductId);
    map['product_id'] = Variable<int>(productId);
    map['quantity'] = Variable<double>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    map['supplier_id'] = Variable<int>(supplierId);
    map['received_date'] = Variable<DateTime>(receivedDate);
    map['user_id'] = Variable<int>(userId);
    return map;
  }

  ReceiveProductsCompanion toCompanion(bool nullToAbsent) {
    return ReceiveProductsCompanion(
      receiveProductId: Value(receiveProductId),
      productId: Value(productId),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      supplierId: Value(supplierId),
      receivedDate: Value(receivedDate),
      userId: Value(userId),
    );
  }

  factory ReceiveProduct.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReceiveProduct(
      receiveProductId: serializer.fromJson<int>(json['receiveProductId']),
      productId: serializer.fromJson<int>(json['productId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      subTotal: serializer.fromJson<double>(json['subTotal']),
      supplierId: serializer.fromJson<int>(json['supplierId']),
      receivedDate: serializer.fromJson<DateTime>(json['receivedDate']),
      userId: serializer.fromJson<int>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'receiveProductId': serializer.toJson<int>(receiveProductId),
      'productId': serializer.toJson<int>(productId),
      'quantity': serializer.toJson<double>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'subTotal': serializer.toJson<double>(subTotal),
      'supplierId': serializer.toJson<int>(supplierId),
      'receivedDate': serializer.toJson<DateTime>(receivedDate),
      'userId': serializer.toJson<int>(userId),
    };
  }

  ReceiveProduct copyWith(
          {int? receiveProductId,
          int? productId,
          double? quantity,
          double? unitPrice,
          double? subTotal,
          int? supplierId,
          DateTime? receivedDate,
          int? userId}) =>
      ReceiveProduct(
        receiveProductId: receiveProductId ?? this.receiveProductId,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        unitPrice: unitPrice ?? this.unitPrice,
        subTotal: subTotal ?? this.subTotal,
        supplierId: supplierId ?? this.supplierId,
        receivedDate: receivedDate ?? this.receivedDate,
        userId: userId ?? this.userId,
      );
  @override
  String toString() {
    return (StringBuffer('ReceiveProduct(')
          ..write('receiveProductId: $receiveProductId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('subTotal: $subTotal, ')
          ..write('supplierId: $supplierId, ')
          ..write('receivedDate: $receivedDate, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(receiveProductId, productId, quantity,
      unitPrice, subTotal, supplierId, receivedDate, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReceiveProduct &&
          other.receiveProductId == this.receiveProductId &&
          other.productId == this.productId &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.subTotal == this.subTotal &&
          other.supplierId == this.supplierId &&
          other.receivedDate == this.receivedDate &&
          other.userId == this.userId);
}

class ReceiveProductsCompanion extends UpdateCompanion<ReceiveProduct> {
  final Value<int> receiveProductId;
  final Value<int> productId;
  final Value<double> quantity;
  final Value<double> unitPrice;
  final Value<int> supplierId;
  final Value<DateTime> receivedDate;
  final Value<int> userId;
  const ReceiveProductsCompanion({
    this.receiveProductId = const Value.absent(),
    this.productId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.receivedDate = const Value.absent(),
    this.userId = const Value.absent(),
  });
  ReceiveProductsCompanion.insert({
    this.receiveProductId = const Value.absent(),
    required int productId,
    required double quantity,
    required double unitPrice,
    required int supplierId,
    required DateTime receivedDate,
    required int userId,
  })  : productId = Value(productId),
        quantity = Value(quantity),
        unitPrice = Value(unitPrice),
        supplierId = Value(supplierId),
        receivedDate = Value(receivedDate),
        userId = Value(userId);
  static Insertable<ReceiveProduct> custom({
    Expression<int>? receiveProductId,
    Expression<int>? productId,
    Expression<double>? quantity,
    Expression<double>? unitPrice,
    Expression<int>? supplierId,
    Expression<DateTime>? receivedDate,
    Expression<int>? userId,
  }) {
    return RawValuesInsertable({
      if (receiveProductId != null) 'receive_product_id': receiveProductId,
      if (productId != null) 'product_id': productId,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (supplierId != null) 'supplier_id': supplierId,
      if (receivedDate != null) 'received_date': receivedDate,
      if (userId != null) 'user_id': userId,
    });
  }

  ReceiveProductsCompanion copyWith(
      {Value<int>? receiveProductId,
      Value<int>? productId,
      Value<double>? quantity,
      Value<double>? unitPrice,
      Value<int>? supplierId,
      Value<DateTime>? receivedDate,
      Value<int>? userId}) {
    return ReceiveProductsCompanion(
      receiveProductId: receiveProductId ?? this.receiveProductId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      supplierId: supplierId ?? this.supplierId,
      receivedDate: receivedDate ?? this.receivedDate,
      userId: userId ?? this.userId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (receiveProductId.present) {
      map['receive_product_id'] = Variable<int>(receiveProductId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<int>(supplierId.value);
    }
    if (receivedDate.present) {
      map['received_date'] = Variable<DateTime>(receivedDate.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiveProductsCompanion(')
          ..write('receiveProductId: $receiveProductId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('supplierId: $supplierId, ')
          ..write('receivedDate: $receivedDate, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }
}

class $ReceiveProductsTable extends ReceiveProducts
    with TableInfo<$ReceiveProductsTable, ReceiveProduct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceiveProductsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _receiveProductIdMeta =
      const VerificationMeta('receiveProductId');
  @override
  late final GeneratedColumn<int> receiveProductId = GeneratedColumn<int>(
      'receive_product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "products" ("product_id")');
  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, false,
      check: () => quantity.isNotNull(),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  final VerificationMeta _unitPriceMeta = const VerificationMeta('unitPrice');
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
      'unit_price', aliasedName, false,
      check: () => unitPrice.isNotNull(),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  final VerificationMeta _subTotalMeta = const VerificationMeta('subTotal');
  @override
  late final GeneratedColumn<double> subTotal = GeneratedColumn<double>(
      'sub_total', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      generatedAs: GeneratedAs(quantity * unitPrice, false));
  final VerificationMeta _supplierIdMeta = const VerificationMeta('supplierId');
  @override
  late final GeneratedColumn<int> supplierId = GeneratedColumn<int>(
      'supplier_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "suppliers" ("supplier_id")');
  final VerificationMeta _receivedDateMeta =
      const VerificationMeta('receivedDate');
  @override
  late final GeneratedColumn<DateTime> receivedDate = GeneratedColumn<DateTime>(
      'received_date', aliasedName, false,
      check: () => receivedDate.isNotNull(),
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true);
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "users" ("user_id")');
  @override
  List<GeneratedColumn> get $columns => [
        receiveProductId,
        productId,
        quantity,
        unitPrice,
        subTotal,
        supplierId,
        receivedDate,
        userId
      ];
  @override
  String get aliasedName => _alias ?? 'receive_products';
  @override
  String get actualTableName => 'receive_products';
  @override
  VerificationContext validateIntegrity(Insertable<ReceiveProduct> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('receive_product_id')) {
      context.handle(
          _receiveProductIdMeta,
          receiveProductId.isAcceptableOrUnknown(
              data['receive_product_id']!, _receiveProductIdMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(_unitPriceMeta,
          unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta));
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('sub_total')) {
      context.handle(_subTotalMeta,
          subTotal.isAcceptableOrUnknown(data['sub_total']!, _subTotalMeta));
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
          _supplierIdMeta,
          supplierId.isAcceptableOrUnknown(
              data['supplier_id']!, _supplierIdMeta));
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('received_date')) {
      context.handle(
          _receivedDateMeta,
          receivedDate.isAcceptableOrUnknown(
              data['received_date']!, _receivedDateMeta));
    } else if (isInserting) {
      context.missing(_receivedDateMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {receiveProductId};
  @override
  ReceiveProduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReceiveProduct(
      receiveProductId: attachedDatabase.options.types.read(
          DriftSqlType.int, data['${effectivePrefix}receive_product_id'])!,
      productId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      quantity: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}quantity'])!,
      unitPrice: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}unit_price'])!,
      subTotal: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}sub_total'])!,
      supplierId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}supplier_id'])!,
      receivedDate: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}received_date'])!,
      userId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $ReceiveProductsTable createAlias(String alias) {
    return $ReceiveProductsTable(attachedDatabase, alias);
  }
}

class PurchaseOrder extends DataClass implements Insertable<PurchaseOrder> {
  final int purchaseOrderId;
  final int productId;
  final double quantity;
  final double unitPrice;
  final double subTotal;
  final int supplierId;
  final DateTime orderDate;
  final int userId;
  const PurchaseOrder(
      {required this.purchaseOrderId,
      required this.productId,
      required this.quantity,
      required this.unitPrice,
      required this.subTotal,
      required this.supplierId,
      required this.orderDate,
      required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['purchase_order_id'] = Variable<int>(purchaseOrderId);
    map['product_id'] = Variable<int>(productId);
    map['quantity'] = Variable<double>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    map['supplier_id'] = Variable<int>(supplierId);
    map['order_date'] = Variable<DateTime>(orderDate);
    map['user_id'] = Variable<int>(userId);
    return map;
  }

  PurchaseOrdersCompanion toCompanion(bool nullToAbsent) {
    return PurchaseOrdersCompanion(
      purchaseOrderId: Value(purchaseOrderId),
      productId: Value(productId),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      supplierId: Value(supplierId),
      orderDate: Value(orderDate),
      userId: Value(userId),
    );
  }

  factory PurchaseOrder.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseOrder(
      purchaseOrderId: serializer.fromJson<int>(json['purchaseOrderId']),
      productId: serializer.fromJson<int>(json['productId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      subTotal: serializer.fromJson<double>(json['subTotal']),
      supplierId: serializer.fromJson<int>(json['supplierId']),
      orderDate: serializer.fromJson<DateTime>(json['orderDate']),
      userId: serializer.fromJson<int>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'purchaseOrderId': serializer.toJson<int>(purchaseOrderId),
      'productId': serializer.toJson<int>(productId),
      'quantity': serializer.toJson<double>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'subTotal': serializer.toJson<double>(subTotal),
      'supplierId': serializer.toJson<int>(supplierId),
      'orderDate': serializer.toJson<DateTime>(orderDate),
      'userId': serializer.toJson<int>(userId),
    };
  }

  PurchaseOrder copyWith(
          {int? purchaseOrderId,
          int? productId,
          double? quantity,
          double? unitPrice,
          double? subTotal,
          int? supplierId,
          DateTime? orderDate,
          int? userId}) =>
      PurchaseOrder(
        purchaseOrderId: purchaseOrderId ?? this.purchaseOrderId,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        unitPrice: unitPrice ?? this.unitPrice,
        subTotal: subTotal ?? this.subTotal,
        supplierId: supplierId ?? this.supplierId,
        orderDate: orderDate ?? this.orderDate,
        userId: userId ?? this.userId,
      );
  @override
  String toString() {
    return (StringBuffer('PurchaseOrder(')
          ..write('purchaseOrderId: $purchaseOrderId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('subTotal: $subTotal, ')
          ..write('supplierId: $supplierId, ')
          ..write('orderDate: $orderDate, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(purchaseOrderId, productId, quantity,
      unitPrice, subTotal, supplierId, orderDate, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseOrder &&
          other.purchaseOrderId == this.purchaseOrderId &&
          other.productId == this.productId &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.subTotal == this.subTotal &&
          other.supplierId == this.supplierId &&
          other.orderDate == this.orderDate &&
          other.userId == this.userId);
}

class PurchaseOrdersCompanion extends UpdateCompanion<PurchaseOrder> {
  final Value<int> purchaseOrderId;
  final Value<int> productId;
  final Value<double> quantity;
  final Value<double> unitPrice;
  final Value<int> supplierId;
  final Value<DateTime> orderDate;
  final Value<int> userId;
  const PurchaseOrdersCompanion({
    this.purchaseOrderId = const Value.absent(),
    this.productId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.orderDate = const Value.absent(),
    this.userId = const Value.absent(),
  });
  PurchaseOrdersCompanion.insert({
    this.purchaseOrderId = const Value.absent(),
    required int productId,
    required double quantity,
    required double unitPrice,
    required int supplierId,
    required DateTime orderDate,
    required int userId,
  })  : productId = Value(productId),
        quantity = Value(quantity),
        unitPrice = Value(unitPrice),
        supplierId = Value(supplierId),
        orderDate = Value(orderDate),
        userId = Value(userId);
  static Insertable<PurchaseOrder> custom({
    Expression<int>? purchaseOrderId,
    Expression<int>? productId,
    Expression<double>? quantity,
    Expression<double>? unitPrice,
    Expression<int>? supplierId,
    Expression<DateTime>? orderDate,
    Expression<int>? userId,
  }) {
    return RawValuesInsertable({
      if (purchaseOrderId != null) 'purchase_order_id': purchaseOrderId,
      if (productId != null) 'product_id': productId,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (supplierId != null) 'supplier_id': supplierId,
      if (orderDate != null) 'order_date': orderDate,
      if (userId != null) 'user_id': userId,
    });
  }

  PurchaseOrdersCompanion copyWith(
      {Value<int>? purchaseOrderId,
      Value<int>? productId,
      Value<double>? quantity,
      Value<double>? unitPrice,
      Value<int>? supplierId,
      Value<DateTime>? orderDate,
      Value<int>? userId}) {
    return PurchaseOrdersCompanion(
      purchaseOrderId: purchaseOrderId ?? this.purchaseOrderId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      supplierId: supplierId ?? this.supplierId,
      orderDate: orderDate ?? this.orderDate,
      userId: userId ?? this.userId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (purchaseOrderId.present) {
      map['purchase_order_id'] = Variable<int>(purchaseOrderId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<int>(supplierId.value);
    }
    if (orderDate.present) {
      map['order_date'] = Variable<DateTime>(orderDate.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrdersCompanion(')
          ..write('purchaseOrderId: $purchaseOrderId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('supplierId: $supplierId, ')
          ..write('orderDate: $orderDate, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }
}

class $PurchaseOrdersTable extends PurchaseOrders
    with TableInfo<$PurchaseOrdersTable, PurchaseOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseOrdersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _purchaseOrderIdMeta =
      const VerificationMeta('purchaseOrderId');
  @override
  late final GeneratedColumn<int> purchaseOrderId = GeneratedColumn<int>(
      'purchase_order_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "products" ("product_id")');
  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, false,
      check: () => quantity.isNotNull(),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  final VerificationMeta _unitPriceMeta = const VerificationMeta('unitPrice');
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
      'unit_price', aliasedName, false,
      check: () => unitPrice.isNotNull(),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  final VerificationMeta _subTotalMeta = const VerificationMeta('subTotal');
  @override
  late final GeneratedColumn<double> subTotal = GeneratedColumn<double>(
      'sub_total', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      generatedAs: GeneratedAs(quantity * unitPrice, false));
  final VerificationMeta _supplierIdMeta = const VerificationMeta('supplierId');
  @override
  late final GeneratedColumn<int> supplierId = GeneratedColumn<int>(
      'supplier_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "suppliers" ("supplier_id")');
  final VerificationMeta _orderDateMeta = const VerificationMeta('orderDate');
  @override
  late final GeneratedColumn<DateTime> orderDate = GeneratedColumn<DateTime>(
      'order_date', aliasedName, false,
      check: () => orderDate.isNotNull(),
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true);
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "users" ("user_id")');
  @override
  List<GeneratedColumn> get $columns => [
        purchaseOrderId,
        productId,
        quantity,
        unitPrice,
        subTotal,
        supplierId,
        orderDate,
        userId
      ];
  @override
  String get aliasedName => _alias ?? 'purchase_orders';
  @override
  String get actualTableName => 'purchase_orders';
  @override
  VerificationContext validateIntegrity(Insertable<PurchaseOrder> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('purchase_order_id')) {
      context.handle(
          _purchaseOrderIdMeta,
          purchaseOrderId.isAcceptableOrUnknown(
              data['purchase_order_id']!, _purchaseOrderIdMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(_unitPriceMeta,
          unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta));
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('sub_total')) {
      context.handle(_subTotalMeta,
          subTotal.isAcceptableOrUnknown(data['sub_total']!, _subTotalMeta));
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
          _supplierIdMeta,
          supplierId.isAcceptableOrUnknown(
              data['supplier_id']!, _supplierIdMeta));
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('order_date')) {
      context.handle(_orderDateMeta,
          orderDate.isAcceptableOrUnknown(data['order_date']!, _orderDateMeta));
    } else if (isInserting) {
      context.missing(_orderDateMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {purchaseOrderId};
  @override
  PurchaseOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseOrder(
      purchaseOrderId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}purchase_order_id'])!,
      productId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      quantity: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}quantity'])!,
      unitPrice: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}unit_price'])!,
      subTotal: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}sub_total'])!,
      supplierId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}supplier_id'])!,
      orderDate: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}order_date'])!,
      userId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $PurchaseOrdersTable createAlias(String alias) {
    return $PurchaseOrdersTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $UsersTable users = $UsersTable(this);
  late final $ProductUnitsTable productUnits = $ProductUnitsTable(this);
  late final $ProductCategoriesTable productCategories =
      $ProductCategoriesTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $SalesTable sales = $SalesTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $SuppliersTable suppliers = $SuppliersTable(this);
  late final $ReceiveProductsTable receiveProducts =
      $ReceiveProductsTable(this);
  late final $PurchaseOrdersTable purchaseOrders = $PurchaseOrdersTable(this);
  late final InvoicesDao invoicesDao = InvoicesDao(this as MyDatabase);
  late final AccountsDao accountsDao = AccountsDao(this as MyDatabase);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        productUnits,
        productCategories,
        products,
        sales,
        customers,
        invoices,
        suppliers,
        receiveProducts,
        purchaseOrders
      ];
}

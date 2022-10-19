// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class User extends DataClass implements Insertable<User> {
  final int id;
  final String? firebaseUid;
  final String? username;
  final String? password;
  final String? contact;
  final UserType accountType;
  const User(
      {required this.id,
      this.firebaseUid,
      this.username,
      this.password,
      this.contact,
      required this.accountType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || firebaseUid != null) {
      map['firebase_uid'] = Variable<String>(firebaseUid);
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    if (!nullToAbsent || contact != null) {
      map['contact'] = Variable<String>(contact);
    }
    {
      final converter = $UsersTable.$converter0;
      map['account_type'] = Variable<int>(converter.toSql(accountType));
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      firebaseUid: firebaseUid == null && nullToAbsent
          ? const Value.absent()
          : Value(firebaseUid),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      contact: contact == null && nullToAbsent
          ? const Value.absent()
          : Value(contact),
      accountType: Value(accountType),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      firebaseUid: serializer.fromJson<String?>(json['firebaseUid']),
      username: serializer.fromJson<String?>(json['username']),
      password: serializer.fromJson<String?>(json['password']),
      contact: serializer.fromJson<String?>(json['contact']),
      accountType: serializer.fromJson<UserType>(json['accountType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firebaseUid': serializer.toJson<String?>(firebaseUid),
      'username': serializer.toJson<String?>(username),
      'password': serializer.toJson<String?>(password),
      'contact': serializer.toJson<String?>(contact),
      'accountType': serializer.toJson<UserType>(accountType),
    };
  }

  User copyWith(
          {int? id,
          Value<String?> firebaseUid = const Value.absent(),
          Value<String?> username = const Value.absent(),
          Value<String?> password = const Value.absent(),
          Value<String?> contact = const Value.absent(),
          UserType? accountType}) =>
      User(
        id: id ?? this.id,
        firebaseUid: firebaseUid.present ? firebaseUid.value : this.firebaseUid,
        username: username.present ? username.value : this.username,
        password: password.present ? password.value : this.password,
        contact: contact.present ? contact.value : this.contact,
        accountType: accountType ?? this.accountType,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('firebaseUid: $firebaseUid, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('contact: $contact, ')
          ..write('accountType: $accountType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, firebaseUid, username, password, contact, accountType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.firebaseUid == this.firebaseUid &&
          other.username == this.username &&
          other.password == this.password &&
          other.contact == this.contact &&
          other.accountType == this.accountType);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String?> firebaseUid;
  final Value<String?> username;
  final Value<String?> password;
  final Value<String?> contact;
  final Value<UserType> accountType;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.firebaseUid = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.contact = const Value.absent(),
    this.accountType = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    this.firebaseUid = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.contact = const Value.absent(),
    this.accountType = const Value.absent(),
  });
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? firebaseUid,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? contact,
    Expression<int>? accountType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firebaseUid != null) 'firebase_uid': firebaseUid,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (contact != null) 'contact': contact,
      if (accountType != null) 'account_type': accountType,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String?>? firebaseUid,
      Value<String?>? username,
      Value<String?>? password,
      Value<String?>? contact,
      Value<UserType>? accountType}) {
    return UsersCompanion(
      id: id ?? this.id,
      firebaseUid: firebaseUid ?? this.firebaseUid,
      username: username ?? this.username,
      password: password ?? this.password,
      contact: contact ?? this.contact,
      accountType: accountType ?? this.accountType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
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
    if (contact.present) {
      map['contact'] = Variable<String>(contact.value);
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
          ..write('id: $id, ')
          ..write('firebaseUid: $firebaseUid, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('contact: $contact, ')
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
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _firebaseUidMeta =
      const VerificationMeta('firebaseUid');
  @override
  late final GeneratedColumn<String> firebaseUid = GeneratedColumn<String>(
      'firebase_uid', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  final VerificationMeta _contactMeta = const VerificationMeta('contact');
  @override
  late final GeneratedColumn<String> contact = GeneratedColumn<String>(
      'contact', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  final VerificationMeta _accountTypeMeta =
      const VerificationMeta('accountType');
  @override
  late final GeneratedColumnWithTypeConverter<UserType, int> accountType =
      GeneratedColumn<int>('account_type', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: Constant(UserType.admin.index))
          .withConverter<UserType>($UsersTable.$converter0);
  @override
  List<GeneratedColumn> get $columns =>
      [id, firebaseUid, username, password, contact, accountType];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('firebase_uid')) {
      context.handle(
          _firebaseUidMeta,
          firebaseUid.isAcceptableOrUnknown(
              data['firebase_uid']!, _firebaseUidMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    }
    if (data.containsKey('contact')) {
      context.handle(_contactMeta,
          contact.isAcceptableOrUnknown(data['contact']!, _contactMeta));
    }
    context.handle(_accountTypeMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      firebaseUid: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}firebase_uid']),
      username: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}username']),
      password: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}password']),
      contact: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}contact']),
      accountType: $UsersTable.$converter0.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.int, data['${effectivePrefix}account_type'])!),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }

  static TypeConverter<UserType, int> $converter0 =
      const EnumIndexConverter<UserType>(UserType.values);
}

class ProductCategory extends DataClass implements Insertable<ProductCategory> {
  final int id;
  final String name;
  const ProductCategory({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  ProductCategoriesCompanion toCompanion(bool nullToAbsent) {
    return ProductCategoriesCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory ProductCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductCategory(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  ProductCategory copyWith({int? id, String? name}) => ProductCategory(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('ProductCategory(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductCategory &&
          other.id == this.id &&
          other.name == this.name);
}

class ProductCategoriesCompanion extends UpdateCompanion<ProductCategory> {
  final Value<int> id;
  final Value<String> name;
  const ProductCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  ProductCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<ProductCategory> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  ProductCategoriesCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return ProductCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
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
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      check: () => name.isNotNull(),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'product_categories';
  @override
  String get actualTableName => 'product_categories';
  @override
  VerificationContext validateIntegrity(Insertable<ProductCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductCategory(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $ProductCategoriesTable createAlias(String alias) {
    return $ProductCategoriesTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String? code;
  final String name;
  final int categoryId;
  final double unitInStock;
  final double discountPercentage;
  final double reorderLevel;
  final int? userId;
  const Product(
      {required this.id,
      this.code,
      required this.name,
      required this.categoryId,
      required this.unitInStock,
      required this.discountPercentage,
      required this.reorderLevel,
      this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    map['name'] = Variable<String>(name);
    map['category_id'] = Variable<int>(categoryId);
    map['unit_in_stock'] = Variable<double>(unitInStock);
    map['discount_percentage'] = Variable<double>(discountPercentage);
    map['reorder_level'] = Variable<double>(reorderLevel);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      name: Value(name),
      categoryId: Value(categoryId),
      unitInStock: Value(unitInStock),
      discountPercentage: Value(discountPercentage),
      reorderLevel: Value(reorderLevel),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String?>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      unitInStock: serializer.fromJson<double>(json['unitInStock']),
      discountPercentage:
          serializer.fromJson<double>(json['discountPercentage']),
      reorderLevel: serializer.fromJson<double>(json['reorderLevel']),
      userId: serializer.fromJson<int?>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String?>(code),
      'name': serializer.toJson<String>(name),
      'categoryId': serializer.toJson<int>(categoryId),
      'unitInStock': serializer.toJson<double>(unitInStock),
      'discountPercentage': serializer.toJson<double>(discountPercentage),
      'reorderLevel': serializer.toJson<double>(reorderLevel),
      'userId': serializer.toJson<int?>(userId),
    };
  }

  Product copyWith(
          {int? id,
          Value<String?> code = const Value.absent(),
          String? name,
          int? categoryId,
          double? unitInStock,
          double? discountPercentage,
          double? reorderLevel,
          Value<int?> userId = const Value.absent()}) =>
      Product(
        id: id ?? this.id,
        code: code.present ? code.value : this.code,
        name: name ?? this.name,
        categoryId: categoryId ?? this.categoryId,
        unitInStock: unitInStock ?? this.unitInStock,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        reorderLevel: reorderLevel ?? this.reorderLevel,
        userId: userId.present ? userId.value : this.userId,
      );
  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('unitInStock: $unitInStock, ')
          ..write('discountPercentage: $discountPercentage, ')
          ..write('reorderLevel: $reorderLevel, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, name, categoryId, unitInStock,
      discountPercentage, reorderLevel, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.categoryId == this.categoryId &&
          other.unitInStock == this.unitInStock &&
          other.discountPercentage == this.discountPercentage &&
          other.reorderLevel == this.reorderLevel &&
          other.userId == this.userId);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String?> code;
  final Value<String> name;
  final Value<int> categoryId;
  final Value<double> unitInStock;
  final Value<double> discountPercentage;
  final Value<double> reorderLevel;
  final Value<int?> userId;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.unitInStock = const Value.absent(),
    this.discountPercentage = const Value.absent(),
    this.reorderLevel = const Value.absent(),
    this.userId = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    required String name,
    required int categoryId,
    this.unitInStock = const Value.absent(),
    required double discountPercentage,
    required double reorderLevel,
    this.userId = const Value.absent(),
  })  : name = Value(name),
        categoryId = Value(categoryId),
        discountPercentage = Value(discountPercentage),
        reorderLevel = Value(reorderLevel);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? categoryId,
    Expression<double>? unitInStock,
    Expression<double>? discountPercentage,
    Expression<double>? reorderLevel,
    Expression<int>? userId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (categoryId != null) 'category_id': categoryId,
      if (unitInStock != null) 'unit_in_stock': unitInStock,
      if (discountPercentage != null) 'discount_percentage': discountPercentage,
      if (reorderLevel != null) 'reorder_level': reorderLevel,
      if (userId != null) 'user_id': userId,
    });
  }

  ProductsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? code,
      Value<String>? name,
      Value<int>? categoryId,
      Value<double>? unitInStock,
      Value<double>? discountPercentage,
      Value<double>? reorderLevel,
      Value<int?>? userId}) {
    return ProductsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      unitInStock: unitInStock ?? this.unitInStock,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      reorderLevel: reorderLevel ?? this.reorderLevel,
      userId: userId ?? this.userId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (unitInStock.present) {
      map['unit_in_stock'] = Variable<double>(unitInStock.value);
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
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('unitInStock: $unitInStock, ')
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
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "product_categories" ("id")');
  final VerificationMeta _unitInStockMeta =
      const VerificationMeta('unitInStock');
  @override
  late final GeneratedColumn<double> unitInStock = GeneratedColumn<double>(
      'unit_in_stock', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
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
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES "users" ("id")');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        code,
        name,
        categoryId,
        unitInStock,
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
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
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      code: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      categoryId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      unitInStock: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}unit_in_stock'])!,
      discountPercentage: attachedDatabase.options.types.read(
          DriftSqlType.double, data['${effectivePrefix}discount_percentage'])!,
      reorderLevel: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}reorder_level'])!,
      userId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}user_id']),
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class ProductUnit extends DataClass implements Insertable<ProductUnit> {
  final int id;
  final String code;
  final double price;
  final double box;
  final double subTotal;
  final int productId;
  const ProductUnit(
      {required this.id,
      required this.code,
      required this.price,
      required this.box,
      required this.subTotal,
      required this.productId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['price'] = Variable<double>(price);
    map['box'] = Variable<double>(box);
    map['product_id'] = Variable<int>(productId);
    return map;
  }

  ProductUnitsCompanion toCompanion(bool nullToAbsent) {
    return ProductUnitsCompanion(
      id: Value(id),
      code: Value(code),
      price: Value(price),
      box: Value(box),
      productId: Value(productId),
    );
  }

  factory ProductUnit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductUnit(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      price: serializer.fromJson<double>(json['price']),
      box: serializer.fromJson<double>(json['box']),
      subTotal: serializer.fromJson<double>(json['subTotal']),
      productId: serializer.fromJson<int>(json['productId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'price': serializer.toJson<double>(price),
      'box': serializer.toJson<double>(box),
      'subTotal': serializer.toJson<double>(subTotal),
      'productId': serializer.toJson<int>(productId),
    };
  }

  ProductUnit copyWith(
          {int? id,
          String? code,
          double? price,
          double? box,
          double? subTotal,
          int? productId}) =>
      ProductUnit(
        id: id ?? this.id,
        code: code ?? this.code,
        price: price ?? this.price,
        box: box ?? this.box,
        subTotal: subTotal ?? this.subTotal,
        productId: productId ?? this.productId,
      );
  @override
  String toString() {
    return (StringBuffer('ProductUnit(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('price: $price, ')
          ..write('box: $box, ')
          ..write('subTotal: $subTotal, ')
          ..write('productId: $productId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, price, box, subTotal, productId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductUnit &&
          other.id == this.id &&
          other.code == this.code &&
          other.price == this.price &&
          other.box == this.box &&
          other.subTotal == this.subTotal &&
          other.productId == this.productId);
}

class ProductUnitsCompanion extends UpdateCompanion<ProductUnit> {
  final Value<int> id;
  final Value<String> code;
  final Value<double> price;
  final Value<double> box;
  final Value<int> productId;
  const ProductUnitsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.price = const Value.absent(),
    this.box = const Value.absent(),
    this.productId = const Value.absent(),
  });
  ProductUnitsCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required double price,
    this.box = const Value.absent(),
    required int productId,
  })  : code = Value(code),
        price = Value(price),
        productId = Value(productId);
  static Insertable<ProductUnit> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<double>? price,
    Expression<double>? box,
    Expression<int>? productId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (price != null) 'price': price,
      if (box != null) 'box': box,
      if (productId != null) 'product_id': productId,
    });
  }

  ProductUnitsCompanion copyWith(
      {Value<int>? id,
      Value<String>? code,
      Value<double>? price,
      Value<double>? box,
      Value<int>? productId}) {
    return ProductUnitsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      price: price ?? this.price,
      box: box ?? this.box,
      productId: productId ?? this.productId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (box.present) {
      map['box'] = Variable<double>(box.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductUnitsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('price: $price, ')
          ..write('box: $box, ')
          ..write('productId: $productId')
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
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _boxMeta = const VerificationMeta('box');
  @override
  late final GeneratedColumn<double> box = GeneratedColumn<double>(
      'box', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  final VerificationMeta _subTotalMeta = const VerificationMeta('subTotal');
  @override
  late final GeneratedColumn<double> subTotal = GeneratedColumn<double>(
      'sub_total', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      generatedAs: GeneratedAs(price * box, false));
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "products" ("id")');
  @override
  List<GeneratedColumn> get $columns =>
      [id, code, price, box, subTotal, productId];
  @override
  String get aliasedName => _alias ?? 'product_units';
  @override
  String get actualTableName => 'product_units';
  @override
  VerificationContext validateIntegrity(Insertable<ProductUnit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('box')) {
      context.handle(
          _boxMeta, box.isAcceptableOrUnknown(data['box']!, _boxMeta));
    }
    if (data.containsKey('sub_total')) {
      context.handle(_subTotalMeta,
          subTotal.isAcceptableOrUnknown(data['sub_total']!, _subTotalMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductUnit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductUnit(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      code: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      price: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      box: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}box'])!,
      subTotal: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}sub_total'])!,
      productId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
    );
  }

  @override
  $ProductUnitsTable createAlias(String alias) {
    return $ProductUnitsTable(attachedDatabase, alias);
  }
}

class Account extends DataClass implements Insertable<Account> {
  final int id;
  final String? code;
  final String name;
  final String? contact;
  final String? address;
  final String? email;
  final AccountType accountType;
  const Account(
      {required this.id,
      this.code,
      required this.name,
      this.contact,
      this.address,
      this.email,
      required this.accountType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || contact != null) {
      map['contact'] = Variable<String>(contact);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    {
      final converter = $AccountsTable.$converter0;
      map['account_type'] = Variable<int>(converter.toSql(accountType));
    }
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      name: Value(name),
      contact: contact == null && nullToAbsent
          ? const Value.absent()
          : Value(contact),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      accountType: Value(accountType),
    );
  }

  factory Account.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Account(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String?>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      contact: serializer.fromJson<String?>(json['contact']),
      address: serializer.fromJson<String?>(json['address']),
      email: serializer.fromJson<String?>(json['email']),
      accountType: serializer.fromJson<AccountType>(json['accountType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String?>(code),
      'name': serializer.toJson<String>(name),
      'contact': serializer.toJson<String?>(contact),
      'address': serializer.toJson<String?>(address),
      'email': serializer.toJson<String?>(email),
      'accountType': serializer.toJson<AccountType>(accountType),
    };
  }

  Account copyWith(
          {int? id,
          Value<String?> code = const Value.absent(),
          String? name,
          Value<String?> contact = const Value.absent(),
          Value<String?> address = const Value.absent(),
          Value<String?> email = const Value.absent(),
          AccountType? accountType}) =>
      Account(
        id: id ?? this.id,
        code: code.present ? code.value : this.code,
        name: name ?? this.name,
        contact: contact.present ? contact.value : this.contact,
        address: address.present ? address.value : this.address,
        email: email.present ? email.value : this.email,
        accountType: accountType ?? this.accountType,
      );
  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('contact: $contact, ')
          ..write('address: $address, ')
          ..write('email: $email, ')
          ..write('accountType: $accountType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, code, name, contact, address, email, accountType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Account &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.contact == this.contact &&
          other.address == this.address &&
          other.email == this.email &&
          other.accountType == this.accountType);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<int> id;
  final Value<String?> code;
  final Value<String> name;
  final Value<String?> contact;
  final Value<String?> address;
  final Value<String?> email;
  final Value<AccountType> accountType;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.contact = const Value.absent(),
    this.address = const Value.absent(),
    this.email = const Value.absent(),
    this.accountType = const Value.absent(),
  });
  AccountsCompanion.insert({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    required String name,
    this.contact = const Value.absent(),
    this.address = const Value.absent(),
    this.email = const Value.absent(),
    required AccountType accountType,
  })  : name = Value(name),
        accountType = Value(accountType);
  static Insertable<Account> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? contact,
    Expression<String>? address,
    Expression<String>? email,
    Expression<int>? accountType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (contact != null) 'contact': contact,
      if (address != null) 'address': address,
      if (email != null) 'email': email,
      if (accountType != null) 'account_type': accountType,
    });
  }

  AccountsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? code,
      Value<String>? name,
      Value<String?>? contact,
      Value<String?>? address,
      Value<String?>? email,
      Value<AccountType>? accountType}) {
    return AccountsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      contact: contact ?? this.contact,
      address: address ?? this.address,
      email: email ?? this.email,
      accountType: accountType ?? this.accountType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (contact.present) {
      map['contact'] = Variable<String>(contact.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (accountType.present) {
      final converter = $AccountsTable.$converter0;
      map['account_type'] = Variable<int>(converter.toSql(accountType.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('contact: $contact, ')
          ..write('address: $address, ')
          ..write('email: $email, ')
          ..write('accountType: $accountType')
          ..write(')'))
        .toString();
  }
}

class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 25),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  final VerificationMeta _contactMeta = const VerificationMeta('contact');
  @override
  late final GeneratedColumn<String> contact = GeneratedColumn<String>(
      'contact', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  final VerificationMeta _addressMeta = const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  final VerificationMeta _accountTypeMeta =
      const VerificationMeta('accountType');
  @override
  late final GeneratedColumnWithTypeConverter<AccountType, int> accountType =
      GeneratedColumn<int>('account_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<AccountType>($AccountsTable.$converter0);
  @override
  List<GeneratedColumn> get $columns =>
      [id, code, name, contact, address, email, accountType];
  @override
  String get aliasedName => _alias ?? 'accounts';
  @override
  String get actualTableName => 'accounts';
  @override
  VerificationContext validateIntegrity(Insertable<Account> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('contact')) {
      context.handle(_contactMeta,
          contact.isAcceptableOrUnknown(data['contact']!, _contactMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    context.handle(_accountTypeMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Account(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      code: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      contact: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}contact']),
      address: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      email: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      accountType: $AccountsTable.$converter0.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.int, data['${effectivePrefix}account_type'])!),
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountType, int> $converter0 =
      const EnumIndexConverter<AccountType>(AccountType.values);
}

class Invoice extends DataClass implements Insertable<Invoice> {
  final int id;
  final int accountId;
  final PaymentType paymentType;
  final InvoiceType invoiceType;
  final double? totalAmount;
  final double amountTendered;
  final DateTime dateRecorded;
  final int? userId;
  const Invoice(
      {required this.id,
      required this.accountId,
      required this.paymentType,
      required this.invoiceType,
      this.totalAmount,
      required this.amountTendered,
      required this.dateRecorded,
      this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account_id'] = Variable<int>(accountId);
    {
      final converter = $InvoicesTable.$converter0;
      map['payment_type'] = Variable<int>(converter.toSql(paymentType));
    }
    {
      final converter = $InvoicesTable.$converter1;
      map['invoice_type'] = Variable<int>(converter.toSql(invoiceType));
    }
    if (!nullToAbsent || totalAmount != null) {
      map['total_amount'] = Variable<double>(totalAmount);
    }
    map['amount_tendered'] = Variable<double>(amountTendered);
    map['date_recorded'] = Variable<DateTime>(dateRecorded);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      accountId: Value(accountId),
      paymentType: Value(paymentType),
      invoiceType: Value(invoiceType),
      totalAmount: totalAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(totalAmount),
      amountTendered: Value(amountTendered),
      dateRecorded: Value(dateRecorded),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
    );
  }

  factory Invoice.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Invoice(
      id: serializer.fromJson<int>(json['id']),
      accountId: serializer.fromJson<int>(json['accountId']),
      paymentType: serializer.fromJson<PaymentType>(json['paymentType']),
      invoiceType: serializer.fromJson<InvoiceType>(json['invoiceType']),
      totalAmount: serializer.fromJson<double?>(json['totalAmount']),
      amountTendered: serializer.fromJson<double>(json['amountTendered']),
      dateRecorded: serializer.fromJson<DateTime>(json['dateRecorded']),
      userId: serializer.fromJson<int?>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accountId': serializer.toJson<int>(accountId),
      'paymentType': serializer.toJson<PaymentType>(paymentType),
      'invoiceType': serializer.toJson<InvoiceType>(invoiceType),
      'totalAmount': serializer.toJson<double?>(totalAmount),
      'amountTendered': serializer.toJson<double>(amountTendered),
      'dateRecorded': serializer.toJson<DateTime>(dateRecorded),
      'userId': serializer.toJson<int?>(userId),
    };
  }

  Invoice copyWith(
          {int? id,
          int? accountId,
          PaymentType? paymentType,
          InvoiceType? invoiceType,
          Value<double?> totalAmount = const Value.absent(),
          double? amountTendered,
          DateTime? dateRecorded,
          Value<int?> userId = const Value.absent()}) =>
      Invoice(
        id: id ?? this.id,
        accountId: accountId ?? this.accountId,
        paymentType: paymentType ?? this.paymentType,
        invoiceType: invoiceType ?? this.invoiceType,
        totalAmount: totalAmount.present ? totalAmount.value : this.totalAmount,
        amountTendered: amountTendered ?? this.amountTendered,
        dateRecorded: dateRecorded ?? this.dateRecorded,
        userId: userId.present ? userId.value : this.userId,
      );
  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('paymentType: $paymentType, ')
          ..write('invoiceType: $invoiceType, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('amountTendered: $amountTendered, ')
          ..write('dateRecorded: $dateRecorded, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, accountId, paymentType, invoiceType,
      totalAmount, amountTendered, dateRecorded, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.paymentType == this.paymentType &&
          other.invoiceType == this.invoiceType &&
          other.totalAmount == this.totalAmount &&
          other.amountTendered == this.amountTendered &&
          other.dateRecorded == this.dateRecorded &&
          other.userId == this.userId);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<int> id;
  final Value<int> accountId;
  final Value<PaymentType> paymentType;
  final Value<InvoiceType> invoiceType;
  final Value<double?> totalAmount;
  final Value<double> amountTendered;
  final Value<DateTime> dateRecorded;
  final Value<int?> userId;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.paymentType = const Value.absent(),
    this.invoiceType = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.amountTendered = const Value.absent(),
    this.dateRecorded = const Value.absent(),
    this.userId = const Value.absent(),
  });
  InvoicesCompanion.insert({
    this.id = const Value.absent(),
    required int accountId,
    required PaymentType paymentType,
    required InvoiceType invoiceType,
    this.totalAmount = const Value.absent(),
    required double amountTendered,
    this.dateRecorded = const Value.absent(),
    this.userId = const Value.absent(),
  })  : accountId = Value(accountId),
        paymentType = Value(paymentType),
        invoiceType = Value(invoiceType),
        amountTendered = Value(amountTendered);
  static Insertable<Invoice> custom({
    Expression<int>? id,
    Expression<int>? accountId,
    Expression<int>? paymentType,
    Expression<int>? invoiceType,
    Expression<double>? totalAmount,
    Expression<double>? amountTendered,
    Expression<DateTime>? dateRecorded,
    Expression<int>? userId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (paymentType != null) 'payment_type': paymentType,
      if (invoiceType != null) 'invoice_type': invoiceType,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (amountTendered != null) 'amount_tendered': amountTendered,
      if (dateRecorded != null) 'date_recorded': dateRecorded,
      if (userId != null) 'user_id': userId,
    });
  }

  InvoicesCompanion copyWith(
      {Value<int>? id,
      Value<int>? accountId,
      Value<PaymentType>? paymentType,
      Value<InvoiceType>? invoiceType,
      Value<double?>? totalAmount,
      Value<double>? amountTendered,
      Value<DateTime>? dateRecorded,
      Value<int?>? userId}) {
    return InvoicesCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      paymentType: paymentType ?? this.paymentType,
      invoiceType: invoiceType ?? this.invoiceType,
      totalAmount: totalAmount ?? this.totalAmount,
      amountTendered: amountTendered ?? this.amountTendered,
      dateRecorded: dateRecorded ?? this.dateRecorded,
      userId: userId ?? this.userId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (paymentType.present) {
      final converter = $InvoicesTable.$converter0;
      map['payment_type'] = Variable<int>(converter.toSql(paymentType.value));
    }
    if (invoiceType.present) {
      final converter = $InvoicesTable.$converter1;
      map['invoice_type'] = Variable<int>(converter.toSql(invoiceType.value));
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
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('paymentType: $paymentType, ')
          ..write('invoiceType: $invoiceType, ')
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
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _accountIdMeta = const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
      'account_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "accounts" ("id")');
  final VerificationMeta _paymentTypeMeta =
      const VerificationMeta('paymentType');
  @override
  late final GeneratedColumnWithTypeConverter<PaymentType, int> paymentType =
      GeneratedColumn<int>('payment_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<PaymentType>($InvoicesTable.$converter0);
  final VerificationMeta _invoiceTypeMeta =
      const VerificationMeta('invoiceType');
  @override
  late final GeneratedColumnWithTypeConverter<InvoiceType, int> invoiceType =
      GeneratedColumn<int>('invoice_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<InvoiceType>($InvoicesTable.$converter1);
  final VerificationMeta _totalAmountMeta =
      const VerificationMeta('totalAmount');
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
      'total_amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  final VerificationMeta _amountTenderedMeta =
      const VerificationMeta('amountTendered');
  @override
  late final GeneratedColumn<double> amountTendered = GeneratedColumn<double>(
      'amount_tendered', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _dateRecordedMeta =
      const VerificationMeta('dateRecorded');
  @override
  late final GeneratedColumn<DateTime> dateRecorded = GeneratedColumn<DateTime>(
      'date_recorded', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES "users" ("id")');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        accountId,
        paymentType,
        invoiceType,
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    context.handle(_paymentTypeMeta, const VerificationResult.success());
    context.handle(_invoiceTypeMeta, const VerificationResult.success());
    if (data.containsKey('total_amount')) {
      context.handle(
          _totalAmountMeta,
          totalAmount.isAcceptableOrUnknown(
              data['total_amount']!, _totalAmountMeta));
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
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Invoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Invoice(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      accountId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}account_id'])!,
      paymentType: $InvoicesTable.$converter0.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.int, data['${effectivePrefix}payment_type'])!),
      invoiceType: $InvoicesTable.$converter1.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.int, data['${effectivePrefix}invoice_type'])!),
      totalAmount: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}total_amount']),
      amountTendered: attachedDatabase.options.types.read(
          DriftSqlType.double, data['${effectivePrefix}amount_tendered'])!,
      dateRecorded: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_recorded'])!,
      userId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}user_id']),
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }

  static TypeConverter<PaymentType, int> $converter0 =
      const EnumIndexConverter<PaymentType>(PaymentType.values);
  static TypeConverter<InvoiceType, int> $converter1 =
      const EnumIndexConverter<InvoiceType>(InvoiceType.values);
}

class Sale extends DataClass implements Insertable<Sale> {
  final int salesId;
  final int invoiceId;
  final int productId;
  final int unitId;
  final double quantity;
  final double unitPrice;
  final double subTotal;
  const Sale(
      {required this.salesId,
      required this.invoiceId,
      required this.productId,
      required this.unitId,
      required this.quantity,
      required this.unitPrice,
      required this.subTotal});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['sales_id'] = Variable<int>(salesId);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['product_id'] = Variable<int>(productId);
    map['unit_id'] = Variable<int>(unitId);
    map['quantity'] = Variable<double>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    return map;
  }

  SalesCompanion toCompanion(bool nullToAbsent) {
    return SalesCompanion(
      salesId: Value(salesId),
      invoiceId: Value(invoiceId),
      productId: Value(productId),
      unitId: Value(unitId),
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
      unitId: serializer.fromJson<int>(json['unitId']),
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
      'unitId': serializer.toJson<int>(unitId),
      'quantity': serializer.toJson<double>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'subTotal': serializer.toJson<double>(subTotal),
    };
  }

  Sale copyWith(
          {int? salesId,
          int? invoiceId,
          int? productId,
          int? unitId,
          double? quantity,
          double? unitPrice,
          double? subTotal}) =>
      Sale(
        salesId: salesId ?? this.salesId,
        invoiceId: invoiceId ?? this.invoiceId,
        productId: productId ?? this.productId,
        unitId: unitId ?? this.unitId,
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
          ..write('unitId: $unitId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('subTotal: $subTotal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      salesId, invoiceId, productId, unitId, quantity, unitPrice, subTotal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sale &&
          other.salesId == this.salesId &&
          other.invoiceId == this.invoiceId &&
          other.productId == this.productId &&
          other.unitId == this.unitId &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.subTotal == this.subTotal);
}

class SalesCompanion extends UpdateCompanion<Sale> {
  final Value<int> salesId;
  final Value<int> invoiceId;
  final Value<int> productId;
  final Value<int> unitId;
  final Value<double> quantity;
  final Value<double> unitPrice;
  const SalesCompanion({
    this.salesId = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.productId = const Value.absent(),
    this.unitId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
  });
  SalesCompanion.insert({
    this.salesId = const Value.absent(),
    required int invoiceId,
    required int productId,
    required int unitId,
    required double quantity,
    required double unitPrice,
  })  : invoiceId = Value(invoiceId),
        productId = Value(productId),
        unitId = Value(unitId),
        quantity = Value(quantity),
        unitPrice = Value(unitPrice);
  static Insertable<Sale> custom({
    Expression<int>? salesId,
    Expression<int>? invoiceId,
    Expression<int>? productId,
    Expression<int>? unitId,
    Expression<double>? quantity,
    Expression<double>? unitPrice,
  }) {
    return RawValuesInsertable({
      if (salesId != null) 'sales_id': salesId,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (productId != null) 'product_id': productId,
      if (unitId != null) 'unit_id': unitId,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
    });
  }

  SalesCompanion copyWith(
      {Value<int>? salesId,
      Value<int>? invoiceId,
      Value<int>? productId,
      Value<int>? unitId,
      Value<double>? quantity,
      Value<double>? unitPrice}) {
    return SalesCompanion(
      salesId: salesId ?? this.salesId,
      invoiceId: invoiceId ?? this.invoiceId,
      productId: productId ?? this.productId,
      unitId: unitId ?? this.unitId,
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
    if (unitId.present) {
      map['unit_id'] = Variable<int>(unitId.value);
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
          ..write('unitId: $unitId, ')
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
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "invoices" ("id")');
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "products" ("id")');
  final VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<int> unitId = GeneratedColumn<int>(
      'unit_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "product_units" ("id")');
  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _unitPriceMeta = const VerificationMeta('unitPrice');
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
      'unit_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _subTotalMeta = const VerificationMeta('subTotal');
  @override
  late final GeneratedColumn<double> subTotal = GeneratedColumn<double>(
      'sub_total', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      generatedAs: GeneratedAs(quantity * unitPrice, false));
  @override
  List<GeneratedColumn> get $columns =>
      [salesId, invoiceId, productId, unitId, quantity, unitPrice, subTotal];
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
    if (data.containsKey('unit_id')) {
      context.handle(_unitIdMeta,
          unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta));
    } else if (isInserting) {
      context.missing(_unitIdMeta);
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
      unitId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}unit_id'])!,
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
    this.receivedDate = const Value.absent(),
    required int userId,
  })  : productId = Value(productId),
        quantity = Value(quantity),
        unitPrice = Value(unitPrice),
        supplierId = Value(supplierId),
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
      defaultConstraints: 'REFERENCES "products" ("id")');
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
      defaultConstraints: 'REFERENCES "accounts" ("id")');
  final VerificationMeta _receivedDateMeta =
      const VerificationMeta('receivedDate');
  @override
  late final GeneratedColumn<DateTime> receivedDate = GeneratedColumn<DateTime>(
      'received_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "users" ("id")');
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
    this.orderDate = const Value.absent(),
    required int userId,
  })  : productId = Value(productId),
        quantity = Value(quantity),
        unitPrice = Value(unitPrice),
        supplierId = Value(supplierId),
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
      defaultConstraints: 'REFERENCES "products" ("id")');
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
      defaultConstraints: 'REFERENCES "accounts" ("id")');
  final VerificationMeta _orderDateMeta = const VerificationMeta('orderDate');
  @override
  late final GeneratedColumn<DateTime> orderDate = GeneratedColumn<DateTime>(
      'order_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "users" ("id")');
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

class Debt extends DataClass implements Insertable<Debt> {
  final int id;
  final double amount;
  final int? accountId;
  final DateTime dateRecorded;
  final bool isCredit;
  final String? description;
  final int? userId;
  const Debt(
      {required this.id,
      required this.amount,
      this.accountId,
      required this.dateRecorded,
      required this.isCredit,
      this.description,
      this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<int>(accountId);
    }
    map['date_recorded'] = Variable<DateTime>(dateRecorded);
    map['is_credit'] = Variable<bool>(isCredit);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    return map;
  }

  DebtsCompanion toCompanion(bool nullToAbsent) {
    return DebtsCompanion(
      id: Value(id),
      amount: Value(amount),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      dateRecorded: Value(dateRecorded),
      isCredit: Value(isCredit),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
    );
  }

  factory Debt.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Debt(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
      accountId: serializer.fromJson<int?>(json['accountId']),
      dateRecorded: serializer.fromJson<DateTime>(json['dateRecorded']),
      isCredit: serializer.fromJson<bool>(json['isCredit']),
      description: serializer.fromJson<String?>(json['description']),
      userId: serializer.fromJson<int?>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<double>(amount),
      'accountId': serializer.toJson<int?>(accountId),
      'dateRecorded': serializer.toJson<DateTime>(dateRecorded),
      'isCredit': serializer.toJson<bool>(isCredit),
      'description': serializer.toJson<String?>(description),
      'userId': serializer.toJson<int?>(userId),
    };
  }

  Debt copyWith(
          {int? id,
          double? amount,
          Value<int?> accountId = const Value.absent(),
          DateTime? dateRecorded,
          bool? isCredit,
          Value<String?> description = const Value.absent(),
          Value<int?> userId = const Value.absent()}) =>
      Debt(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        accountId: accountId.present ? accountId.value : this.accountId,
        dateRecorded: dateRecorded ?? this.dateRecorded,
        isCredit: isCredit ?? this.isCredit,
        description: description.present ? description.value : this.description,
        userId: userId.present ? userId.value : this.userId,
      );
  @override
  String toString() {
    return (StringBuffer('Debt(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('accountId: $accountId, ')
          ..write('dateRecorded: $dateRecorded, ')
          ..write('isCredit: $isCredit, ')
          ..write('description: $description, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, amount, accountId, dateRecorded, isCredit, description, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Debt &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.accountId == this.accountId &&
          other.dateRecorded == this.dateRecorded &&
          other.isCredit == this.isCredit &&
          other.description == this.description &&
          other.userId == this.userId);
}

class DebtsCompanion extends UpdateCompanion<Debt> {
  final Value<int> id;
  final Value<double> amount;
  final Value<int?> accountId;
  final Value<DateTime> dateRecorded;
  final Value<bool> isCredit;
  final Value<String?> description;
  final Value<int?> userId;
  const DebtsCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.accountId = const Value.absent(),
    this.dateRecorded = const Value.absent(),
    this.isCredit = const Value.absent(),
    this.description = const Value.absent(),
    this.userId = const Value.absent(),
  });
  DebtsCompanion.insert({
    this.id = const Value.absent(),
    required double amount,
    this.accountId = const Value.absent(),
    this.dateRecorded = const Value.absent(),
    required bool isCredit,
    this.description = const Value.absent(),
    this.userId = const Value.absent(),
  })  : amount = Value(amount),
        isCredit = Value(isCredit);
  static Insertable<Debt> custom({
    Expression<int>? id,
    Expression<double>? amount,
    Expression<int>? accountId,
    Expression<DateTime>? dateRecorded,
    Expression<bool>? isCredit,
    Expression<String>? description,
    Expression<int>? userId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (accountId != null) 'account_id': accountId,
      if (dateRecorded != null) 'date_recorded': dateRecorded,
      if (isCredit != null) 'is_credit': isCredit,
      if (description != null) 'description': description,
      if (userId != null) 'user_id': userId,
    });
  }

  DebtsCompanion copyWith(
      {Value<int>? id,
      Value<double>? amount,
      Value<int?>? accountId,
      Value<DateTime>? dateRecorded,
      Value<bool>? isCredit,
      Value<String?>? description,
      Value<int?>? userId}) {
    return DebtsCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      accountId: accountId ?? this.accountId,
      dateRecorded: dateRecorded ?? this.dateRecorded,
      isCredit: isCredit ?? this.isCredit,
      description: description ?? this.description,
      userId: userId ?? this.userId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (dateRecorded.present) {
      map['date_recorded'] = Variable<DateTime>(dateRecorded.value);
    }
    if (isCredit.present) {
      map['is_credit'] = Variable<bool>(isCredit.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DebtsCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('accountId: $accountId, ')
          ..write('dateRecorded: $dateRecorded, ')
          ..write('isCredit: $isCredit, ')
          ..write('description: $description, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }
}

class $DebtsTable extends Debts with TableInfo<$DebtsTable, Debt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DebtsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _accountIdMeta = const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
      'account_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES "accounts" ("id")');
  final VerificationMeta _dateRecordedMeta =
      const VerificationMeta('dateRecorded');
  @override
  late final GeneratedColumn<DateTime> dateRecorded = GeneratedColumn<DateTime>(
      'date_recorded', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  final VerificationMeta _isCreditMeta = const VerificationMeta('isCredit');
  @override
  late final GeneratedColumn<bool> isCredit = GeneratedColumn<bool>(
      'is_credit', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK ("is_credit" IN (0, 1))');
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES "users" ("id")');
  @override
  List<GeneratedColumn> get $columns =>
      [id, amount, accountId, dateRecorded, isCredit, description, userId];
  @override
  String get aliasedName => _alias ?? 'debts';
  @override
  String get actualTableName => 'debts';
  @override
  VerificationContext validateIntegrity(Insertable<Debt> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    }
    if (data.containsKey('date_recorded')) {
      context.handle(
          _dateRecordedMeta,
          dateRecorded.isAcceptableOrUnknown(
              data['date_recorded']!, _dateRecordedMeta));
    }
    if (data.containsKey('is_credit')) {
      context.handle(_isCreditMeta,
          isCredit.isAcceptableOrUnknown(data['is_credit']!, _isCreditMeta));
    } else if (isInserting) {
      context.missing(_isCreditMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Debt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Debt(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      amount: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      accountId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}account_id']),
      dateRecorded: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_recorded'])!,
      isCredit: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_credit'])!,
      description: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      userId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}user_id']),
    );
  }

  @override
  $DebtsTable createAlias(String alias) {
    return $DebtsTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $UsersTable users = $UsersTable(this);
  late final $ProductCategoriesTable productCategories =
      $ProductCategoriesTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $ProductUnitsTable productUnits = $ProductUnitsTable(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $SalesTable sales = $SalesTable(this);
  late final $ReceiveProductsTable receiveProducts =
      $ReceiveProductsTable(this);
  late final $PurchaseOrdersTable purchaseOrders = $PurchaseOrdersTable(this);
  late final $DebtsTable debts = $DebtsTable(this);
  late final InvoicesDao invoicesDao = InvoicesDao(this as MyDatabase);
  late final AccountsDao accountsDao = AccountsDao(this as MyDatabase);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        productCategories,
        products,
        productUnits,
        accounts,
        invoices,
        sales,
        receiveProducts,
        purchaseOrders,
        debts
      ];
}

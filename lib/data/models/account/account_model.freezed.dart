// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) {
  return _AccountModel.fromJson(json);
}

/// @nodoc
mixin _$AccountModel {
  int get uid => throw _privateConstructorUsedError;
  double get balance => throw _privateConstructorUsedError;
  String get accountName => throw _privateConstructorUsedError;
  String get accountNo => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get createTime => throw _privateConstructorUsedError;
  int get updateTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AccountModelCopyWith<AccountModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountModelCopyWith<$Res> {
  factory $AccountModelCopyWith(
          AccountModel value, $Res Function(AccountModel) then) =
      _$AccountModelCopyWithImpl<$Res, AccountModel>;
  @useResult
  $Res call(
      {int uid,
      double balance,
      String accountName,
      String accountNo,
      String status,
      int createTime,
      int updateTime});
}

/// @nodoc
class _$AccountModelCopyWithImpl<$Res, $Val extends AccountModel>
    implements $AccountModelCopyWith<$Res> {
  _$AccountModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? balance = null,
    Object? accountName = null,
    Object? accountNo = null,
    Object? status = null,
    Object? createTime = null,
    Object? updateTime = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as int,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      accountName: null == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String,
      accountNo: null == accountNo
          ? _value.accountNo
          : accountNo // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createTime: null == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as int,
      updateTime: null == updateTime
          ? _value.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AccountModelCopyWith<$Res>
    implements $AccountModelCopyWith<$Res> {
  factory _$$_AccountModelCopyWith(
          _$_AccountModel value, $Res Function(_$_AccountModel) then) =
      __$$_AccountModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int uid,
      double balance,
      String accountName,
      String accountNo,
      String status,
      int createTime,
      int updateTime});
}

/// @nodoc
class __$$_AccountModelCopyWithImpl<$Res>
    extends _$AccountModelCopyWithImpl<$Res, _$_AccountModel>
    implements _$$_AccountModelCopyWith<$Res> {
  __$$_AccountModelCopyWithImpl(
      _$_AccountModel _value, $Res Function(_$_AccountModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? balance = null,
    Object? accountName = null,
    Object? accountNo = null,
    Object? status = null,
    Object? createTime = null,
    Object? updateTime = null,
  }) {
    return _then(_$_AccountModel(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as int,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      accountName: null == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String,
      accountNo: null == accountNo
          ? _value.accountNo
          : accountNo // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createTime: null == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as int,
      updateTime: null == updateTime
          ? _value.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AccountModel implements _AccountModel {
  const _$_AccountModel(
      {required this.uid,
      required this.balance,
      required this.accountName,
      required this.accountNo,
      required this.status,
      required this.createTime,
      required this.updateTime});

  factory _$_AccountModel.fromJson(Map<String, dynamic> json) =>
      _$$_AccountModelFromJson(json);

  @override
  final int uid;
  @override
  final double balance;
  @override
  final String accountName;
  @override
  final String accountNo;
  @override
  final String status;
  @override
  final int createTime;
  @override
  final int updateTime;

  @override
  String toString() {
    return 'AccountModel(uid: $uid, balance: $balance, accountName: $accountName, accountNo: $accountNo, status: $status, createTime: $createTime, updateTime: $updateTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AccountModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.accountName, accountName) ||
                other.accountName == accountName) &&
            (identical(other.accountNo, accountNo) ||
                other.accountNo == accountNo) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createTime, createTime) ||
                other.createTime == createTime) &&
            (identical(other.updateTime, updateTime) ||
                other.updateTime == updateTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, uid, balance, accountName,
      accountNo, status, createTime, updateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AccountModelCopyWith<_$_AccountModel> get copyWith =>
      __$$_AccountModelCopyWithImpl<_$_AccountModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AccountModelToJson(
      this,
    );
  }
}

abstract class _AccountModel implements AccountModel {
  const factory _AccountModel(
      {required final int uid,
      required final double balance,
      required final String accountName,
      required final String accountNo,
      required final String status,
      required final int createTime,
      required final int updateTime}) = _$_AccountModel;

  factory _AccountModel.fromJson(Map<String, dynamic> json) =
      _$_AccountModel.fromJson;

  @override
  int get uid;
  @override
  double get balance;
  @override
  String get accountName;
  @override
  String get accountNo;
  @override
  String get status;
  @override
  int get createTime;
  @override
  int get updateTime;
  @override
  @JsonKey(ignore: true)
  _$$_AccountModelCopyWith<_$_AccountModel> get copyWith =>
      throw _privateConstructorUsedError;
}

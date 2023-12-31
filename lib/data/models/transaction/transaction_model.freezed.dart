// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  return _TransactionModel.fromJson(json);
}

/// @nodoc
mixin _$TransactionModel {
  int? get uid => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  int? get createTime => throw _privateConstructorUsedError;
  String get senderAccountNo => throw _privateConstructorUsedError;
  String get traxType => throw _privateConstructorUsedError;
  String get receiverAccountNo => throw _privateConstructorUsedError;
  String? get senderName => throw _privateConstructorUsedError;
  String? get receiverName => throw _privateConstructorUsedError;
  bool? get isApproved => throw _privateConstructorUsedError;
  int? get relatedId => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentSnapshot<Object?>? get documentSnapshot =>
      throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionModelCopyWith<TransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionModelCopyWith<$Res> {
  factory $TransactionModelCopyWith(
          TransactionModel value, $Res Function(TransactionModel) then) =
      _$TransactionModelCopyWithImpl<$Res, TransactionModel>;
  @useResult
  $Res call(
      {int? uid,
      double amount,
      int? createTime,
      String senderAccountNo,
      String traxType,
      String receiverAccountNo,
      String? senderName,
      String? receiverName,
      bool? isApproved,
      int? relatedId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      DocumentSnapshot<Object?>? documentSnapshot,
      @JsonKey(includeFromJson: false, includeToJson: false) String? id});
}

/// @nodoc
class _$TransactionModelCopyWithImpl<$Res, $Val extends TransactionModel>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? amount = null,
    Object? createTime = freezed,
    Object? senderAccountNo = null,
    Object? traxType = null,
    Object? receiverAccountNo = null,
    Object? senderName = freezed,
    Object? receiverName = freezed,
    Object? isApproved = freezed,
    Object? relatedId = freezed,
    Object? documentSnapshot = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as int?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      createTime: freezed == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as int?,
      senderAccountNo: null == senderAccountNo
          ? _value.senderAccountNo
          : senderAccountNo // ignore: cast_nullable_to_non_nullable
              as String,
      traxType: null == traxType
          ? _value.traxType
          : traxType // ignore: cast_nullable_to_non_nullable
              as String,
      receiverAccountNo: null == receiverAccountNo
          ? _value.receiverAccountNo
          : receiverAccountNo // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: freezed == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String?,
      receiverName: freezed == receiverName
          ? _value.receiverName
          : receiverName // ignore: cast_nullable_to_non_nullable
              as String?,
      isApproved: freezed == isApproved
          ? _value.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool?,
      relatedId: freezed == relatedId
          ? _value.relatedId
          : relatedId // ignore: cast_nullable_to_non_nullable
              as int?,
      documentSnapshot: freezed == documentSnapshot
          ? _value.documentSnapshot
          : documentSnapshot // ignore: cast_nullable_to_non_nullable
              as DocumentSnapshot<Object?>?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransactionModelCopyWith<$Res>
    implements $TransactionModelCopyWith<$Res> {
  factory _$$_TransactionModelCopyWith(
          _$_TransactionModel value, $Res Function(_$_TransactionModel) then) =
      __$$_TransactionModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? uid,
      double amount,
      int? createTime,
      String senderAccountNo,
      String traxType,
      String receiverAccountNo,
      String? senderName,
      String? receiverName,
      bool? isApproved,
      int? relatedId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      DocumentSnapshot<Object?>? documentSnapshot,
      @JsonKey(includeFromJson: false, includeToJson: false) String? id});
}

/// @nodoc
class __$$_TransactionModelCopyWithImpl<$Res>
    extends _$TransactionModelCopyWithImpl<$Res, _$_TransactionModel>
    implements _$$_TransactionModelCopyWith<$Res> {
  __$$_TransactionModelCopyWithImpl(
      _$_TransactionModel _value, $Res Function(_$_TransactionModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? amount = null,
    Object? createTime = freezed,
    Object? senderAccountNo = null,
    Object? traxType = null,
    Object? receiverAccountNo = null,
    Object? senderName = freezed,
    Object? receiverName = freezed,
    Object? isApproved = freezed,
    Object? relatedId = freezed,
    Object? documentSnapshot = freezed,
    Object? id = freezed,
  }) {
    return _then(_$_TransactionModel(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as int?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      createTime: freezed == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as int?,
      senderAccountNo: null == senderAccountNo
          ? _value.senderAccountNo
          : senderAccountNo // ignore: cast_nullable_to_non_nullable
              as String,
      traxType: null == traxType
          ? _value.traxType
          : traxType // ignore: cast_nullable_to_non_nullable
              as String,
      receiverAccountNo: null == receiverAccountNo
          ? _value.receiverAccountNo
          : receiverAccountNo // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: freezed == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String?,
      receiverName: freezed == receiverName
          ? _value.receiverName
          : receiverName // ignore: cast_nullable_to_non_nullable
              as String?,
      isApproved: freezed == isApproved
          ? _value.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool?,
      relatedId: freezed == relatedId
          ? _value.relatedId
          : relatedId // ignore: cast_nullable_to_non_nullable
              as int?,
      documentSnapshot: freezed == documentSnapshot
          ? _value.documentSnapshot
          : documentSnapshot // ignore: cast_nullable_to_non_nullable
              as DocumentSnapshot<Object?>?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TransactionModel implements _TransactionModel {
  const _$_TransactionModel(
      {this.uid,
      required this.amount,
      this.createTime,
      required this.senderAccountNo,
      required this.traxType,
      required this.receiverAccountNo,
      this.senderName,
      this.receiverName,
      this.isApproved,
      this.relatedId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.documentSnapshot,
      @JsonKey(includeFromJson: false, includeToJson: false) this.id});

  factory _$_TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$$_TransactionModelFromJson(json);

  @override
  final int? uid;
  @override
  final double amount;
  @override
  final int? createTime;
  @override
  final String senderAccountNo;
  @override
  final String traxType;
  @override
  final String receiverAccountNo;
  @override
  final String? senderName;
  @override
  final String? receiverName;
  @override
  final bool? isApproved;
  @override
  final int? relatedId;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final DocumentSnapshot<Object?>? documentSnapshot;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? id;

  @override
  String toString() {
    return 'TransactionModel(uid: $uid, amount: $amount, createTime: $createTime, senderAccountNo: $senderAccountNo, traxType: $traxType, receiverAccountNo: $receiverAccountNo, senderName: $senderName, receiverName: $receiverName, isApproved: $isApproved, relatedId: $relatedId, documentSnapshot: $documentSnapshot, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.createTime, createTime) ||
                other.createTime == createTime) &&
            (identical(other.senderAccountNo, senderAccountNo) ||
                other.senderAccountNo == senderAccountNo) &&
            (identical(other.traxType, traxType) ||
                other.traxType == traxType) &&
            (identical(other.receiverAccountNo, receiverAccountNo) ||
                other.receiverAccountNo == receiverAccountNo) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.receiverName, receiverName) ||
                other.receiverName == receiverName) &&
            (identical(other.isApproved, isApproved) ||
                other.isApproved == isApproved) &&
            (identical(other.relatedId, relatedId) ||
                other.relatedId == relatedId) &&
            (identical(other.documentSnapshot, documentSnapshot) ||
                other.documentSnapshot == documentSnapshot) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      amount,
      createTime,
      senderAccountNo,
      traxType,
      receiverAccountNo,
      senderName,
      receiverName,
      isApproved,
      relatedId,
      documentSnapshot,
      id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionModelCopyWith<_$_TransactionModel> get copyWith =>
      __$$_TransactionModelCopyWithImpl<_$_TransactionModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransactionModelToJson(
      this,
    );
  }
}

abstract class _TransactionModel implements TransactionModel {
  const factory _TransactionModel(
      {final int? uid,
      required final double amount,
      final int? createTime,
      required final String senderAccountNo,
      required final String traxType,
      required final String receiverAccountNo,
      final String? senderName,
      final String? receiverName,
      final bool? isApproved,
      final int? relatedId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final DocumentSnapshot<Object?>? documentSnapshot,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final String? id}) = _$_TransactionModel;

  factory _TransactionModel.fromJson(Map<String, dynamic> json) =
      _$_TransactionModel.fromJson;

  @override
  int? get uid;
  @override
  double get amount;
  @override
  int? get createTime;
  @override
  String get senderAccountNo;
  @override
  String get traxType;
  @override
  String get receiverAccountNo;
  @override
  String? get senderName;
  @override
  String? get receiverName;
  @override
  bool? get isApproved;
  @override
  int? get relatedId;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentSnapshot<Object?>? get documentSnapshot;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionModelCopyWith<_$_TransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

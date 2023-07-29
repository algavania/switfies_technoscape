// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saving_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SavingModel _$SavingModelFromJson(Map<String, dynamic> json) {
  return _SavingModel.fromJson(json);
}

/// @nodoc
mixin _$SavingModel {
  String get title => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get frequency => throw _privateConstructorUsedError;
  double get savingAdviceAmount => throw _privateConstructorUsedError;
  dynamic get currentSaving => throw _privateConstructorUsedError;
  dynamic get savingTarget => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentSnapshot<Object?>? get documentSnapshot =>
      throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get startDate => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get endDate => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SavingModelCopyWith<SavingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavingModelCopyWith<$Res> {
  factory $SavingModelCopyWith(
          SavingModel value, $Res Function(SavingModel) then) =
      _$SavingModelCopyWithImpl<$Res, SavingModel>;
  @useResult
  $Res call(
      {String title,
      String category,
      String frequency,
      double savingAdviceAmount,
      dynamic currentSaving,
      dynamic savingTarget,
      @JsonKey(includeFromJson: false, includeToJson: false) String? id,
      @JsonKey(includeFromJson: false, includeToJson: false)
      DocumentSnapshot<Object?>? documentSnapshot,
      @TimestampConverter() DateTime startDate,
      @TimestampConverter() DateTime endDate,
      @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class _$SavingModelCopyWithImpl<$Res, $Val extends SavingModel>
    implements $SavingModelCopyWith<$Res> {
  _$SavingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? category = null,
    Object? frequency = null,
    Object? savingAdviceAmount = null,
    Object? currentSaving = freezed,
    Object? savingTarget = freezed,
    Object? id = freezed,
    Object? documentSnapshot = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      savingAdviceAmount: null == savingAdviceAmount
          ? _value.savingAdviceAmount
          : savingAdviceAmount // ignore: cast_nullable_to_non_nullable
              as double,
      currentSaving: freezed == currentSaving
          ? _value.currentSaving
          : currentSaving // ignore: cast_nullable_to_non_nullable
              as dynamic,
      savingTarget: freezed == savingTarget
          ? _value.savingTarget
          : savingTarget // ignore: cast_nullable_to_non_nullable
              as dynamic,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      documentSnapshot: freezed == documentSnapshot
          ? _value.documentSnapshot
          : documentSnapshot // ignore: cast_nullable_to_non_nullable
              as DocumentSnapshot<Object?>?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SavingModelCopyWith<$Res>
    implements $SavingModelCopyWith<$Res> {
  factory _$$_SavingModelCopyWith(
          _$_SavingModel value, $Res Function(_$_SavingModel) then) =
      __$$_SavingModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String category,
      String frequency,
      double savingAdviceAmount,
      dynamic currentSaving,
      dynamic savingTarget,
      @JsonKey(includeFromJson: false, includeToJson: false) String? id,
      @JsonKey(includeFromJson: false, includeToJson: false)
      DocumentSnapshot<Object?>? documentSnapshot,
      @TimestampConverter() DateTime startDate,
      @TimestampConverter() DateTime endDate,
      @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class __$$_SavingModelCopyWithImpl<$Res>
    extends _$SavingModelCopyWithImpl<$Res, _$_SavingModel>
    implements _$$_SavingModelCopyWith<$Res> {
  __$$_SavingModelCopyWithImpl(
      _$_SavingModel _value, $Res Function(_$_SavingModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? category = null,
    Object? frequency = null,
    Object? savingAdviceAmount = null,
    Object? currentSaving = freezed,
    Object? savingTarget = freezed,
    Object? id = freezed,
    Object? documentSnapshot = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? createdAt = null,
  }) {
    return _then(_$_SavingModel(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      savingAdviceAmount: null == savingAdviceAmount
          ? _value.savingAdviceAmount
          : savingAdviceAmount // ignore: cast_nullable_to_non_nullable
              as double,
      currentSaving: freezed == currentSaving
          ? _value.currentSaving
          : currentSaving // ignore: cast_nullable_to_non_nullable
              as dynamic,
      savingTarget: freezed == savingTarget
          ? _value.savingTarget
          : savingTarget // ignore: cast_nullable_to_non_nullable
              as dynamic,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      documentSnapshot: freezed == documentSnapshot
          ? _value.documentSnapshot
          : documentSnapshot // ignore: cast_nullable_to_non_nullable
              as DocumentSnapshot<Object?>?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SavingModel implements _SavingModel {
  const _$_SavingModel(
      {required this.title,
      required this.category,
      required this.frequency,
      required this.savingAdviceAmount,
      required this.currentSaving,
      required this.savingTarget,
      @JsonKey(includeFromJson: false, includeToJson: false) this.id,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.documentSnapshot,
      @TimestampConverter() required this.startDate,
      @TimestampConverter() required this.endDate,
      @TimestampConverter() required this.createdAt});

  factory _$_SavingModel.fromJson(Map<String, dynamic> json) =>
      _$$_SavingModelFromJson(json);

  @override
  final String title;
  @override
  final String category;
  @override
  final String frequency;
  @override
  final double savingAdviceAmount;
  @override
  final dynamic currentSaving;
  @override
  final dynamic savingTarget;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? id;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final DocumentSnapshot<Object?>? documentSnapshot;
  @override
  @TimestampConverter()
  final DateTime startDate;
  @override
  @TimestampConverter()
  final DateTime endDate;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'SavingModel(title: $title, category: $category, frequency: $frequency, savingAdviceAmount: $savingAdviceAmount, currentSaving: $currentSaving, savingTarget: $savingTarget, id: $id, documentSnapshot: $documentSnapshot, startDate: $startDate, endDate: $endDate, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SavingModel &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.savingAdviceAmount, savingAdviceAmount) ||
                other.savingAdviceAmount == savingAdviceAmount) &&
            const DeepCollectionEquality()
                .equals(other.currentSaving, currentSaving) &&
            const DeepCollectionEquality()
                .equals(other.savingTarget, savingTarget) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.documentSnapshot, documentSnapshot) ||
                other.documentSnapshot == documentSnapshot) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      category,
      frequency,
      savingAdviceAmount,
      const DeepCollectionEquality().hash(currentSaving),
      const DeepCollectionEquality().hash(savingTarget),
      id,
      documentSnapshot,
      startDate,
      endDate,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SavingModelCopyWith<_$_SavingModel> get copyWith =>
      __$$_SavingModelCopyWithImpl<_$_SavingModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SavingModelToJson(
      this,
    );
  }
}

abstract class _SavingModel implements SavingModel {
  const factory _SavingModel(
      {required final String title,
      required final String category,
      required final String frequency,
      required final double savingAdviceAmount,
      required final dynamic currentSaving,
      required final dynamic savingTarget,
      @JsonKey(includeFromJson: false, includeToJson: false) final String? id,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final DocumentSnapshot<Object?>? documentSnapshot,
      @TimestampConverter() required final DateTime startDate,
      @TimestampConverter() required final DateTime endDate,
      @TimestampConverter()
      required final DateTime createdAt}) = _$_SavingModel;

  factory _SavingModel.fromJson(Map<String, dynamic> json) =
      _$_SavingModel.fromJson;

  @override
  String get title;
  @override
  String get category;
  @override
  String get frequency;
  @override
  double get savingAdviceAmount;
  @override
  dynamic get currentSaving;
  @override
  dynamic get savingTarget;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get id;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentSnapshot<Object?>? get documentSnapshot;
  @override
  @TimestampConverter()
  DateTime get startDate;
  @override
  @TimestampConverter()
  DateTime get endDate;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_SavingModelCopyWith<_$_SavingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

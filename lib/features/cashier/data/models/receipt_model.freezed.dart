// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receipt_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ReceiptModel _$ReceiptModelFromJson(Map<String, dynamic> json) {
  return _ReceiptModel.fromJson(json);
}

/// @nodoc
mixin _$ReceiptModel {
  String get receiptNumber => throw _privateConstructorUsedError;
  String get orderId => throw _privateConstructorUsedError;
  String get paymentId => throw _privateConstructorUsedError;
  DateTime get issuedAt => throw _privateConstructorUsedError;
  double get subtotal => throw _privateConstructorUsedError;
  double get tax => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;

  /// Serializes this ReceiptModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReceiptModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReceiptModelCopyWith<ReceiptModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceiptModelCopyWith<$Res> {
  factory $ReceiptModelCopyWith(
    ReceiptModel value,
    $Res Function(ReceiptModel) then,
  ) = _$ReceiptModelCopyWithImpl<$Res, ReceiptModel>;
  @useResult
  $Res call({
    String receiptNumber,
    String orderId,
    String paymentId,
    DateTime issuedAt,
    double subtotal,
    double tax,
    double total,
  });
}

/// @nodoc
class _$ReceiptModelCopyWithImpl<$Res, $Val extends ReceiptModel>
    implements $ReceiptModelCopyWith<$Res> {
  _$ReceiptModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReceiptModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? receiptNumber = null,
    Object? orderId = null,
    Object? paymentId = null,
    Object? issuedAt = null,
    Object? subtotal = null,
    Object? tax = null,
    Object? total = null,
  }) {
    return _then(
      _value.copyWith(
            receiptNumber: null == receiptNumber
                ? _value.receiptNumber
                : receiptNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            orderId: null == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentId: null == paymentId
                ? _value.paymentId
                : paymentId // ignore: cast_nullable_to_non_nullable
                      as String,
            issuedAt: null == issuedAt
                ? _value.issuedAt
                : issuedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            subtotal: null == subtotal
                ? _value.subtotal
                : subtotal // ignore: cast_nullable_to_non_nullable
                      as double,
            tax: null == tax
                ? _value.tax
                : tax // ignore: cast_nullable_to_non_nullable
                      as double,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReceiptModelImplCopyWith<$Res>
    implements $ReceiptModelCopyWith<$Res> {
  factory _$$ReceiptModelImplCopyWith(
    _$ReceiptModelImpl value,
    $Res Function(_$ReceiptModelImpl) then,
  ) = __$$ReceiptModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String receiptNumber,
    String orderId,
    String paymentId,
    DateTime issuedAt,
    double subtotal,
    double tax,
    double total,
  });
}

/// @nodoc
class __$$ReceiptModelImplCopyWithImpl<$Res>
    extends _$ReceiptModelCopyWithImpl<$Res, _$ReceiptModelImpl>
    implements _$$ReceiptModelImplCopyWith<$Res> {
  __$$ReceiptModelImplCopyWithImpl(
    _$ReceiptModelImpl _value,
    $Res Function(_$ReceiptModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReceiptModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? receiptNumber = null,
    Object? orderId = null,
    Object? paymentId = null,
    Object? issuedAt = null,
    Object? subtotal = null,
    Object? tax = null,
    Object? total = null,
  }) {
    return _then(
      _$ReceiptModelImpl(
        receiptNumber: null == receiptNumber
            ? _value.receiptNumber
            : receiptNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentId: null == paymentId
            ? _value.paymentId
            : paymentId // ignore: cast_nullable_to_non_nullable
                  as String,
        issuedAt: null == issuedAt
            ? _value.issuedAt
            : issuedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        subtotal: null == subtotal
            ? _value.subtotal
            : subtotal // ignore: cast_nullable_to_non_nullable
                  as double,
        tax: null == tax
            ? _value.tax
            : tax // ignore: cast_nullable_to_non_nullable
                  as double,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReceiptModelImpl extends _ReceiptModel {
  const _$ReceiptModelImpl({
    required this.receiptNumber,
    required this.orderId,
    required this.paymentId,
    required this.issuedAt,
    required this.subtotal,
    required this.tax,
    required this.total,
  }) : super._();

  factory _$ReceiptModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReceiptModelImplFromJson(json);

  @override
  final String receiptNumber;
  @override
  final String orderId;
  @override
  final String paymentId;
  @override
  final DateTime issuedAt;
  @override
  final double subtotal;
  @override
  final double tax;
  @override
  final double total;

  @override
  String toString() {
    return 'ReceiptModel(receiptNumber: $receiptNumber, orderId: $orderId, paymentId: $paymentId, issuedAt: $issuedAt, subtotal: $subtotal, tax: $tax, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceiptModelImpl &&
            (identical(other.receiptNumber, receiptNumber) ||
                other.receiptNumber == receiptNumber) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    receiptNumber,
    orderId,
    paymentId,
    issuedAt,
    subtotal,
    tax,
    total,
  );

  /// Create a copy of ReceiptModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceiptModelImplCopyWith<_$ReceiptModelImpl> get copyWith =>
      __$$ReceiptModelImplCopyWithImpl<_$ReceiptModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReceiptModelImplToJson(this);
  }
}

abstract class _ReceiptModel extends ReceiptModel {
  const factory _ReceiptModel({
    required final String receiptNumber,
    required final String orderId,
    required final String paymentId,
    required final DateTime issuedAt,
    required final double subtotal,
    required final double tax,
    required final double total,
  }) = _$ReceiptModelImpl;
  const _ReceiptModel._() : super._();

  factory _ReceiptModel.fromJson(Map<String, dynamic> json) =
      _$ReceiptModelImpl.fromJson;

  @override
  String get receiptNumber;
  @override
  String get orderId;
  @override
  String get paymentId;
  @override
  DateTime get issuedAt;
  @override
  double get subtotal;
  @override
  double get tax;
  @override
  double get total;

  /// Create a copy of ReceiptModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReceiptModelImplCopyWith<_$ReceiptModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

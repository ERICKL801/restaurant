// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_movement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StockMovementModel _$StockMovementModelFromJson(Map<String, dynamic> json) {
  return _StockMovementModel.fromJson(json);
}

/// @nodoc
mixin _$StockMovementModel {
  String get id => throw _privateConstructorUsedError;
  String get inventoryItemId => throw _privateConstructorUsedError;
  MovementType get movementType => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double get previousStock => throw _privateConstructorUsedError;
  double get currentStock => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;

  /// Serializes this StockMovementModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StockMovementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StockMovementModelCopyWith<StockMovementModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockMovementModelCopyWith<$Res> {
  factory $StockMovementModelCopyWith(
    StockMovementModel value,
    $Res Function(StockMovementModel) then,
  ) = _$StockMovementModelCopyWithImpl<$Res, StockMovementModel>;
  @useResult
  $Res call({
    String id,
    String inventoryItemId,
    MovementType movementType,
    double quantity,
    double previousStock,
    double currentStock,
    DateTime createdAt,
    String note,
  });
}

/// @nodoc
class _$StockMovementModelCopyWithImpl<$Res, $Val extends StockMovementModel>
    implements $StockMovementModelCopyWith<$Res> {
  _$StockMovementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StockMovementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? inventoryItemId = null,
    Object? movementType = null,
    Object? quantity = null,
    Object? previousStock = null,
    Object? currentStock = null,
    Object? createdAt = null,
    Object? note = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            inventoryItemId: null == inventoryItemId
                ? _value.inventoryItemId
                : inventoryItemId // ignore: cast_nullable_to_non_nullable
                      as String,
            movementType: null == movementType
                ? _value.movementType
                : movementType // ignore: cast_nullable_to_non_nullable
                      as MovementType,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as double,
            previousStock: null == previousStock
                ? _value.previousStock
                : previousStock // ignore: cast_nullable_to_non_nullable
                      as double,
            currentStock: null == currentStock
                ? _value.currentStock
                : currentStock // ignore: cast_nullable_to_non_nullable
                      as double,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            note: null == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StockMovementModelImplCopyWith<$Res>
    implements $StockMovementModelCopyWith<$Res> {
  factory _$$StockMovementModelImplCopyWith(
    _$StockMovementModelImpl value,
    $Res Function(_$StockMovementModelImpl) then,
  ) = __$$StockMovementModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String inventoryItemId,
    MovementType movementType,
    double quantity,
    double previousStock,
    double currentStock,
    DateTime createdAt,
    String note,
  });
}

/// @nodoc
class __$$StockMovementModelImplCopyWithImpl<$Res>
    extends _$StockMovementModelCopyWithImpl<$Res, _$StockMovementModelImpl>
    implements _$$StockMovementModelImplCopyWith<$Res> {
  __$$StockMovementModelImplCopyWithImpl(
    _$StockMovementModelImpl _value,
    $Res Function(_$StockMovementModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StockMovementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? inventoryItemId = null,
    Object? movementType = null,
    Object? quantity = null,
    Object? previousStock = null,
    Object? currentStock = null,
    Object? createdAt = null,
    Object? note = null,
  }) {
    return _then(
      _$StockMovementModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        inventoryItemId: null == inventoryItemId
            ? _value.inventoryItemId
            : inventoryItemId // ignore: cast_nullable_to_non_nullable
                  as String,
        movementType: null == movementType
            ? _value.movementType
            : movementType // ignore: cast_nullable_to_non_nullable
                  as MovementType,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as double,
        previousStock: null == previousStock
            ? _value.previousStock
            : previousStock // ignore: cast_nullable_to_non_nullable
                  as double,
        currentStock: null == currentStock
            ? _value.currentStock
            : currentStock // ignore: cast_nullable_to_non_nullable
                  as double,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        note: null == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StockMovementModelImpl extends _StockMovementModel {
  const _$StockMovementModelImpl({
    required this.id,
    required this.inventoryItemId,
    required this.movementType,
    required this.quantity,
    this.previousStock = 0.0,
    this.currentStock = 0.0,
    required this.createdAt,
    this.note = '',
  }) : super._();

  factory _$StockMovementModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockMovementModelImplFromJson(json);

  @override
  final String id;
  @override
  final String inventoryItemId;
  @override
  final MovementType movementType;
  @override
  final double quantity;
  @override
  @JsonKey()
  final double previousStock;
  @override
  @JsonKey()
  final double currentStock;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final String note;

  @override
  String toString() {
    return 'StockMovementModel(id: $id, inventoryItemId: $inventoryItemId, movementType: $movementType, quantity: $quantity, previousStock: $previousStock, currentStock: $currentStock, createdAt: $createdAt, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockMovementModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.inventoryItemId, inventoryItemId) ||
                other.inventoryItemId == inventoryItemId) &&
            (identical(other.movementType, movementType) ||
                other.movementType == movementType) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.previousStock, previousStock) ||
                other.previousStock == previousStock) &&
            (identical(other.currentStock, currentStock) ||
                other.currentStock == currentStock) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    inventoryItemId,
    movementType,
    quantity,
    previousStock,
    currentStock,
    createdAt,
    note,
  );

  /// Create a copy of StockMovementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StockMovementModelImplCopyWith<_$StockMovementModelImpl> get copyWith =>
      __$$StockMovementModelImplCopyWithImpl<_$StockMovementModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StockMovementModelImplToJson(this);
  }
}

abstract class _StockMovementModel extends StockMovementModel {
  const factory _StockMovementModel({
    required final String id,
    required final String inventoryItemId,
    required final MovementType movementType,
    required final double quantity,
    final double previousStock,
    final double currentStock,
    required final DateTime createdAt,
    final String note,
  }) = _$StockMovementModelImpl;
  const _StockMovementModel._() : super._();

  factory _StockMovementModel.fromJson(Map<String, dynamic> json) =
      _$StockMovementModelImpl.fromJson;

  @override
  String get id;
  @override
  String get inventoryItemId;
  @override
  MovementType get movementType;
  @override
  double get quantity;
  @override
  double get previousStock;
  @override
  double get currentStock;
  @override
  DateTime get createdAt;
  @override
  String get note;

  /// Create a copy of StockMovementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockMovementModelImplCopyWith<_$StockMovementModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

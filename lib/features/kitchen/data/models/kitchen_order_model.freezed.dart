// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kitchen_order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

KitchenOrderModel _$KitchenOrderModelFromJson(Map<String, dynamic> json) {
  return _KitchenOrderModel.fromJson(json);
}

/// @nodoc
mixin _$KitchenOrderModel {
  String get id => throw _privateConstructorUsedError;
  String get tableName => throw _privateConstructorUsedError;
  List<KitchenOrderItemModel> get items => throw _privateConstructorUsedError;
  KitchenOrderStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;

  /// Serializes this KitchenOrderModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KitchenOrderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KitchenOrderModelCopyWith<KitchenOrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KitchenOrderModelCopyWith<$Res> {
  factory $KitchenOrderModelCopyWith(
    KitchenOrderModel value,
    $Res Function(KitchenOrderModel) then,
  ) = _$KitchenOrderModelCopyWithImpl<$Res, KitchenOrderModel>;
  @useResult
  $Res call({
    String id,
    String tableName,
    List<KitchenOrderItemModel> items,
    KitchenOrderStatus status,
    DateTime createdAt,
    String? notes,
    double total,
  });
}

/// @nodoc
class _$KitchenOrderModelCopyWithImpl<$Res, $Val extends KitchenOrderModel>
    implements $KitchenOrderModelCopyWith<$Res> {
  _$KitchenOrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KitchenOrderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tableName = null,
    Object? items = null,
    Object? status = null,
    Object? createdAt = null,
    Object? notes = freezed,
    Object? total = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            tableName: null == tableName
                ? _value.tableName
                : tableName // ignore: cast_nullable_to_non_nullable
                      as String,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<KitchenOrderItemModel>,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as KitchenOrderStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$KitchenOrderModelImplCopyWith<$Res>
    implements $KitchenOrderModelCopyWith<$Res> {
  factory _$$KitchenOrderModelImplCopyWith(
    _$KitchenOrderModelImpl value,
    $Res Function(_$KitchenOrderModelImpl) then,
  ) = __$$KitchenOrderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String tableName,
    List<KitchenOrderItemModel> items,
    KitchenOrderStatus status,
    DateTime createdAt,
    String? notes,
    double total,
  });
}

/// @nodoc
class __$$KitchenOrderModelImplCopyWithImpl<$Res>
    extends _$KitchenOrderModelCopyWithImpl<$Res, _$KitchenOrderModelImpl>
    implements _$$KitchenOrderModelImplCopyWith<$Res> {
  __$$KitchenOrderModelImplCopyWithImpl(
    _$KitchenOrderModelImpl _value,
    $Res Function(_$KitchenOrderModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of KitchenOrderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tableName = null,
    Object? items = null,
    Object? status = null,
    Object? createdAt = null,
    Object? notes = freezed,
    Object? total = null,
  }) {
    return _then(
      _$KitchenOrderModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        tableName: null == tableName
            ? _value.tableName
            : tableName // ignore: cast_nullable_to_non_nullable
                  as String,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<KitchenOrderItemModel>,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as KitchenOrderStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$KitchenOrderModelImpl extends _KitchenOrderModel {
  const _$KitchenOrderModelImpl({
    required this.id,
    required this.tableName,
    final List<KitchenOrderItemModel> items = const [],
    required this.status,
    required this.createdAt,
    this.notes,
    required this.total,
  }) : _items = items,
       super._();

  factory _$KitchenOrderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$KitchenOrderModelImplFromJson(json);

  @override
  final String id;
  @override
  final String tableName;
  final List<KitchenOrderItemModel> _items;
  @override
  @JsonKey()
  List<KitchenOrderItemModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final KitchenOrderStatus status;
  @override
  final DateTime createdAt;
  @override
  final String? notes;
  @override
  final double total;

  @override
  String toString() {
    return 'KitchenOrderModel(id: $id, tableName: $tableName, items: $items, status: $status, createdAt: $createdAt, notes: $notes, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KitchenOrderModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tableName, tableName) ||
                other.tableName == tableName) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    tableName,
    const DeepCollectionEquality().hash(_items),
    status,
    createdAt,
    notes,
    total,
  );

  /// Create a copy of KitchenOrderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KitchenOrderModelImplCopyWith<_$KitchenOrderModelImpl> get copyWith =>
      __$$KitchenOrderModelImplCopyWithImpl<_$KitchenOrderModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$KitchenOrderModelImplToJson(this);
  }
}

abstract class _KitchenOrderModel extends KitchenOrderModel {
  const factory _KitchenOrderModel({
    required final String id,
    required final String tableName,
    final List<KitchenOrderItemModel> items,
    required final KitchenOrderStatus status,
    required final DateTime createdAt,
    final String? notes,
    required final double total,
  }) = _$KitchenOrderModelImpl;
  const _KitchenOrderModel._() : super._();

  factory _KitchenOrderModel.fromJson(Map<String, dynamic> json) =
      _$KitchenOrderModelImpl.fromJson;

  @override
  String get id;
  @override
  String get tableName;
  @override
  List<KitchenOrderItemModel> get items;
  @override
  KitchenOrderStatus get status;
  @override
  DateTime get createdAt;
  @override
  String? get notes;
  @override
  double get total;

  /// Create a copy of KitchenOrderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KitchenOrderModelImplCopyWith<_$KitchenOrderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

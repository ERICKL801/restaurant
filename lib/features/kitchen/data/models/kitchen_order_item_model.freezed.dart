// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kitchen_order_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

KitchenOrderItemModel _$KitchenOrderItemModelFromJson(
  Map<String, dynamic> json,
) {
  return _KitchenOrderItemModel.fromJson(json);
}

/// @nodoc
mixin _$KitchenOrderItemModel {
  String get name => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;

  /// Serializes this KitchenOrderItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KitchenOrderItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KitchenOrderItemModelCopyWith<KitchenOrderItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KitchenOrderItemModelCopyWith<$Res> {
  factory $KitchenOrderItemModelCopyWith(
    KitchenOrderItemModel value,
    $Res Function(KitchenOrderItemModel) then,
  ) = _$KitchenOrderItemModelCopyWithImpl<$Res, KitchenOrderItemModel>;
  @useResult
  $Res call({String name, int quantity, String note});
}

/// @nodoc
class _$KitchenOrderItemModelCopyWithImpl<
  $Res,
  $Val extends KitchenOrderItemModel
>
    implements $KitchenOrderItemModelCopyWith<$Res> {
  _$KitchenOrderItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KitchenOrderItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? quantity = null,
    Object? note = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$KitchenOrderItemModelImplCopyWith<$Res>
    implements $KitchenOrderItemModelCopyWith<$Res> {
  factory _$$KitchenOrderItemModelImplCopyWith(
    _$KitchenOrderItemModelImpl value,
    $Res Function(_$KitchenOrderItemModelImpl) then,
  ) = __$$KitchenOrderItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int quantity, String note});
}

/// @nodoc
class __$$KitchenOrderItemModelImplCopyWithImpl<$Res>
    extends
        _$KitchenOrderItemModelCopyWithImpl<$Res, _$KitchenOrderItemModelImpl>
    implements _$$KitchenOrderItemModelImplCopyWith<$Res> {
  __$$KitchenOrderItemModelImplCopyWithImpl(
    _$KitchenOrderItemModelImpl _value,
    $Res Function(_$KitchenOrderItemModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of KitchenOrderItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? quantity = null,
    Object? note = null,
  }) {
    return _then(
      _$KitchenOrderItemModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$KitchenOrderItemModelImpl extends _KitchenOrderItemModel {
  const _$KitchenOrderItemModelImpl({
    required this.name,
    this.quantity = 1,
    this.note = '',
  }) : super._();

  factory _$KitchenOrderItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$KitchenOrderItemModelImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey()
  final int quantity;
  @override
  @JsonKey()
  final String note;

  @override
  String toString() {
    return 'KitchenOrderItemModel(name: $name, quantity: $quantity, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KitchenOrderItemModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, quantity, note);

  /// Create a copy of KitchenOrderItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KitchenOrderItemModelImplCopyWith<_$KitchenOrderItemModelImpl>
  get copyWith =>
      __$$KitchenOrderItemModelImplCopyWithImpl<_$KitchenOrderItemModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$KitchenOrderItemModelImplToJson(this);
  }
}

abstract class _KitchenOrderItemModel extends KitchenOrderItemModel {
  const factory _KitchenOrderItemModel({
    required final String name,
    final int quantity,
    final String note,
  }) = _$KitchenOrderItemModelImpl;
  const _KitchenOrderItemModel._() : super._();

  factory _KitchenOrderItemModel.fromJson(Map<String, dynamic> json) =
      _$KitchenOrderItemModelImpl.fromJson;

  @override
  String get name;
  @override
  int get quantity;
  @override
  String get note;

  /// Create a copy of KitchenOrderItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KitchenOrderItemModelImplCopyWith<_$KitchenOrderItemModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

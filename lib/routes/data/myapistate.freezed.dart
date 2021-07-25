// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'myapistate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MyApiState _$MyApiStateFromJson(Map<String, dynamic> json) {
  return _MyApiState.fromJson(json);
}

/// @nodoc
class _$MyApiStateTearOff {
  const _$MyApiStateTearOff();

  _MyApiState call() {
    return _MyApiState();
  }

  MyApiState fromJson(Map<String, Object> json) {
    return MyApiState.fromJson(json);
  }
}

/// @nodoc
const $MyApiState = _$MyApiStateTearOff();

/// @nodoc
mixin _$MyApiState {
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyApiStateCopyWith<$Res> {
  factory $MyApiStateCopyWith(
          MyApiState value, $Res Function(MyApiState) then) =
      _$MyApiStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$MyApiStateCopyWithImpl<$Res> implements $MyApiStateCopyWith<$Res> {
  _$MyApiStateCopyWithImpl(this._value, this._then);

  final MyApiState _value;
  // ignore: unused_field
  final $Res Function(MyApiState) _then;
}

/// @nodoc
abstract class _$MyApiStateCopyWith<$Res> {
  factory _$MyApiStateCopyWith(
          _MyApiState value, $Res Function(_MyApiState) then) =
      __$MyApiStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$MyApiStateCopyWithImpl<$Res> extends _$MyApiStateCopyWithImpl<$Res>
    implements _$MyApiStateCopyWith<$Res> {
  __$MyApiStateCopyWithImpl(
      _MyApiState _value, $Res Function(_MyApiState) _then)
      : super(_value, (v) => _then(v as _MyApiState));

  @override
  _MyApiState get _value => super._value as _MyApiState;
}

/// @nodoc
@JsonSerializable()
class _$_MyApiState implements _MyApiState {
  _$_MyApiState();

  factory _$_MyApiState.fromJson(Map<String, dynamic> json) =>
      _$_$_MyApiStateFromJson(json);

  @override
  String toString() {
    return 'MyApiState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _MyApiState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MyApiStateToJson(this);
  }
}

abstract class _MyApiState implements MyApiState {
  factory _MyApiState() = _$_MyApiState;

  factory _MyApiState.fromJson(Map<String, dynamic> json) =
      _$_MyApiState.fromJson;
}

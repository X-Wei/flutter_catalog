// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'my_api_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$MyApiStateTearOff {
  const _$MyApiStateTearOff();

// ignore: unused_element
  _Success success(List<String> data) {
    return _Success(
      data,
    );
  }

// ignore: unused_element
  _Error error(String errorMsg) {
    return _Error(
      errorMsg,
    );
  }

// ignore: unused_element
  _Loading loading() {
    return _Loading();
  }
}

/// @nodoc
// ignore: unused_element
const $MyApiState = _$MyApiStateTearOff();

/// @nodoc
mixin _$MyApiState {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult success(List<String> data),
    @required TResult error(String errorMsg),
    @required TResult loading(),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult success(List<String> data),
    TResult error(String errorMsg),
    TResult loading(),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult success(_Success value),
    @required TResult error(_Error value),
    @required TResult loading(_Loading value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult success(_Success value),
    TResult error(_Error value),
    TResult loading(_Loading value),
    @required TResult orElse(),
  });
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
abstract class _$SuccessCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) then) =
      __$SuccessCopyWithImpl<$Res>;
  $Res call({List<String> data});
}

/// @nodoc
class __$SuccessCopyWithImpl<$Res> extends _$MyApiStateCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(_Success _value, $Res Function(_Success) _then)
      : super(_value, (v) => _then(v as _Success));

  @override
  _Success get _value => super._value as _Success;

  @override
  $Res call({
    Object data = freezed,
  }) {
    return _then(_Success(
      data == freezed ? _value.data : data as List<String>,
    ));
  }
}

/// @nodoc
class _$_Success implements _Success {
  _$_Success(this.data) : assert(data != null);

  @override
  final List<String> data;

  @override
  String toString() {
    return 'MyApiState.success(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Success &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  _$SuccessCopyWith<_Success> get copyWith =>
      __$SuccessCopyWithImpl<_Success>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult success(List<String> data),
    @required TResult error(String errorMsg),
    @required TResult loading(),
  }) {
    assert(success != null);
    assert(error != null);
    assert(loading != null);
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult success(List<String> data),
    TResult error(String errorMsg),
    TResult loading(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult success(_Success value),
    @required TResult error(_Error value),
    @required TResult loading(_Loading value),
  }) {
    assert(success != null);
    assert(error != null);
    assert(loading != null);
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult success(_Success value),
    TResult error(_Error value),
    TResult loading(_Loading value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements MyApiState {
  factory _Success(List<String> data) = _$_Success;

  List<String> get data;
  @JsonKey(ignore: true)
  _$SuccessCopyWith<_Success> get copyWith;
}

/// @nodoc
abstract class _$ErrorCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) then) =
      __$ErrorCopyWithImpl<$Res>;
  $Res call({String errorMsg});
}

/// @nodoc
class __$ErrorCopyWithImpl<$Res> extends _$MyApiStateCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(_Error _value, $Res Function(_Error) _then)
      : super(_value, (v) => _then(v as _Error));

  @override
  _Error get _value => super._value as _Error;

  @override
  $Res call({
    Object errorMsg = freezed,
  }) {
    return _then(_Error(
      errorMsg == freezed ? _value.errorMsg : errorMsg as String,
    ));
  }
}

/// @nodoc
class _$_Error implements _Error {
  _$_Error(this.errorMsg) : assert(errorMsg != null);

  @override
  final String errorMsg;

  @override
  String toString() {
    return 'MyApiState.error(errorMsg: $errorMsg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Error &&
            (identical(other.errorMsg, errorMsg) ||
                const DeepCollectionEquality()
                    .equals(other.errorMsg, errorMsg)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(errorMsg);

  @JsonKey(ignore: true)
  @override
  _$ErrorCopyWith<_Error> get copyWith =>
      __$ErrorCopyWithImpl<_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult success(List<String> data),
    @required TResult error(String errorMsg),
    @required TResult loading(),
  }) {
    assert(success != null);
    assert(error != null);
    assert(loading != null);
    return error(errorMsg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult success(List<String> data),
    TResult error(String errorMsg),
    TResult loading(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(errorMsg);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult success(_Success value),
    @required TResult error(_Error value),
    @required TResult loading(_Loading value),
  }) {
    assert(success != null);
    assert(error != null);
    assert(loading != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult success(_Success value),
    TResult error(_Error value),
    TResult loading(_Loading value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements MyApiState {
  factory _Error(String errorMsg) = _$_Error;

  String get errorMsg;
  @JsonKey(ignore: true)
  _$ErrorCopyWith<_Error> get copyWith;
}

/// @nodoc
abstract class _$LoadingCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res> extends _$MyApiStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;
}

/// @nodoc
class _$_Loading implements _Loading {
  _$_Loading();

  @override
  String toString() {
    return 'MyApiState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult success(List<String> data),
    @required TResult error(String errorMsg),
    @required TResult loading(),
  }) {
    assert(success != null);
    assert(error != null);
    assert(loading != null);
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult success(List<String> data),
    TResult error(String errorMsg),
    TResult loading(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult success(_Success value),
    @required TResult error(_Error value),
    @required TResult loading(_Loading value),
  }) {
    assert(success != null);
    assert(error != null);
    assert(loading != null);
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult success(_Success value),
    TResult error(_Error value),
    TResult loading(_Loading value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements MyApiState {
  factory _Loading() = _$_Loading;
}

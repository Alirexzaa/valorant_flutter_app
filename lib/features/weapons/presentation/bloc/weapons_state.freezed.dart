// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weapons_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WeaponsState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is WeaponsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'WeaponsState()';
}


}

/// @nodoc
class $WeaponsStateCopyWith<$Res>  {
$WeaponsStateCopyWith(WeaponsState _, $Res Function(WeaponsState) __);
}


/// Adds pattern-matching-related methods to [WeaponsState].
extension WeaponsStatePatterns on WeaponsState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WeaponsInitial value)?  initial,TResult Function( WeaponsLoading value)?  loading,TResult Function( WeaponsSuccess value)?  success,TResult Function( WeaponsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WeaponsInitial() when initial != null:
return initial(_that);case WeaponsLoading() when loading != null:
return loading(_that);case WeaponsSuccess() when success != null:
return success(_that);case WeaponsError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WeaponsInitial value)  initial,required TResult Function( WeaponsLoading value)  loading,required TResult Function( WeaponsSuccess value)  success,required TResult Function( WeaponsError value)  error,}){
final _that = this;
switch (_that) {
case WeaponsInitial():
return initial(_that);case WeaponsLoading():
return loading(_that);case WeaponsSuccess():
return success(_that);case WeaponsError():
return error(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WeaponsInitial value)?  initial,TResult? Function( WeaponsLoading value)?  loading,TResult? Function( WeaponsSuccess value)?  success,TResult? Function( WeaponsError value)?  error,}){
final _that = this;
switch (_that) {
case WeaponsInitial() when initial != null:
return initial(_that);case WeaponsLoading() when loading != null:
return loading(_that);case WeaponsSuccess() when success != null:
return success(_that);case WeaponsError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Weapon> weapons)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WeaponsInitial() when initial != null:
return initial();case WeaponsLoading() when loading != null:
return loading();case WeaponsSuccess() when success != null:
return success(_that.weapons);case WeaponsError() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Weapon> weapons)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case WeaponsInitial():
return initial();case WeaponsLoading():
return loading();case WeaponsSuccess():
return success(_that.weapons);case WeaponsError():
return error(_that.message);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Weapon> weapons)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case WeaponsInitial() when initial != null:
return initial();case WeaponsLoading() when loading != null:
return loading();case WeaponsSuccess() when success != null:
return success(_that.weapons);case WeaponsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class WeaponsInitial implements WeaponsState {
  const WeaponsInitial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is WeaponsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'WeaponsState.initial()';
}


}




/// @nodoc


class WeaponsLoading implements WeaponsState {
  const WeaponsLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is WeaponsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'WeaponsState.loading()';
}


}




/// @nodoc


class WeaponsSuccess implements WeaponsState {
  const WeaponsSuccess( List<Weapon> weapons): _weapons = weapons;
  

 final  List<Weapon> _weapons;
 List<Weapon> get weapons {
  if (_weapons is EqualUnmodifiableListView) return _weapons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weapons);
}


/// Create a copy of WeaponsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeaponsSuccessCopyWith<WeaponsSuccess> get copyWith => _$WeaponsSuccessCopyWithImpl<WeaponsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is WeaponsSuccess&&const DeepCollectionEquality().equals(other.weapons, _weapons));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_weapons));
}

@override
String toString() {
    return 'WeaponsState.success(weapons: $weapons)';
}


}

/// @nodoc
abstract mixin class $WeaponsSuccessCopyWith<$Res> implements $WeaponsStateCopyWith<$Res> {
  factory $WeaponsSuccessCopyWith(WeaponsSuccess value, $Res Function(WeaponsSuccess) _then) = _$WeaponsSuccessCopyWithImpl;
@useResult
$Res call({
 List<Weapon> weapons
});




}
/// @nodoc
class _$WeaponsSuccessCopyWithImpl<$Res>
    implements $WeaponsSuccessCopyWith<$Res> {
  _$WeaponsSuccessCopyWithImpl(this._self, this._then);

  final WeaponsSuccess _self;
  final $Res Function(WeaponsSuccess) _then;

/// Create a copy of WeaponsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? weapons = null,}) {
  return _then(WeaponsSuccess(
null == weapons ? _self._weapons : weapons // ignore: cast_nullable_to_non_nullable
as List<Weapon>,
  ));
}


}

/// @nodoc


class WeaponsError implements WeaponsState {
  const WeaponsError(this.message);
  

 final  String message;

/// Create a copy of WeaponsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeaponsErrorCopyWith<WeaponsError> get copyWith => _$WeaponsErrorCopyWithImpl<WeaponsError>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is WeaponsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'WeaponsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $WeaponsErrorCopyWith<$Res> implements $WeaponsStateCopyWith<$Res> {
  factory $WeaponsErrorCopyWith(WeaponsError value, $Res Function(WeaponsError) _then) = _$WeaponsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$WeaponsErrorCopyWithImpl<$Res>
    implements $WeaponsErrorCopyWith<$Res> {
  _$WeaponsErrorCopyWithImpl(this._self, this._then);

  final WeaponsError _self;
  final $Res Function(WeaponsError) _then;

/// Create a copy of WeaponsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(WeaponsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

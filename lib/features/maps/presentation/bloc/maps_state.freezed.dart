// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'maps_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MapsState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MapsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'MapsState()';
}


}

/// @nodoc
class $MapsStateCopyWith<$Res>  {
$MapsStateCopyWith(MapsState _, $Res Function(MapsState) __);
}


/// Adds pattern-matching-related methods to [MapsState].
extension MapsStatePatterns on MapsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MapsInitial value)?  initial,TResult Function( MapsLoading value)?  loading,TResult Function( MapsSuccess value)?  success,TResult Function( MapsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MapsInitial() when initial != null:
return initial(_that);case MapsLoading() when loading != null:
return loading(_that);case MapsSuccess() when success != null:
return success(_that);case MapsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MapsInitial value)  initial,required TResult Function( MapsLoading value)  loading,required TResult Function( MapsSuccess value)  success,required TResult Function( MapsError value)  error,}){
final _that = this;
switch (_that) {
case MapsInitial():
return initial(_that);case MapsLoading():
return loading(_that);case MapsSuccess():
return success(_that);case MapsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MapsInitial value)?  initial,TResult? Function( MapsLoading value)?  loading,TResult? Function( MapsSuccess value)?  success,TResult? Function( MapsError value)?  error,}){
final _that = this;
switch (_that) {
case MapsInitial() when initial != null:
return initial(_that);case MapsLoading() when loading != null:
return loading(_that);case MapsSuccess() when success != null:
return success(_that);case MapsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ValorantMap> maps)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MapsInitial() when initial != null:
return initial();case MapsLoading() when loading != null:
return loading();case MapsSuccess() when success != null:
return success(_that.maps);case MapsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ValorantMap> maps)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case MapsInitial():
return initial();case MapsLoading():
return loading();case MapsSuccess():
return success(_that.maps);case MapsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ValorantMap> maps)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case MapsInitial() when initial != null:
return initial();case MapsLoading() when loading != null:
return loading();case MapsSuccess() when success != null:
return success(_that.maps);case MapsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class MapsInitial implements MapsState {
  const MapsInitial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MapsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'MapsState.initial()';
}


}




/// @nodoc


class MapsLoading implements MapsState {
  const MapsLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MapsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'MapsState.loading()';
}


}




/// @nodoc


class MapsSuccess implements MapsState {
  const MapsSuccess( List<ValorantMap> maps): _maps = maps;
  

 final  List<ValorantMap> _maps;
 List<ValorantMap> get maps {
  if (_maps is EqualUnmodifiableListView) return _maps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_maps);
}


/// Create a copy of MapsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapsSuccessCopyWith<MapsSuccess> get copyWith => _$MapsSuccessCopyWithImpl<MapsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MapsSuccess&&const DeepCollectionEquality().equals(other.maps, _maps));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_maps));
}

@override
String toString() {
    return 'MapsState.success(maps: $maps)';
}


}

/// @nodoc
abstract mixin class $MapsSuccessCopyWith<$Res> implements $MapsStateCopyWith<$Res> {
  factory $MapsSuccessCopyWith(MapsSuccess value, $Res Function(MapsSuccess) _then) = _$MapsSuccessCopyWithImpl;
@useResult
$Res call({
 List<ValorantMap> maps
});




}
/// @nodoc
class _$MapsSuccessCopyWithImpl<$Res>
    implements $MapsSuccessCopyWith<$Res> {
  _$MapsSuccessCopyWithImpl(this._self, this._then);

  final MapsSuccess _self;
  final $Res Function(MapsSuccess) _then;

/// Create a copy of MapsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? maps = null,}) {
  return _then(MapsSuccess(
null == maps ? _self._maps : maps // ignore: cast_nullable_to_non_nullable
as List<ValorantMap>,
  ));
}


}

/// @nodoc


class MapsError implements MapsState {
  const MapsError(this.message);
  

 final  String message;

/// Create a copy of MapsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapsErrorCopyWith<MapsError> get copyWith => _$MapsErrorCopyWithImpl<MapsError>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MapsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'MapsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $MapsErrorCopyWith<$Res> implements $MapsStateCopyWith<$Res> {
  factory $MapsErrorCopyWith(MapsError value, $Res Function(MapsError) _then) = _$MapsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$MapsErrorCopyWithImpl<$Res>
    implements $MapsErrorCopyWith<$Res> {
  _$MapsErrorCopyWithImpl(this._self, this._then);

  final MapsError _self;
  final $Res Function(MapsError) _then;

/// Create a copy of MapsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(MapsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

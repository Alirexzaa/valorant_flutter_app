// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agents_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AgentsState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AgentsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AgentsState()';
}


}

/// @nodoc
class $AgentsStateCopyWith<$Res>  {
$AgentsStateCopyWith(AgentsState _, $Res Function(AgentsState) __);
}


/// Adds pattern-matching-related methods to [AgentsState].
extension AgentsStatePatterns on AgentsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AgentsInitial value)?  initial,TResult Function( AgentsLoading value)?  loading,TResult Function( AgentsSuccess value)?  success,TResult Function( AgentsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AgentsInitial() when initial != null:
return initial(_that);case AgentsLoading() when loading != null:
return loading(_that);case AgentsSuccess() when success != null:
return success(_that);case AgentsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AgentsInitial value)  initial,required TResult Function( AgentsLoading value)  loading,required TResult Function( AgentsSuccess value)  success,required TResult Function( AgentsError value)  error,}){
final _that = this;
switch (_that) {
case AgentsInitial():
return initial(_that);case AgentsLoading():
return loading(_that);case AgentsSuccess():
return success(_that);case AgentsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AgentsInitial value)?  initial,TResult? Function( AgentsLoading value)?  loading,TResult? Function( AgentsSuccess value)?  success,TResult? Function( AgentsError value)?  error,}){
final _that = this;
switch (_that) {
case AgentsInitial() when initial != null:
return initial(_that);case AgentsLoading() when loading != null:
return loading(_that);case AgentsSuccess() when success != null:
return success(_that);case AgentsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Agent> agents,  List<String> favoriteIds)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AgentsInitial() when initial != null:
return initial();case AgentsLoading() when loading != null:
return loading();case AgentsSuccess() when success != null:
return success(_that.agents,_that.favoriteIds);case AgentsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Agent> agents,  List<String> favoriteIds)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case AgentsInitial():
return initial();case AgentsLoading():
return loading();case AgentsSuccess():
return success(_that.agents,_that.favoriteIds);case AgentsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Agent> agents,  List<String> favoriteIds)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case AgentsInitial() when initial != null:
return initial();case AgentsLoading() when loading != null:
return loading();case AgentsSuccess() when success != null:
return success(_that.agents,_that.favoriteIds);case AgentsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class AgentsInitial implements AgentsState {
  const AgentsInitial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AgentsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AgentsState.initial()';
}


}




/// @nodoc


class AgentsLoading implements AgentsState {
  const AgentsLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AgentsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AgentsState.loading()';
}


}




/// @nodoc


class AgentsSuccess implements AgentsState {
  const AgentsSuccess( List<Agent> agents,  List<String> favoriteIds): _agents = agents,_favoriteIds = favoriteIds;
  

 final  List<Agent> _agents;
 List<Agent> get agents {
  if (_agents is EqualUnmodifiableListView) return _agents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_agents);
}

 final  List<String> _favoriteIds;
 List<String> get favoriteIds {
  if (_favoriteIds is EqualUnmodifiableListView) return _favoriteIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoriteIds);
}


/// Create a copy of AgentsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgentsSuccessCopyWith<AgentsSuccess> get copyWith => _$AgentsSuccessCopyWithImpl<AgentsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AgentsSuccess&&const DeepCollectionEquality().equals(other.agents, _agents)&&const DeepCollectionEquality().equals(other.favoriteIds, _favoriteIds));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_agents),const DeepCollectionEquality().hash(_favoriteIds));
}

@override
String toString() {
    return 'AgentsState.success(agents: $agents, favoriteIds: $favoriteIds)';
}


}

/// @nodoc
abstract mixin class $AgentsSuccessCopyWith<$Res> implements $AgentsStateCopyWith<$Res> {
  factory $AgentsSuccessCopyWith(AgentsSuccess value, $Res Function(AgentsSuccess) _then) = _$AgentsSuccessCopyWithImpl;
@useResult
$Res call({
 List<Agent> agents, List<String> favoriteIds
});




}
/// @nodoc
class _$AgentsSuccessCopyWithImpl<$Res>
    implements $AgentsSuccessCopyWith<$Res> {
  _$AgentsSuccessCopyWithImpl(this._self, this._then);

  final AgentsSuccess _self;
  final $Res Function(AgentsSuccess) _then;

/// Create a copy of AgentsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? agents = null,Object? favoriteIds = null,}) {
  return _then(AgentsSuccess(
null == agents ? _self._agents : agents // ignore: cast_nullable_to_non_nullable
as List<Agent>,null == favoriteIds ? _self._favoriteIds : favoriteIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class AgentsError implements AgentsState {
  const AgentsError(this.message);
  

 final  String message;

/// Create a copy of AgentsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgentsErrorCopyWith<AgentsError> get copyWith => _$AgentsErrorCopyWithImpl<AgentsError>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AgentsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'AgentsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $AgentsErrorCopyWith<$Res> implements $AgentsStateCopyWith<$Res> {
  factory $AgentsErrorCopyWith(AgentsError value, $Res Function(AgentsError) _then) = _$AgentsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AgentsErrorCopyWithImpl<$Res>
    implements $AgentsErrorCopyWith<$Res> {
  _$AgentsErrorCopyWithImpl(this._self, this._then);

  final AgentsError _self;
  final $Res Function(AgentsError) _then;

/// Create a copy of AgentsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(AgentsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Employer {

 String get uid; String get email; String get name; String get companyName; DateTime get createdAt; String? get companyDescription; String? get website; String? get location; String? get phoneNumber; String? get photoUrl; int? get postedJobs; double? get rating;
/// Create a copy of Employer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployerCopyWith<Employer> get copyWith => _$EmployerCopyWithImpl<Employer>(this as Employer, _$identity);

  /// Serializes this Employer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Employer&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.companyDescription, companyDescription) || other.companyDescription == companyDescription)&&(identical(other.website, website) || other.website == website)&&(identical(other.location, location) || other.location == location)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.postedJobs, postedJobs) || other.postedJobs == postedJobs)&&(identical(other.rating, rating) || other.rating == rating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,email,name,companyName,createdAt,companyDescription,website,location,phoneNumber,photoUrl,postedJobs,rating);

@override
String toString() {
  return 'Employer(uid: $uid, email: $email, name: $name, companyName: $companyName, createdAt: $createdAt, companyDescription: $companyDescription, website: $website, location: $location, phoneNumber: $phoneNumber, photoUrl: $photoUrl, postedJobs: $postedJobs, rating: $rating)';
}


}

/// @nodoc
abstract mixin class $EmployerCopyWith<$Res>  {
  factory $EmployerCopyWith(Employer value, $Res Function(Employer) _then) = _$EmployerCopyWithImpl;
@useResult
$Res call({
 String uid, String email, String name, String companyName, DateTime createdAt, String? companyDescription, String? website, String? location, String? phoneNumber, String? photoUrl, int? postedJobs, double? rating
});




}
/// @nodoc
class _$EmployerCopyWithImpl<$Res>
    implements $EmployerCopyWith<$Res> {
  _$EmployerCopyWithImpl(this._self, this._then);

  final Employer _self;
  final $Res Function(Employer) _then;

/// Create a copy of Employer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? email = null,Object? name = null,Object? companyName = null,Object? createdAt = null,Object? companyDescription = freezed,Object? website = freezed,Object? location = freezed,Object? phoneNumber = freezed,Object? photoUrl = freezed,Object? postedJobs = freezed,Object? rating = freezed,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,companyDescription: freezed == companyDescription ? _self.companyDescription : companyDescription // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,postedJobs: freezed == postedJobs ? _self.postedJobs : postedJobs // ignore: cast_nullable_to_non_nullable
as int?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [Employer].
extension EmployerPatterns on Employer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Employer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Employer() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Employer value)  $default,){
final _that = this;
switch (_that) {
case _Employer():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Employer value)?  $default,){
final _that = this;
switch (_that) {
case _Employer() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String email,  String name,  String companyName,  DateTime createdAt,  String? companyDescription,  String? website,  String? location,  String? phoneNumber,  String? photoUrl,  int? postedJobs,  double? rating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Employer() when $default != null:
return $default(_that.uid,_that.email,_that.name,_that.companyName,_that.createdAt,_that.companyDescription,_that.website,_that.location,_that.phoneNumber,_that.photoUrl,_that.postedJobs,_that.rating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String email,  String name,  String companyName,  DateTime createdAt,  String? companyDescription,  String? website,  String? location,  String? phoneNumber,  String? photoUrl,  int? postedJobs,  double? rating)  $default,) {final _that = this;
switch (_that) {
case _Employer():
return $default(_that.uid,_that.email,_that.name,_that.companyName,_that.createdAt,_that.companyDescription,_that.website,_that.location,_that.phoneNumber,_that.photoUrl,_that.postedJobs,_that.rating);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String email,  String name,  String companyName,  DateTime createdAt,  String? companyDescription,  String? website,  String? location,  String? phoneNumber,  String? photoUrl,  int? postedJobs,  double? rating)?  $default,) {final _that = this;
switch (_that) {
case _Employer() when $default != null:
return $default(_that.uid,_that.email,_that.name,_that.companyName,_that.createdAt,_that.companyDescription,_that.website,_that.location,_that.phoneNumber,_that.photoUrl,_that.postedJobs,_that.rating);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Employer implements Employer {
  const _Employer({required this.uid, required this.email, required this.name, required this.companyName, required this.createdAt, this.companyDescription, this.website, this.location, this.phoneNumber, this.photoUrl, this.postedJobs, this.rating});
  factory _Employer.fromJson(Map<String, dynamic> json) => _$EmployerFromJson(json);

@override final  String uid;
@override final  String email;
@override final  String name;
@override final  String companyName;
@override final  DateTime createdAt;
@override final  String? companyDescription;
@override final  String? website;
@override final  String? location;
@override final  String? phoneNumber;
@override final  String? photoUrl;
@override final  int? postedJobs;
@override final  double? rating;

/// Create a copy of Employer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployerCopyWith<_Employer> get copyWith => __$EmployerCopyWithImpl<_Employer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmployerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Employer&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.companyDescription, companyDescription) || other.companyDescription == companyDescription)&&(identical(other.website, website) || other.website == website)&&(identical(other.location, location) || other.location == location)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.postedJobs, postedJobs) || other.postedJobs == postedJobs)&&(identical(other.rating, rating) || other.rating == rating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,email,name,companyName,createdAt,companyDescription,website,location,phoneNumber,photoUrl,postedJobs,rating);

@override
String toString() {
  return 'Employer(uid: $uid, email: $email, name: $name, companyName: $companyName, createdAt: $createdAt, companyDescription: $companyDescription, website: $website, location: $location, phoneNumber: $phoneNumber, photoUrl: $photoUrl, postedJobs: $postedJobs, rating: $rating)';
}


}

/// @nodoc
abstract mixin class _$EmployerCopyWith<$Res> implements $EmployerCopyWith<$Res> {
  factory _$EmployerCopyWith(_Employer value, $Res Function(_Employer) _then) = __$EmployerCopyWithImpl;
@override @useResult
$Res call({
 String uid, String email, String name, String companyName, DateTime createdAt, String? companyDescription, String? website, String? location, String? phoneNumber, String? photoUrl, int? postedJobs, double? rating
});




}
/// @nodoc
class __$EmployerCopyWithImpl<$Res>
    implements _$EmployerCopyWith<$Res> {
  __$EmployerCopyWithImpl(this._self, this._then);

  final _Employer _self;
  final $Res Function(_Employer) _then;

/// Create a copy of Employer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? email = null,Object? name = null,Object? companyName = null,Object? createdAt = null,Object? companyDescription = freezed,Object? website = freezed,Object? location = freezed,Object? phoneNumber = freezed,Object? photoUrl = freezed,Object? postedJobs = freezed,Object? rating = freezed,}) {
  return _then(_Employer(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,companyDescription: freezed == companyDescription ? _self.companyDescription : companyDescription // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,postedJobs: freezed == postedJobs ? _self.postedJobs : postedJobs // ignore: cast_nullable_to_non_nullable
as int?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on

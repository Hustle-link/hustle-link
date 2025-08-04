// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hustler.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Hustler {

 String get uid; String get email; String get name; List<String> get skills; DateTime get createdAt; String? get bio; String? get experience; String? get location; String? get phoneNumber; String? get photoUrl; double? get rating; int? get completedJobs; List<String> get certifications;
/// Create a copy of Hustler
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HustlerCopyWith<Hustler> get copyWith => _$HustlerCopyWithImpl<Hustler>(this as Hustler, _$identity);

  /// Serializes this Hustler to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Hustler&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.skills, skills)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.location, location) || other.location == location)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.completedJobs, completedJobs) || other.completedJobs == completedJobs)&&const DeepCollectionEquality().equals(other.certifications, certifications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,email,name,const DeepCollectionEquality().hash(skills),createdAt,bio,experience,location,phoneNumber,photoUrl,rating,completedJobs,const DeepCollectionEquality().hash(certifications));

@override
String toString() {
  return 'Hustler(uid: $uid, email: $email, name: $name, skills: $skills, createdAt: $createdAt, bio: $bio, experience: $experience, location: $location, phoneNumber: $phoneNumber, photoUrl: $photoUrl, rating: $rating, completedJobs: $completedJobs, certifications: $certifications)';
}


}

/// @nodoc
abstract mixin class $HustlerCopyWith<$Res>  {
  factory $HustlerCopyWith(Hustler value, $Res Function(Hustler) _then) = _$HustlerCopyWithImpl;
@useResult
$Res call({
 String uid, String email, String name, List<String> skills, DateTime createdAt, String? bio, String? experience, String? location, String? phoneNumber, String? photoUrl, double? rating, int? completedJobs, List<String> certifications
});




}
/// @nodoc
class _$HustlerCopyWithImpl<$Res>
    implements $HustlerCopyWith<$Res> {
  _$HustlerCopyWithImpl(this._self, this._then);

  final Hustler _self;
  final $Res Function(Hustler) _then;

/// Create a copy of Hustler
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? email = null,Object? name = null,Object? skills = null,Object? createdAt = null,Object? bio = freezed,Object? experience = freezed,Object? location = freezed,Object? phoneNumber = freezed,Object? photoUrl = freezed,Object? rating = freezed,Object? completedJobs = freezed,Object? certifications = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,completedJobs: freezed == completedJobs ? _self.completedJobs : completedJobs // ignore: cast_nullable_to_non_nullable
as int?,certifications: null == certifications ? _self.certifications : certifications // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Hustler].
extension HustlerPatterns on Hustler {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Hustler value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Hustler() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Hustler value)  $default,){
final _that = this;
switch (_that) {
case _Hustler():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Hustler value)?  $default,){
final _that = this;
switch (_that) {
case _Hustler() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String email,  String name,  List<String> skills,  DateTime createdAt,  String? bio,  String? experience,  String? location,  String? phoneNumber,  String? photoUrl,  double? rating,  int? completedJobs,  List<String> certifications)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Hustler() when $default != null:
return $default(_that.uid,_that.email,_that.name,_that.skills,_that.createdAt,_that.bio,_that.experience,_that.location,_that.phoneNumber,_that.photoUrl,_that.rating,_that.completedJobs,_that.certifications);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String email,  String name,  List<String> skills,  DateTime createdAt,  String? bio,  String? experience,  String? location,  String? phoneNumber,  String? photoUrl,  double? rating,  int? completedJobs,  List<String> certifications)  $default,) {final _that = this;
switch (_that) {
case _Hustler():
return $default(_that.uid,_that.email,_that.name,_that.skills,_that.createdAt,_that.bio,_that.experience,_that.location,_that.phoneNumber,_that.photoUrl,_that.rating,_that.completedJobs,_that.certifications);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String email,  String name,  List<String> skills,  DateTime createdAt,  String? bio,  String? experience,  String? location,  String? phoneNumber,  String? photoUrl,  double? rating,  int? completedJobs,  List<String> certifications)?  $default,) {final _that = this;
switch (_that) {
case _Hustler() when $default != null:
return $default(_that.uid,_that.email,_that.name,_that.skills,_that.createdAt,_that.bio,_that.experience,_that.location,_that.phoneNumber,_that.photoUrl,_that.rating,_that.completedJobs,_that.certifications);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Hustler implements Hustler {
  const _Hustler({required this.uid, required this.email, required this.name, required final  List<String> skills, required this.createdAt, this.bio, this.experience, this.location, this.phoneNumber, this.photoUrl, this.rating, this.completedJobs, final  List<String> certifications = const []}): _skills = skills,_certifications = certifications;
  factory _Hustler.fromJson(Map<String, dynamic> json) => _$HustlerFromJson(json);

@override final  String uid;
@override final  String email;
@override final  String name;
 final  List<String> _skills;
@override List<String> get skills {
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skills);
}

@override final  DateTime createdAt;
@override final  String? bio;
@override final  String? experience;
@override final  String? location;
@override final  String? phoneNumber;
@override final  String? photoUrl;
@override final  double? rating;
@override final  int? completedJobs;
 final  List<String> _certifications;
@override@JsonKey() List<String> get certifications {
  if (_certifications is EqualUnmodifiableListView) return _certifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_certifications);
}


/// Create a copy of Hustler
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HustlerCopyWith<_Hustler> get copyWith => __$HustlerCopyWithImpl<_Hustler>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HustlerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Hustler&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._skills, _skills)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.location, location) || other.location == location)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.completedJobs, completedJobs) || other.completedJobs == completedJobs)&&const DeepCollectionEquality().equals(other._certifications, _certifications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,email,name,const DeepCollectionEquality().hash(_skills),createdAt,bio,experience,location,phoneNumber,photoUrl,rating,completedJobs,const DeepCollectionEquality().hash(_certifications));

@override
String toString() {
  return 'Hustler(uid: $uid, email: $email, name: $name, skills: $skills, createdAt: $createdAt, bio: $bio, experience: $experience, location: $location, phoneNumber: $phoneNumber, photoUrl: $photoUrl, rating: $rating, completedJobs: $completedJobs, certifications: $certifications)';
}


}

/// @nodoc
abstract mixin class _$HustlerCopyWith<$Res> implements $HustlerCopyWith<$Res> {
  factory _$HustlerCopyWith(_Hustler value, $Res Function(_Hustler) _then) = __$HustlerCopyWithImpl;
@override @useResult
$Res call({
 String uid, String email, String name, List<String> skills, DateTime createdAt, String? bio, String? experience, String? location, String? phoneNumber, String? photoUrl, double? rating, int? completedJobs, List<String> certifications
});




}
/// @nodoc
class __$HustlerCopyWithImpl<$Res>
    implements _$HustlerCopyWith<$Res> {
  __$HustlerCopyWithImpl(this._self, this._then);

  final _Hustler _self;
  final $Res Function(_Hustler) _then;

/// Create a copy of Hustler
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? email = null,Object? name = null,Object? skills = null,Object? createdAt = null,Object? bio = freezed,Object? experience = freezed,Object? location = freezed,Object? phoneNumber = freezed,Object? photoUrl = freezed,Object? rating = freezed,Object? completedJobs = freezed,Object? certifications = null,}) {
  return _then(_Hustler(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,skills: null == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,completedJobs: freezed == completedJobs ? _self.completedJobs : completedJobs // ignore: cast_nullable_to_non_nullable
as int?,certifications: null == certifications ? _self._certifications : certifications // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on

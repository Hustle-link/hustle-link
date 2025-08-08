// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_application.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobApplication {

/// The unique identifier for the job application document in Firestore.
 String get id;/// The ID of the job being applied for.
 String get jobId;/// The unique identifier of the hustler who applied.
 String get hustlerUid;/// The unique identifier of the employer who posted the job.
 String get employerUid;/// The date and time when the application was submitted.
 DateTime get appliedAt;/// The current status of the application.
 ApplicationStatus get status;/// The cover letter or message submitted with the application.
 String? get coverLetter;/// The name of the hustler (denormalized for easy display).
 String? get hustlerName;/// The title of the job (denormalized for easy display).
 String? get jobTitle;/// The date and time when the application was reviewed by the employer.
 DateTime? get reviewedAt;
/// Create a copy of JobApplication
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobApplicationCopyWith<JobApplication> get copyWith => _$JobApplicationCopyWithImpl<JobApplication>(this as JobApplication, _$identity);

  /// Serializes this JobApplication to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobApplication&&(identical(other.id, id) || other.id == id)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.hustlerUid, hustlerUid) || other.hustlerUid == hustlerUid)&&(identical(other.employerUid, employerUid) || other.employerUid == employerUid)&&(identical(other.appliedAt, appliedAt) || other.appliedAt == appliedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.coverLetter, coverLetter) || other.coverLetter == coverLetter)&&(identical(other.hustlerName, hustlerName) || other.hustlerName == hustlerName)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jobId,hustlerUid,employerUid,appliedAt,status,coverLetter,hustlerName,jobTitle,reviewedAt);

@override
String toString() {
  return 'JobApplication(id: $id, jobId: $jobId, hustlerUid: $hustlerUid, employerUid: $employerUid, appliedAt: $appliedAt, status: $status, coverLetter: $coverLetter, hustlerName: $hustlerName, jobTitle: $jobTitle, reviewedAt: $reviewedAt)';
}


}

/// @nodoc
abstract mixin class $JobApplicationCopyWith<$Res>  {
  factory $JobApplicationCopyWith(JobApplication value, $Res Function(JobApplication) _then) = _$JobApplicationCopyWithImpl;
@useResult
$Res call({
 String id, String jobId, String hustlerUid, String employerUid, DateTime appliedAt, ApplicationStatus status, String? coverLetter, String? hustlerName, String? jobTitle, DateTime? reviewedAt
});




}
/// @nodoc
class _$JobApplicationCopyWithImpl<$Res>
    implements $JobApplicationCopyWith<$Res> {
  _$JobApplicationCopyWithImpl(this._self, this._then);

  final JobApplication _self;
  final $Res Function(JobApplication) _then;

/// Create a copy of JobApplication
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? jobId = null,Object? hustlerUid = null,Object? employerUid = null,Object? appliedAt = null,Object? status = null,Object? coverLetter = freezed,Object? hustlerName = freezed,Object? jobTitle = freezed,Object? reviewedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,hustlerUid: null == hustlerUid ? _self.hustlerUid : hustlerUid // ignore: cast_nullable_to_non_nullable
as String,employerUid: null == employerUid ? _self.employerUid : employerUid // ignore: cast_nullable_to_non_nullable
as String,appliedAt: null == appliedAt ? _self.appliedAt : appliedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,coverLetter: freezed == coverLetter ? _self.coverLetter : coverLetter // ignore: cast_nullable_to_non_nullable
as String?,hustlerName: freezed == hustlerName ? _self.hustlerName : hustlerName // ignore: cast_nullable_to_non_nullable
as String?,jobTitle: freezed == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobApplication].
extension JobApplicationPatterns on JobApplication {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobApplication value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobApplication() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobApplication value)  $default,){
final _that = this;
switch (_that) {
case _JobApplication():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobApplication value)?  $default,){
final _that = this;
switch (_that) {
case _JobApplication() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String jobId,  String hustlerUid,  String employerUid,  DateTime appliedAt,  ApplicationStatus status,  String? coverLetter,  String? hustlerName,  String? jobTitle,  DateTime? reviewedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobApplication() when $default != null:
return $default(_that.id,_that.jobId,_that.hustlerUid,_that.employerUid,_that.appliedAt,_that.status,_that.coverLetter,_that.hustlerName,_that.jobTitle,_that.reviewedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String jobId,  String hustlerUid,  String employerUid,  DateTime appliedAt,  ApplicationStatus status,  String? coverLetter,  String? hustlerName,  String? jobTitle,  DateTime? reviewedAt)  $default,) {final _that = this;
switch (_that) {
case _JobApplication():
return $default(_that.id,_that.jobId,_that.hustlerUid,_that.employerUid,_that.appliedAt,_that.status,_that.coverLetter,_that.hustlerName,_that.jobTitle,_that.reviewedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String jobId,  String hustlerUid,  String employerUid,  DateTime appliedAt,  ApplicationStatus status,  String? coverLetter,  String? hustlerName,  String? jobTitle,  DateTime? reviewedAt)?  $default,) {final _that = this;
switch (_that) {
case _JobApplication() when $default != null:
return $default(_that.id,_that.jobId,_that.hustlerUid,_that.employerUid,_that.appliedAt,_that.status,_that.coverLetter,_that.hustlerName,_that.jobTitle,_that.reviewedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobApplication implements JobApplication {
  const _JobApplication({required this.id, required this.jobId, required this.hustlerUid, required this.employerUid, required this.appliedAt, required this.status, this.coverLetter, this.hustlerName, this.jobTitle, this.reviewedAt});
  factory _JobApplication.fromJson(Map<String, dynamic> json) => _$JobApplicationFromJson(json);

/// The unique identifier for the job application document in Firestore.
@override final  String id;
/// The ID of the job being applied for.
@override final  String jobId;
/// The unique identifier of the hustler who applied.
@override final  String hustlerUid;
/// The unique identifier of the employer who posted the job.
@override final  String employerUid;
/// The date and time when the application was submitted.
@override final  DateTime appliedAt;
/// The current status of the application.
@override final  ApplicationStatus status;
/// The cover letter or message submitted with the application.
@override final  String? coverLetter;
/// The name of the hustler (denormalized for easy display).
@override final  String? hustlerName;
/// The title of the job (denormalized for easy display).
@override final  String? jobTitle;
/// The date and time when the application was reviewed by the employer.
@override final  DateTime? reviewedAt;

/// Create a copy of JobApplication
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobApplicationCopyWith<_JobApplication> get copyWith => __$JobApplicationCopyWithImpl<_JobApplication>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobApplicationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobApplication&&(identical(other.id, id) || other.id == id)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.hustlerUid, hustlerUid) || other.hustlerUid == hustlerUid)&&(identical(other.employerUid, employerUid) || other.employerUid == employerUid)&&(identical(other.appliedAt, appliedAt) || other.appliedAt == appliedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.coverLetter, coverLetter) || other.coverLetter == coverLetter)&&(identical(other.hustlerName, hustlerName) || other.hustlerName == hustlerName)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jobId,hustlerUid,employerUid,appliedAt,status,coverLetter,hustlerName,jobTitle,reviewedAt);

@override
String toString() {
  return 'JobApplication(id: $id, jobId: $jobId, hustlerUid: $hustlerUid, employerUid: $employerUid, appliedAt: $appliedAt, status: $status, coverLetter: $coverLetter, hustlerName: $hustlerName, jobTitle: $jobTitle, reviewedAt: $reviewedAt)';
}


}

/// @nodoc
abstract mixin class _$JobApplicationCopyWith<$Res> implements $JobApplicationCopyWith<$Res> {
  factory _$JobApplicationCopyWith(_JobApplication value, $Res Function(_JobApplication) _then) = __$JobApplicationCopyWithImpl;
@override @useResult
$Res call({
 String id, String jobId, String hustlerUid, String employerUid, DateTime appliedAt, ApplicationStatus status, String? coverLetter, String? hustlerName, String? jobTitle, DateTime? reviewedAt
});




}
/// @nodoc
class __$JobApplicationCopyWithImpl<$Res>
    implements _$JobApplicationCopyWith<$Res> {
  __$JobApplicationCopyWithImpl(this._self, this._then);

  final _JobApplication _self;
  final $Res Function(_JobApplication) _then;

/// Create a copy of JobApplication
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? jobId = null,Object? hustlerUid = null,Object? employerUid = null,Object? appliedAt = null,Object? status = null,Object? coverLetter = freezed,Object? hustlerName = freezed,Object? jobTitle = freezed,Object? reviewedAt = freezed,}) {
  return _then(_JobApplication(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,hustlerUid: null == hustlerUid ? _self.hustlerUid : hustlerUid // ignore: cast_nullable_to_non_nullable
as String,employerUid: null == employerUid ? _self.employerUid : employerUid // ignore: cast_nullable_to_non_nullable
as String,appliedAt: null == appliedAt ? _self.appliedAt : appliedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,coverLetter: freezed == coverLetter ? _self.coverLetter : coverLetter // ignore: cast_nullable_to_non_nullable
as String?,hustlerName: freezed == hustlerName ? _self.hustlerName : hustlerName // ignore: cast_nullable_to_non_nullable
as String?,jobTitle: freezed == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

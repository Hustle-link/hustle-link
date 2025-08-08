// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_posting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobPosting {

/// The unique identifier for the job posting document in Firestore.
 String get id;/// The unique identifier of the employer who created the posting.
 String get employerUid;/// The title of the job.
 String get title;/// A detailed description of the job, including responsibilities and requirements.
 String get description;/// A list of skills required for the job.
 List<String> get skillsRequired;/// The compensation or salary for the job.
 double get compensation;/// The date and time when the job posting was created.
 DateTime get createdAt;/// The current status of the job posting.
 JobStatus get status;/// The location where the job is based.
 String? get location;/// The name of the employer (denormalized for easy display).
 String? get employerName;/// The company name of the employer (denormalized for easy display).
 String? get employerCompany;/// The deadline for applying to the job.
 DateTime? get deadline;/// The number of applications received for this job.
 int? get applicationsCount;
/// Create a copy of JobPosting
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobPostingCopyWith<JobPosting> get copyWith => _$JobPostingCopyWithImpl<JobPosting>(this as JobPosting, _$identity);

  /// Serializes this JobPosting to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobPosting&&(identical(other.id, id) || other.id == id)&&(identical(other.employerUid, employerUid) || other.employerUid == employerUid)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.skillsRequired, skillsRequired)&&(identical(other.compensation, compensation) || other.compensation == compensation)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.location, location) || other.location == location)&&(identical(other.employerName, employerName) || other.employerName == employerName)&&(identical(other.employerCompany, employerCompany) || other.employerCompany == employerCompany)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.applicationsCount, applicationsCount) || other.applicationsCount == applicationsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,employerUid,title,description,const DeepCollectionEquality().hash(skillsRequired),compensation,createdAt,status,location,employerName,employerCompany,deadline,applicationsCount);

@override
String toString() {
  return 'JobPosting(id: $id, employerUid: $employerUid, title: $title, description: $description, skillsRequired: $skillsRequired, compensation: $compensation, createdAt: $createdAt, status: $status, location: $location, employerName: $employerName, employerCompany: $employerCompany, deadline: $deadline, applicationsCount: $applicationsCount)';
}


}

/// @nodoc
abstract mixin class $JobPostingCopyWith<$Res>  {
  factory $JobPostingCopyWith(JobPosting value, $Res Function(JobPosting) _then) = _$JobPostingCopyWithImpl;
@useResult
$Res call({
 String id, String employerUid, String title, String description, List<String> skillsRequired, double compensation, DateTime createdAt, JobStatus status, String? location, String? employerName, String? employerCompany, DateTime? deadline, int? applicationsCount
});




}
/// @nodoc
class _$JobPostingCopyWithImpl<$Res>
    implements $JobPostingCopyWith<$Res> {
  _$JobPostingCopyWithImpl(this._self, this._then);

  final JobPosting _self;
  final $Res Function(JobPosting) _then;

/// Create a copy of JobPosting
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? employerUid = null,Object? title = null,Object? description = null,Object? skillsRequired = null,Object? compensation = null,Object? createdAt = null,Object? status = null,Object? location = freezed,Object? employerName = freezed,Object? employerCompany = freezed,Object? deadline = freezed,Object? applicationsCount = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employerUid: null == employerUid ? _self.employerUid : employerUid // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,skillsRequired: null == skillsRequired ? _self.skillsRequired : skillsRequired // ignore: cast_nullable_to_non_nullable
as List<String>,compensation: null == compensation ? _self.compensation : compensation // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobStatus,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,employerName: freezed == employerName ? _self.employerName : employerName // ignore: cast_nullable_to_non_nullable
as String?,employerCompany: freezed == employerCompany ? _self.employerCompany : employerCompany // ignore: cast_nullable_to_non_nullable
as String?,deadline: freezed == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime?,applicationsCount: freezed == applicationsCount ? _self.applicationsCount : applicationsCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobPosting].
extension JobPostingPatterns on JobPosting {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobPosting value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobPosting() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobPosting value)  $default,){
final _that = this;
switch (_that) {
case _JobPosting():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobPosting value)?  $default,){
final _that = this;
switch (_that) {
case _JobPosting() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String employerUid,  String title,  String description,  List<String> skillsRequired,  double compensation,  DateTime createdAt,  JobStatus status,  String? location,  String? employerName,  String? employerCompany,  DateTime? deadline,  int? applicationsCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobPosting() when $default != null:
return $default(_that.id,_that.employerUid,_that.title,_that.description,_that.skillsRequired,_that.compensation,_that.createdAt,_that.status,_that.location,_that.employerName,_that.employerCompany,_that.deadline,_that.applicationsCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String employerUid,  String title,  String description,  List<String> skillsRequired,  double compensation,  DateTime createdAt,  JobStatus status,  String? location,  String? employerName,  String? employerCompany,  DateTime? deadline,  int? applicationsCount)  $default,) {final _that = this;
switch (_that) {
case _JobPosting():
return $default(_that.id,_that.employerUid,_that.title,_that.description,_that.skillsRequired,_that.compensation,_that.createdAt,_that.status,_that.location,_that.employerName,_that.employerCompany,_that.deadline,_that.applicationsCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String employerUid,  String title,  String description,  List<String> skillsRequired,  double compensation,  DateTime createdAt,  JobStatus status,  String? location,  String? employerName,  String? employerCompany,  DateTime? deadline,  int? applicationsCount)?  $default,) {final _that = this;
switch (_that) {
case _JobPosting() when $default != null:
return $default(_that.id,_that.employerUid,_that.title,_that.description,_that.skillsRequired,_that.compensation,_that.createdAt,_that.status,_that.location,_that.employerName,_that.employerCompany,_that.deadline,_that.applicationsCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobPosting implements JobPosting {
  const _JobPosting({required this.id, required this.employerUid, required this.title, required this.description, required final  List<String> skillsRequired, required this.compensation, required this.createdAt, required this.status, this.location, this.employerName, this.employerCompany, this.deadline, this.applicationsCount}): _skillsRequired = skillsRequired;
  factory _JobPosting.fromJson(Map<String, dynamic> json) => _$JobPostingFromJson(json);

/// The unique identifier for the job posting document in Firestore.
@override final  String id;
/// The unique identifier of the employer who created the posting.
@override final  String employerUid;
/// The title of the job.
@override final  String title;
/// A detailed description of the job, including responsibilities and requirements.
@override final  String description;
/// A list of skills required for the job.
 final  List<String> _skillsRequired;
/// A list of skills required for the job.
@override List<String> get skillsRequired {
  if (_skillsRequired is EqualUnmodifiableListView) return _skillsRequired;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skillsRequired);
}

/// The compensation or salary for the job.
@override final  double compensation;
/// The date and time when the job posting was created.
@override final  DateTime createdAt;
/// The current status of the job posting.
@override final  JobStatus status;
/// The location where the job is based.
@override final  String? location;
/// The name of the employer (denormalized for easy display).
@override final  String? employerName;
/// The company name of the employer (denormalized for easy display).
@override final  String? employerCompany;
/// The deadline for applying to the job.
@override final  DateTime? deadline;
/// The number of applications received for this job.
@override final  int? applicationsCount;

/// Create a copy of JobPosting
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobPostingCopyWith<_JobPosting> get copyWith => __$JobPostingCopyWithImpl<_JobPosting>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobPostingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobPosting&&(identical(other.id, id) || other.id == id)&&(identical(other.employerUid, employerUid) || other.employerUid == employerUid)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._skillsRequired, _skillsRequired)&&(identical(other.compensation, compensation) || other.compensation == compensation)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.location, location) || other.location == location)&&(identical(other.employerName, employerName) || other.employerName == employerName)&&(identical(other.employerCompany, employerCompany) || other.employerCompany == employerCompany)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.applicationsCount, applicationsCount) || other.applicationsCount == applicationsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,employerUid,title,description,const DeepCollectionEquality().hash(_skillsRequired),compensation,createdAt,status,location,employerName,employerCompany,deadline,applicationsCount);

@override
String toString() {
  return 'JobPosting(id: $id, employerUid: $employerUid, title: $title, description: $description, skillsRequired: $skillsRequired, compensation: $compensation, createdAt: $createdAt, status: $status, location: $location, employerName: $employerName, employerCompany: $employerCompany, deadline: $deadline, applicationsCount: $applicationsCount)';
}


}

/// @nodoc
abstract mixin class _$JobPostingCopyWith<$Res> implements $JobPostingCopyWith<$Res> {
  factory _$JobPostingCopyWith(_JobPosting value, $Res Function(_JobPosting) _then) = __$JobPostingCopyWithImpl;
@override @useResult
$Res call({
 String id, String employerUid, String title, String description, List<String> skillsRequired, double compensation, DateTime createdAt, JobStatus status, String? location, String? employerName, String? employerCompany, DateTime? deadline, int? applicationsCount
});




}
/// @nodoc
class __$JobPostingCopyWithImpl<$Res>
    implements _$JobPostingCopyWith<$Res> {
  __$JobPostingCopyWithImpl(this._self, this._then);

  final _JobPosting _self;
  final $Res Function(_JobPosting) _then;

/// Create a copy of JobPosting
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? employerUid = null,Object? title = null,Object? description = null,Object? skillsRequired = null,Object? compensation = null,Object? createdAt = null,Object? status = null,Object? location = freezed,Object? employerName = freezed,Object? employerCompany = freezed,Object? deadline = freezed,Object? applicationsCount = freezed,}) {
  return _then(_JobPosting(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employerUid: null == employerUid ? _self.employerUid : employerUid // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,skillsRequired: null == skillsRequired ? _self._skillsRequired : skillsRequired // ignore: cast_nullable_to_non_nullable
as List<String>,compensation: null == compensation ? _self.compensation : compensation // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobStatus,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,employerName: freezed == employerName ? _self.employerName : employerName // ignore: cast_nullable_to_non_nullable
as String?,employerCompany: freezed == employerCompany ? _self.employerCompany : employerCompany // ignore: cast_nullable_to_non_nullable
as String?,deadline: freezed == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime?,applicationsCount: freezed == applicationsCount ? _self.applicationsCount : applicationsCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on

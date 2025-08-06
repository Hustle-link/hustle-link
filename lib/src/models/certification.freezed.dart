// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'certification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Certification {

 String get id; String get userId; String get fileName; String get downloadUrl; DateTime get uploadedAt; CertificationStatus get status; String? get verifiedBy;// Admin/employer ID who verified
 DateTime? get verifiedAt; String? get rejectionReason; DateTime? get expiryDate;// For time-sensitive certifications
 String? get certificationType;// e.g., 'diploma', 'license', 'certificate'
 String? get issuingOrganization; Map<String, dynamic>? get metadata;
/// Create a copy of Certification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CertificationCopyWith<Certification> get copyWith => _$CertificationCopyWithImpl<Certification>(this as Certification, _$identity);

  /// Serializes this Certification to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Certification&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl)&&(identical(other.uploadedAt, uploadedAt) || other.uploadedAt == uploadedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.verifiedBy, verifiedBy) || other.verifiedBy == verifiedBy)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.certificationType, certificationType) || other.certificationType == certificationType)&&(identical(other.issuingOrganization, issuingOrganization) || other.issuingOrganization == issuingOrganization)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,fileName,downloadUrl,uploadedAt,status,verifiedBy,verifiedAt,rejectionReason,expiryDate,certificationType,issuingOrganization,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'Certification(id: $id, userId: $userId, fileName: $fileName, downloadUrl: $downloadUrl, uploadedAt: $uploadedAt, status: $status, verifiedBy: $verifiedBy, verifiedAt: $verifiedAt, rejectionReason: $rejectionReason, expiryDate: $expiryDate, certificationType: $certificationType, issuingOrganization: $issuingOrganization, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $CertificationCopyWith<$Res>  {
  factory $CertificationCopyWith(Certification value, $Res Function(Certification) _then) = _$CertificationCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String fileName, String downloadUrl, DateTime uploadedAt, CertificationStatus status, String? verifiedBy, DateTime? verifiedAt, String? rejectionReason, DateTime? expiryDate, String? certificationType, String? issuingOrganization, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$CertificationCopyWithImpl<$Res>
    implements $CertificationCopyWith<$Res> {
  _$CertificationCopyWithImpl(this._self, this._then);

  final Certification _self;
  final $Res Function(Certification) _then;

/// Create a copy of Certification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? fileName = null,Object? downloadUrl = null,Object? uploadedAt = null,Object? status = null,Object? verifiedBy = freezed,Object? verifiedAt = freezed,Object? rejectionReason = freezed,Object? expiryDate = freezed,Object? certificationType = freezed,Object? issuingOrganization = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,downloadUrl: null == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String,uploadedAt: null == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CertificationStatus,verifiedBy: freezed == verifiedBy ? _self.verifiedBy : verifiedBy // ignore: cast_nullable_to_non_nullable
as String?,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,certificationType: freezed == certificationType ? _self.certificationType : certificationType // ignore: cast_nullable_to_non_nullable
as String?,issuingOrganization: freezed == issuingOrganization ? _self.issuingOrganization : issuingOrganization // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Certification].
extension CertificationPatterns on Certification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Certification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Certification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Certification value)  $default,){
final _that = this;
switch (_that) {
case _Certification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Certification value)?  $default,){
final _that = this;
switch (_that) {
case _Certification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String fileName,  String downloadUrl,  DateTime uploadedAt,  CertificationStatus status,  String? verifiedBy,  DateTime? verifiedAt,  String? rejectionReason,  DateTime? expiryDate,  String? certificationType,  String? issuingOrganization,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Certification() when $default != null:
return $default(_that.id,_that.userId,_that.fileName,_that.downloadUrl,_that.uploadedAt,_that.status,_that.verifiedBy,_that.verifiedAt,_that.rejectionReason,_that.expiryDate,_that.certificationType,_that.issuingOrganization,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String fileName,  String downloadUrl,  DateTime uploadedAt,  CertificationStatus status,  String? verifiedBy,  DateTime? verifiedAt,  String? rejectionReason,  DateTime? expiryDate,  String? certificationType,  String? issuingOrganization,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _Certification():
return $default(_that.id,_that.userId,_that.fileName,_that.downloadUrl,_that.uploadedAt,_that.status,_that.verifiedBy,_that.verifiedAt,_that.rejectionReason,_that.expiryDate,_that.certificationType,_that.issuingOrganization,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String fileName,  String downloadUrl,  DateTime uploadedAt,  CertificationStatus status,  String? verifiedBy,  DateTime? verifiedAt,  String? rejectionReason,  DateTime? expiryDate,  String? certificationType,  String? issuingOrganization,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _Certification() when $default != null:
return $default(_that.id,_that.userId,_that.fileName,_that.downloadUrl,_that.uploadedAt,_that.status,_that.verifiedBy,_that.verifiedAt,_that.rejectionReason,_that.expiryDate,_that.certificationType,_that.issuingOrganization,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Certification implements Certification {
  const _Certification({required this.id, required this.userId, required this.fileName, required this.downloadUrl, required this.uploadedAt, this.status = CertificationStatus.pending, this.verifiedBy, this.verifiedAt, this.rejectionReason, this.expiryDate, this.certificationType, this.issuingOrganization, final  Map<String, dynamic>? metadata}): _metadata = metadata;
  factory _Certification.fromJson(Map<String, dynamic> json) => _$CertificationFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String fileName;
@override final  String downloadUrl;
@override final  DateTime uploadedAt;
@override@JsonKey() final  CertificationStatus status;
@override final  String? verifiedBy;
// Admin/employer ID who verified
@override final  DateTime? verifiedAt;
@override final  String? rejectionReason;
@override final  DateTime? expiryDate;
// For time-sensitive certifications
@override final  String? certificationType;
// e.g., 'diploma', 'license', 'certificate'
@override final  String? issuingOrganization;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Certification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CertificationCopyWith<_Certification> get copyWith => __$CertificationCopyWithImpl<_Certification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CertificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Certification&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl)&&(identical(other.uploadedAt, uploadedAt) || other.uploadedAt == uploadedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.verifiedBy, verifiedBy) || other.verifiedBy == verifiedBy)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.certificationType, certificationType) || other.certificationType == certificationType)&&(identical(other.issuingOrganization, issuingOrganization) || other.issuingOrganization == issuingOrganization)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,fileName,downloadUrl,uploadedAt,status,verifiedBy,verifiedAt,rejectionReason,expiryDate,certificationType,issuingOrganization,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'Certification(id: $id, userId: $userId, fileName: $fileName, downloadUrl: $downloadUrl, uploadedAt: $uploadedAt, status: $status, verifiedBy: $verifiedBy, verifiedAt: $verifiedAt, rejectionReason: $rejectionReason, expiryDate: $expiryDate, certificationType: $certificationType, issuingOrganization: $issuingOrganization, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$CertificationCopyWith<$Res> implements $CertificationCopyWith<$Res> {
  factory _$CertificationCopyWith(_Certification value, $Res Function(_Certification) _then) = __$CertificationCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String fileName, String downloadUrl, DateTime uploadedAt, CertificationStatus status, String? verifiedBy, DateTime? verifiedAt, String? rejectionReason, DateTime? expiryDate, String? certificationType, String? issuingOrganization, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$CertificationCopyWithImpl<$Res>
    implements _$CertificationCopyWith<$Res> {
  __$CertificationCopyWithImpl(this._self, this._then);

  final _Certification _self;
  final $Res Function(_Certification) _then;

/// Create a copy of Certification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? fileName = null,Object? downloadUrl = null,Object? uploadedAt = null,Object? status = null,Object? verifiedBy = freezed,Object? verifiedAt = freezed,Object? rejectionReason = freezed,Object? expiryDate = freezed,Object? certificationType = freezed,Object? issuingOrganization = freezed,Object? metadata = freezed,}) {
  return _then(_Certification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,downloadUrl: null == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String,uploadedAt: null == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CertificationStatus,verifiedBy: freezed == verifiedBy ? _self.verifiedBy : verifiedBy // ignore: cast_nullable_to_non_nullable
as String?,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,certificationType: freezed == certificationType ? _self.certificationType : certificationType // ignore: cast_nullable_to_non_nullable
as String?,issuingOrganization: freezed == issuingOrganization ? _self.issuingOrganization : issuingOrganization // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on

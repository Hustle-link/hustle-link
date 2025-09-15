// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orange_money_payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrangeMoneyPayment {

 String get transactionId; String get phoneNumber; double get amount; PaymentStatus get status; DateTime get paymentDate; DateTime? get confirmationDate; String? get failureReason; String? get orangeMoneyReference;
/// Create a copy of OrangeMoneyPayment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrangeMoneyPaymentCopyWith<OrangeMoneyPayment> get copyWith => _$OrangeMoneyPaymentCopyWithImpl<OrangeMoneyPayment>(this as OrangeMoneyPayment, _$identity);

  /// Serializes this OrangeMoneyPayment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrangeMoneyPayment&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.confirmationDate, confirmationDate) || other.confirmationDate == confirmationDate)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.orangeMoneyReference, orangeMoneyReference) || other.orangeMoneyReference == orangeMoneyReference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,phoneNumber,amount,status,paymentDate,confirmationDate,failureReason,orangeMoneyReference);

@override
String toString() {
  return 'OrangeMoneyPayment(transactionId: $transactionId, phoneNumber: $phoneNumber, amount: $amount, status: $status, paymentDate: $paymentDate, confirmationDate: $confirmationDate, failureReason: $failureReason, orangeMoneyReference: $orangeMoneyReference)';
}


}

/// @nodoc
abstract mixin class $OrangeMoneyPaymentCopyWith<$Res>  {
  factory $OrangeMoneyPaymentCopyWith(OrangeMoneyPayment value, $Res Function(OrangeMoneyPayment) _then) = _$OrangeMoneyPaymentCopyWithImpl;
@useResult
$Res call({
 String transactionId, String phoneNumber, double amount, PaymentStatus status, DateTime paymentDate, DateTime? confirmationDate, String? failureReason, String? orangeMoneyReference
});




}
/// @nodoc
class _$OrangeMoneyPaymentCopyWithImpl<$Res>
    implements $OrangeMoneyPaymentCopyWith<$Res> {
  _$OrangeMoneyPaymentCopyWithImpl(this._self, this._then);

  final OrangeMoneyPayment _self;
  final $Res Function(OrangeMoneyPayment) _then;

/// Create a copy of OrangeMoneyPayment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionId = null,Object? phoneNumber = null,Object? amount = null,Object? status = null,Object? paymentDate = null,Object? confirmationDate = freezed,Object? failureReason = freezed,Object? orangeMoneyReference = freezed,}) {
  return _then(_self.copyWith(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,paymentDate: null == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as DateTime,confirmationDate: freezed == confirmationDate ? _self.confirmationDate : confirmationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,orangeMoneyReference: freezed == orangeMoneyReference ? _self.orangeMoneyReference : orangeMoneyReference // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrangeMoneyPayment].
extension OrangeMoneyPaymentPatterns on OrangeMoneyPayment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrangeMoneyPayment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrangeMoneyPayment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrangeMoneyPayment value)  $default,){
final _that = this;
switch (_that) {
case _OrangeMoneyPayment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrangeMoneyPayment value)?  $default,){
final _that = this;
switch (_that) {
case _OrangeMoneyPayment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String transactionId,  String phoneNumber,  double amount,  PaymentStatus status,  DateTime paymentDate,  DateTime? confirmationDate,  String? failureReason,  String? orangeMoneyReference)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrangeMoneyPayment() when $default != null:
return $default(_that.transactionId,_that.phoneNumber,_that.amount,_that.status,_that.paymentDate,_that.confirmationDate,_that.failureReason,_that.orangeMoneyReference);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String transactionId,  String phoneNumber,  double amount,  PaymentStatus status,  DateTime paymentDate,  DateTime? confirmationDate,  String? failureReason,  String? orangeMoneyReference)  $default,) {final _that = this;
switch (_that) {
case _OrangeMoneyPayment():
return $default(_that.transactionId,_that.phoneNumber,_that.amount,_that.status,_that.paymentDate,_that.confirmationDate,_that.failureReason,_that.orangeMoneyReference);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String transactionId,  String phoneNumber,  double amount,  PaymentStatus status,  DateTime paymentDate,  DateTime? confirmationDate,  String? failureReason,  String? orangeMoneyReference)?  $default,) {final _that = this;
switch (_that) {
case _OrangeMoneyPayment() when $default != null:
return $default(_that.transactionId,_that.phoneNumber,_that.amount,_that.status,_that.paymentDate,_that.confirmationDate,_that.failureReason,_that.orangeMoneyReference);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrangeMoneyPayment implements OrangeMoneyPayment {
  const _OrangeMoneyPayment({required this.transactionId, required this.phoneNumber, required this.amount, required this.status, required this.paymentDate, this.confirmationDate, this.failureReason, this.orangeMoneyReference});
  factory _OrangeMoneyPayment.fromJson(Map<String, dynamic> json) => _$OrangeMoneyPaymentFromJson(json);

@override final  String transactionId;
@override final  String phoneNumber;
@override final  double amount;
@override final  PaymentStatus status;
@override final  DateTime paymentDate;
@override final  DateTime? confirmationDate;
@override final  String? failureReason;
@override final  String? orangeMoneyReference;

/// Create a copy of OrangeMoneyPayment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrangeMoneyPaymentCopyWith<_OrangeMoneyPayment> get copyWith => __$OrangeMoneyPaymentCopyWithImpl<_OrangeMoneyPayment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrangeMoneyPaymentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrangeMoneyPayment&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.confirmationDate, confirmationDate) || other.confirmationDate == confirmationDate)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.orangeMoneyReference, orangeMoneyReference) || other.orangeMoneyReference == orangeMoneyReference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,phoneNumber,amount,status,paymentDate,confirmationDate,failureReason,orangeMoneyReference);

@override
String toString() {
  return 'OrangeMoneyPayment(transactionId: $transactionId, phoneNumber: $phoneNumber, amount: $amount, status: $status, paymentDate: $paymentDate, confirmationDate: $confirmationDate, failureReason: $failureReason, orangeMoneyReference: $orangeMoneyReference)';
}


}

/// @nodoc
abstract mixin class _$OrangeMoneyPaymentCopyWith<$Res> implements $OrangeMoneyPaymentCopyWith<$Res> {
  factory _$OrangeMoneyPaymentCopyWith(_OrangeMoneyPayment value, $Res Function(_OrangeMoneyPayment) _then) = __$OrangeMoneyPaymentCopyWithImpl;
@override @useResult
$Res call({
 String transactionId, String phoneNumber, double amount, PaymentStatus status, DateTime paymentDate, DateTime? confirmationDate, String? failureReason, String? orangeMoneyReference
});




}
/// @nodoc
class __$OrangeMoneyPaymentCopyWithImpl<$Res>
    implements _$OrangeMoneyPaymentCopyWith<$Res> {
  __$OrangeMoneyPaymentCopyWithImpl(this._self, this._then);

  final _OrangeMoneyPayment _self;
  final $Res Function(_OrangeMoneyPayment) _then;

/// Create a copy of OrangeMoneyPayment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionId = null,Object? phoneNumber = null,Object? amount = null,Object? status = null,Object? paymentDate = null,Object? confirmationDate = freezed,Object? failureReason = freezed,Object? orangeMoneyReference = freezed,}) {
  return _then(_OrangeMoneyPayment(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,paymentDate: null == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as DateTime,confirmationDate: freezed == confirmationDate ? _self.confirmationDate : confirmationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,orangeMoneyReference: freezed == orangeMoneyReference ? _self.orangeMoneyReference : orangeMoneyReference // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MessageEntity {
  String get id => throw _privateConstructorUsedError; // Wix _id for updates
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError; // Can contain HTML
  String get category => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate =>
      throw _privateConstructorUsedError; // null = visible forever
  String get imageUrl => throw _privateConstructorUsedError;
  String get externalLink => throw _privateConstructorUsedError;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageEntityCopyWith<MessageEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageEntityCopyWith<$Res> {
  factory $MessageEntityCopyWith(
          MessageEntity value, $Res Function(MessageEntity) then) =
      _$MessageEntityCopyWithImpl<$Res, MessageEntity>;
  @useResult
  $Res call(
      {String id,
      DateTime createdAt,
      String title,
      String message,
      String category,
      DateTime startDate,
      DateTime? endDate,
      String imageUrl,
      String externalLink});
}

/// @nodoc
class _$MessageEntityCopyWithImpl<$Res, $Val extends MessageEntity>
    implements $MessageEntityCopyWith<$Res> {
  _$MessageEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? title = null,
    Object? message = null,
    Object? category = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? imageUrl = null,
    Object? externalLink = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      externalLink: null == externalLink
          ? _value.externalLink
          : externalLink // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageEntityImplCopyWith<$Res>
    implements $MessageEntityCopyWith<$Res> {
  factory _$$MessageEntityImplCopyWith(
          _$MessageEntityImpl value, $Res Function(_$MessageEntityImpl) then) =
      __$$MessageEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime createdAt,
      String title,
      String message,
      String category,
      DateTime startDate,
      DateTime? endDate,
      String imageUrl,
      String externalLink});
}

/// @nodoc
class __$$MessageEntityImplCopyWithImpl<$Res>
    extends _$MessageEntityCopyWithImpl<$Res, _$MessageEntityImpl>
    implements _$$MessageEntityImplCopyWith<$Res> {
  __$$MessageEntityImplCopyWithImpl(
      _$MessageEntityImpl _value, $Res Function(_$MessageEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? title = null,
    Object? message = null,
    Object? category = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? imageUrl = null,
    Object? externalLink = null,
  }) {
    return _then(_$MessageEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      externalLink: null == externalLink
          ? _value.externalLink
          : externalLink // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MessageEntityImpl extends _MessageEntity {
  const _$MessageEntityImpl(
      {required this.id,
      required this.createdAt,
      required this.title,
      required this.message,
      required this.category,
      required this.startDate,
      this.endDate,
      this.imageUrl = '',
      this.externalLink = ''})
      : super._();

  @override
  final String id;
// Wix _id for updates
  @override
  final DateTime createdAt;
  @override
  final String title;
  @override
  final String message;
// Can contain HTML
  @override
  final String category;
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
// null = visible forever
  @override
  @JsonKey()
  final String imageUrl;
  @override
  @JsonKey()
  final String externalLink;

  @override
  String toString() {
    return 'MessageEntity(id: $id, createdAt: $createdAt, title: $title, message: $message, category: $category, startDate: $startDate, endDate: $endDate, imageUrl: $imageUrl, externalLink: $externalLink)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.externalLink, externalLink) ||
                other.externalLink == externalLink));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, title, message,
      category, startDate, endDate, imageUrl, externalLink);

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageEntityImplCopyWith<_$MessageEntityImpl> get copyWith =>
      __$$MessageEntityImplCopyWithImpl<_$MessageEntityImpl>(this, _$identity);
}

abstract class _MessageEntity extends MessageEntity {
  const factory _MessageEntity(
      {required final String id,
      required final DateTime createdAt,
      required final String title,
      required final String message,
      required final String category,
      required final DateTime startDate,
      final DateTime? endDate,
      final String imageUrl,
      final String externalLink}) = _$MessageEntityImpl;
  const _MessageEntity._() : super._();

  @override
  String get id; // Wix _id for updates
  @override
  DateTime get createdAt;
  @override
  String get title;
  @override
  String get message; // Can contain HTML
  @override
  String get category;
  @override
  DateTime get startDate;
  @override
  DateTime? get endDate; // null = visible forever
  @override
  String get imageUrl;
  @override
  String get externalLink;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageEntityImplCopyWith<_$MessageEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

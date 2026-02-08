// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return _MessageModel.fromJson(json);
}

/// @nodoc
mixin _$MessageModel {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'Created Date')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'Title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'category')
  String get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'startDate')
  DateTime get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'endDate')
  DateTime? get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'titleImage')
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'externalLink')
  String get externalLink => throw _privateConstructorUsedError;

  /// Serializes this MessageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageModelCopyWith<MessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageModelCopyWith<$Res> {
  factory $MessageModelCopyWith(
          MessageModel value, $Res Function(MessageModel) then) =
      _$MessageModelCopyWithImpl<$Res, MessageModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      @JsonKey(name: 'Created Date') DateTime createdAt,
      @JsonKey(name: 'Title') String title,
      @JsonKey(name: 'message') String message,
      @JsonKey(name: 'category') String category,
      @JsonKey(name: 'startDate') DateTime startDate,
      @JsonKey(name: 'endDate') DateTime? endDate,
      @JsonKey(name: 'titleImage') String imageUrl,
      @JsonKey(name: 'externalLink') String externalLink});
}

/// @nodoc
class _$MessageModelCopyWithImpl<$Res, $Val extends MessageModel>
    implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageModel
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
abstract class _$$MessageModelImplCopyWith<$Res>
    implements $MessageModelCopyWith<$Res> {
  factory _$$MessageModelImplCopyWith(
          _$MessageModelImpl value, $Res Function(_$MessageModelImpl) then) =
      __$$MessageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      @JsonKey(name: 'Created Date') DateTime createdAt,
      @JsonKey(name: 'Title') String title,
      @JsonKey(name: 'message') String message,
      @JsonKey(name: 'category') String category,
      @JsonKey(name: 'startDate') DateTime startDate,
      @JsonKey(name: 'endDate') DateTime? endDate,
      @JsonKey(name: 'titleImage') String imageUrl,
      @JsonKey(name: 'externalLink') String externalLink});
}

/// @nodoc
class __$$MessageModelImplCopyWithImpl<$Res>
    extends _$MessageModelCopyWithImpl<$Res, _$MessageModelImpl>
    implements _$$MessageModelImplCopyWith<$Res> {
  __$$MessageModelImplCopyWithImpl(
      _$MessageModelImpl _value, $Res Function(_$MessageModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageModel
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
    return _then(_$MessageModelImpl(
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
@JsonSerializable()
class _$MessageModelImpl extends _MessageModel {
  const _$MessageModelImpl(
      {@JsonKey(name: '_id') required this.id,
      @JsonKey(name: 'Created Date') required this.createdAt,
      @JsonKey(name: 'Title') required this.title,
      @JsonKey(name: 'message') required this.message,
      @JsonKey(name: 'category') required this.category,
      @JsonKey(name: 'startDate') required this.startDate,
      @JsonKey(name: 'endDate') this.endDate,
      @JsonKey(name: 'titleImage') this.imageUrl = '',
      @JsonKey(name: 'externalLink') this.externalLink = ''})
      : super._();

  factory _$MessageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  @JsonKey(name: 'Created Date')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'Title')
  final String title;
  @override
  @JsonKey(name: 'message')
  final String message;
  @override
  @JsonKey(name: 'category')
  final String category;
  @override
  @JsonKey(name: 'startDate')
  final DateTime startDate;
  @override
  @JsonKey(name: 'endDate')
  final DateTime? endDate;
  @override
  @JsonKey(name: 'titleImage')
  final String imageUrl;
  @override
  @JsonKey(name: 'externalLink')
  final String externalLink;

  @override
  String toString() {
    return 'MessageModel(id: $id, createdAt: $createdAt, title: $title, message: $message, category: $category, startDate: $startDate, endDate: $endDate, imageUrl: $imageUrl, externalLink: $externalLink)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, title, message,
      category, startDate, endDate, imageUrl, externalLink);

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageModelImplCopyWith<_$MessageModelImpl> get copyWith =>
      __$$MessageModelImplCopyWithImpl<_$MessageModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageModelImplToJson(
      this,
    );
  }
}

abstract class _MessageModel extends MessageModel {
  const factory _MessageModel(
          {@JsonKey(name: '_id') required final String id,
          @JsonKey(name: 'Created Date') required final DateTime createdAt,
          @JsonKey(name: 'Title') required final String title,
          @JsonKey(name: 'message') required final String message,
          @JsonKey(name: 'category') required final String category,
          @JsonKey(name: 'startDate') required final DateTime startDate,
          @JsonKey(name: 'endDate') final DateTime? endDate,
          @JsonKey(name: 'titleImage') final String imageUrl,
          @JsonKey(name: 'externalLink') final String externalLink}) =
      _$MessageModelImpl;
  const _MessageModel._() : super._();

  factory _MessageModel.fromJson(Map<String, dynamic> json) =
      _$MessageModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  @JsonKey(name: 'Created Date')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'Title')
  String get title;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'category')
  String get category;
  @override
  @JsonKey(name: 'startDate')
  DateTime get startDate;
  @override
  @JsonKey(name: 'endDate')
  DateTime? get endDate;
  @override
  @JsonKey(name: 'titleImage')
  String get imageUrl;
  @override
  @JsonKey(name: 'externalLink')
  String get externalLink;

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageModelImplCopyWith<_$MessageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

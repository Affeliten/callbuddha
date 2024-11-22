// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WebSocketConnectionStructStruct extends BaseStruct {
  WebSocketConnectionStructStruct({
    bool? isConnected,
    DateTime? lastMessageTimestamp,
    String? sessionId,
    String? url,
  })  : _isConnected = isConnected,
        _lastMessageTimestamp = lastMessageTimestamp,
        _sessionId = sessionId,
        _url = url;

  // "isConnected" field.
  bool? _isConnected;
  bool get isConnected => _isConnected ?? false;
  set isConnected(bool? val) => _isConnected = val;

  bool hasIsConnected() => _isConnected != null;

  // "lastMessageTimestamp" field.
  DateTime? _lastMessageTimestamp;
  DateTime? get lastMessageTimestamp => _lastMessageTimestamp;
  set lastMessageTimestamp(DateTime? val) => _lastMessageTimestamp = val;

  bool hasLastMessageTimestamp() => _lastMessageTimestamp != null;

  // "sessionId" field.
  String? _sessionId;
  String get sessionId => _sessionId ?? '';
  set sessionId(String? val) => _sessionId = val;

  bool hasSessionId() => _sessionId != null;

  // "url" field.
  String? _url;
  String get url => _url ?? '';
  set url(String? val) => _url = val;

  bool hasUrl() => _url != null;

  static WebSocketConnectionStructStruct fromMap(Map<String, dynamic> data) =>
      WebSocketConnectionStructStruct(
        isConnected: data['isConnected'] as bool?,
        lastMessageTimestamp: data['lastMessageTimestamp'] as DateTime?,
        sessionId: data['sessionId'] as String?,
        url: data['url'] as String?,
      );

  static WebSocketConnectionStructStruct? maybeFromMap(dynamic data) => data
          is Map
      ? WebSocketConnectionStructStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'isConnected': _isConnected,
        'lastMessageTimestamp': _lastMessageTimestamp,
        'sessionId': _sessionId,
        'url': _url,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'isConnected': serializeParam(
          _isConnected,
          ParamType.bool,
        ),
        'lastMessageTimestamp': serializeParam(
          _lastMessageTimestamp,
          ParamType.DateTime,
        ),
        'sessionId': serializeParam(
          _sessionId,
          ParamType.String,
        ),
        'url': serializeParam(
          _url,
          ParamType.String,
        ),
      }.withoutNulls;

  static WebSocketConnectionStructStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      WebSocketConnectionStructStruct(
        isConnected: deserializeParam(
          data['isConnected'],
          ParamType.bool,
          false,
        ),
        lastMessageTimestamp: deserializeParam(
          data['lastMessageTimestamp'],
          ParamType.DateTime,
          false,
        ),
        sessionId: deserializeParam(
          data['sessionId'],
          ParamType.String,
          false,
        ),
        url: deserializeParam(
          data['url'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'WebSocketConnectionStructStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is WebSocketConnectionStructStruct &&
        isConnected == other.isConnected &&
        lastMessageTimestamp == other.lastMessageTimestamp &&
        sessionId == other.sessionId &&
        url == other.url;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([isConnected, lastMessageTimestamp, sessionId, url]);
}

WebSocketConnectionStructStruct createWebSocketConnectionStructStruct({
  bool? isConnected,
  DateTime? lastMessageTimestamp,
  String? sessionId,
  String? url,
}) =>
    WebSocketConnectionStructStruct(
      isConnected: isConnected,
      lastMessageTimestamp: lastMessageTimestamp,
      sessionId: sessionId,
      url: url,
    );

import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = const FlutterSecureStorage();
    await _safeInitAsync(() async {
      _openAiKey = await secureStorage.getString('ff_openAiKey') ?? _openAiKey;
    });
    await _safeInitAsync(() async {
      _AssistantId =
          await secureStorage.getString('ff_AssistantId') ?? _AssistantId;
    });
    await _safeInitAsync(() async {
      _lastConversationTimestamp =
          await secureStorage.read(key: 'ff_lastConversationTimestamp') != null
              ? DateTime.fromMillisecondsSinceEpoch(
                  (await secureStorage.getInt('ff_lastConversationTimestamp'))!)
              : _lastConversationTimestamp;
    });
    await _safeInitAsync(() async {
      _openAIKey = await secureStorage.getString('ff_openAIKey') ?? _openAIKey;
    });
    await _safeInitAsync(() async {
      _accessToken =
          await secureStorage.getString('ff_accessToken') ?? _accessToken;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  String _openAiKey =
      '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';
  String get openAiKey => _openAiKey;
  set openAiKey(String value) {
    _openAiKey = value;
    secureStorage.setString('ff_openAiKey', value);
  }

  void deleteOpenAiKey() {
    secureStorage.delete(key: 'ff_openAiKey');
  }

  String _AssistantId = 'asst_JYUzDrQK7uIdguDjMTeV8a0o';
  String get AssistantId => _AssistantId;
  set AssistantId(String value) {
    _AssistantId = value;
    secureStorage.setString('ff_AssistantId', value);
  }

  void deleteAssistantId() {
    secureStorage.delete(key: 'ff_AssistantId');
  }

  String _threadId = '';
  String get threadId => _threadId;
  set threadId(String value) {
    _threadId = value;
  }

  String _conversationId = '';
  String get conversationId => _conversationId;
  set conversationId(String value) {
    _conversationId = value;
  }

  bool _isListening = false;
  bool get isListening => _isListening;
  set isListening(bool value) {
    _isListening = value;
  }

  bool _isBuddhaSpeaking = false;
  bool get isBuddhaSpeaking => _isBuddhaSpeaking;
  set isBuddhaSpeaking(bool value) {
    _isBuddhaSpeaking = value;
  }

  String _connectionStatus = '';
  String get connectionStatus => _connectionStatus;
  set connectionStatus(String value) {
    _connectionStatus = value;
  }

  String _AgentID = 'l9MqH6FQEh89PFaaFMPX';
  String get AgentID => _AgentID;
  set AgentID(String value) {
    _AgentID = value;
  }

  String _ElevenLabsAPIKey =
      'sk_a68b662e6e670837ced52bc84fc6fb68a55e0eaf43966cd1';
  String get ElevenLabsAPIKey => _ElevenLabsAPIKey;
  set ElevenLabsAPIKey(String value) {
    _ElevenLabsAPIKey = value;
  }

  bool _isConversationActive = false;
  bool get isConversationActive => _isConversationActive;
  set isConversationActive(bool value) {
    _isConversationActive = value;
  }

  String _currentTranscript = '';
  String get currentTranscript => _currentTranscript;
  set currentTranscript(String value) {
    _currentTranscript = value;
  }

  String _buddhaResponse = '';
  String get buddhaResponse => _buddhaResponse;
  set buddhaResponse(String value) {
    _buddhaResponse = value;
  }

  bool _isSpeaking = false;
  bool get isSpeaking => _isSpeaking;
  set isSpeaking(bool value) {
    _isSpeaking = value;
  }

  String _selectedVoice = '';
  String get selectedVoice => _selectedVoice;
  set selectedVoice(String value) {
    _selectedVoice = value;
  }

  double _speechRate = 0.0;
  double get speechRate => _speechRate;
  set speechRate(double value) {
    _speechRate = value;
  }

  String _theme = '';
  String get theme => _theme;
  set theme(String value) {
    _theme = value;
  }

  bool _notificationEnabled = false;
  bool get notificationEnabled => _notificationEnabled;
  set notificationEnabled(bool value) {
    _notificationEnabled = value;
  }

  DateTime? _lastConversationTimestamp =
      DateTime.fromMillisecondsSinceEpoch(1731283440000);
  DateTime? get lastConversationTimestamp => _lastConversationTimestamp;
  set lastConversationTimestamp(DateTime? value) {
    _lastConversationTimestamp = value;
    value != null
        ? secureStorage.setInt(
            'ff_lastConversationTimestamp', value.millisecondsSinceEpoch)
        : secureStorage.remove('ff_lastConversationTimestamp');
  }

  void deleteLastConversationTimestamp() {
    secureStorage.delete(key: 'ff_lastConversationTimestamp');
  }

  String _userPreferences = '';
  String get userPreferences => _userPreferences;
  set userPreferences(String value) {
    _userPreferences = value;
  }

  String _buddhaAgentId = 'l9MqH6FQEh89PFaaFMPX';
  String get buddhaAgentId => _buddhaAgentId;
  set buddhaAgentId(String value) {
    _buddhaAgentId = value;
  }

  String _openAIKey =
      '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';
  String get openAIKey => _openAIKey;
  set openAIKey(String value) {
    _openAIKey = value;
    secureStorage.setString('ff_openAIKey', value);
  }

  void deleteOpenAIKey() {
    secureStorage.delete(key: 'ff_openAIKey');
  }

  bool _isWebSocketOpen = false;
  bool get isWebSocketOpen => _isWebSocketOpen;
  set isWebSocketOpen(bool value) {
    _isWebSocketOpen = value;
  }

  String _sessionId = '';
  String get sessionId => _sessionId;
  set sessionId(String value) {
    _sessionId = value;
  }

  List<dynamic> _conversationHistory = [];
  List<dynamic> get conversationHistory => _conversationHistory;
  set conversationHistory(List<dynamic> value) {
    _conversationHistory = value;
  }

  void addToConversationHistory(dynamic value) {
    conversationHistory.add(value);
  }

  void removeFromConversationHistory(dynamic value) {
    conversationHistory.remove(value);
  }

  void removeAtIndexFromConversationHistory(int index) {
    conversationHistory.removeAt(index);
  }

  void updateConversationHistoryAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    conversationHistory[index] = updateFn(_conversationHistory[index]);
  }

  void insertAtIndexInConversationHistory(int index, dynamic value) {
    conversationHistory.insert(index, value);
  }

  WebSocketConnectionStructStruct _buddhaWSConnection =
      WebSocketConnectionStructStruct();
  WebSocketConnectionStructStruct get buddhaWSConnection => _buddhaWSConnection;
  set buddhaWSConnection(WebSocketConnectionStructStruct value) {
    _buddhaWSConnection = value;
  }

  void updateBuddhaWSConnectionStruct(
      Function(WebSocketConnectionStructStruct) updateFn) {
    updateFn(_buddhaWSConnection);
  }

  List<String> _audioBuffer = [];
  List<String> get audioBuffer => _audioBuffer;
  set audioBuffer(List<String> value) {
    _audioBuffer = value;
  }

  void addToAudioBuffer(String value) {
    audioBuffer.add(value);
  }

  void removeFromAudioBuffer(String value) {
    audioBuffer.remove(value);
  }

  void removeAtIndexFromAudioBuffer(int index) {
    audioBuffer.removeAt(index);
  }

  void updateAudioBufferAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    audioBuffer[index] = updateFn(_audioBuffer[index]);
  }

  void insertAtIndexInAudioBuffer(int index, String value) {
    audioBuffer.insert(index, value);
  }

  String _accessToken = '';
  String get accessToken => _accessToken;
  set accessToken(String value) {
    _accessToken = value;
    secureStorage.setString('ff_accessToken', value);
  }

  void deleteAccessToken() {
    secureStorage.delete(key: 'ff_accessToken');
  }

  bool _isRecording = false;
  bool get isRecording => _isRecording;
  set isRecording(bool value) {
    _isRecording = value;
  }

  String _lastRecordingPath = '';
  String get lastRecordingPath => _lastRecordingPath;
  set lastRecordingPath(String value) {
    _lastRecordingPath = value;
  }

  bool _isPlayingAudio = false;
  bool get isPlayingAudio => _isPlayingAudio;
  set isPlayingAudio(bool value) {
    _isPlayingAudio = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return const CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: const ListToCsvConverter().convert([value]));
}

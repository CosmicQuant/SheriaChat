import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

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
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _expandMenu = prefs.getBool('ff_expandMenu') ?? _expandMenu;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _expandMenu = false;
  bool get expandMenu => _expandMenu;
  set expandMenu(bool _value) {
    _expandMenu = _value;
    prefs.setBool('ff_expandMenu', _value);
  }

  DocumentReference? _activeChat;
  DocumentReference? get activeChat => _activeChat;
  set activeChat(DocumentReference? _value) {
    _activeChat = _value;
  }

  String _newName = '';
  String get newName => _newName;
  set newName(String _value) {
    _newName = _value;
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

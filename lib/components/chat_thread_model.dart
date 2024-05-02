import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/empty_list_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'chat_thread_widget.dart' show ChatThreadWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatThreadModel extends FlutterFlowModel<ChatThreadWidget> {
  ///  Local state fields for this component.

  List<MessageStruct> conversation = [];
  void addToConversation(MessageStruct item) => conversation.add(item);
  void removeFromConversation(MessageStruct item) => conversation.remove(item);
  void removeAtIndexFromConversation(int index) => conversation.removeAt(index);
  void insertAtIndexInConversation(int index, MessageStruct item) =>
      conversation.insert(index, item);
  void updateConversationAtIndex(int index, Function(MessageStruct) updateFn) =>
      conversation[index] = updateFn(conversation[index]);

  ///  State fields for stateful widgets in this component.

  // State field(s) for ListView widget.
  ScrollController? listViewController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (gemini)] action in Button widget.
  ApiCallResponse? createdText;

  @override
  void initState(BuildContext context) {
    listViewController = ScrollController();
  }

  @override
  void dispose() {
    listViewController?.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}

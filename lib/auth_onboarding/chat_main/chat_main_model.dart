import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/conversation_card_widget.dart';
import '/components/dark_switch_widget.dart';
import '/components/dropdown_edit_conversation_widget.dart';
import '/components/thread_chats_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import '/flutter_flow/request_manager.dart';

import 'chat_main_widget.dart' show ChatMainWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatMainModel extends FlutterFlowModel<ChatMainWidget> {
  ///  Local state fields for this page.

  DocumentReference? activeChat;

  bool hasActiveChat = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered = false;
  // Stores action output result for [Backend Call - Create Document] action in Container widget.
  ConversationsRecord? newConversation;
  // Models for conversationCard dynamic component.
  late FlutterFlowDynamicModels<ConversationCardModel> conversationCardModels;
  // Model for darkSwitch component.
  late DarkSwitchModel darkSwitchModel;
  // Model for thread_Chats component.
  late ThreadChatsModel threadChatsModel;

  /// Query cache managers for this widget.

  final _conversationsManager =
      StreamRequestManager<List<ConversationsRecord>>();
  Stream<List<ConversationsRecord>> conversations({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<ConversationsRecord>> Function() requestFn,
  }) =>
      _conversationsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearConversationsCache() => _conversationsManager.clear();
  void clearConversationsCacheKey(String? uniqueKey) =>
      _conversationsManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {
    conversationCardModels =
        FlutterFlowDynamicModels(() => ConversationCardModel());
    darkSwitchModel = createModel(context, () => DarkSwitchModel());
    threadChatsModel = createModel(context, () => ThreadChatsModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    conversationCardModels.dispose();
    darkSwitchModel.dispose();
    threadChatsModel.dispose();

    /// Dispose query cache managers for this widget.

    clearConversationsCache();
  }
}

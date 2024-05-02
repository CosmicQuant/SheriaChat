import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'thread_chats_model.dart';
export 'thread_chats_model.dart';

class ThreadChatsWidget extends StatefulWidget {
  const ThreadChatsWidget({
    super.key,
    required this.conversationRef,
  });

  final DocumentReference? conversationRef;

  @override
  State<ThreadChatsWidget> createState() => _ThreadChatsWidgetState();
}

class _ThreadChatsWidgetState extends State<ThreadChatsWidget> {
  late ThreadChatsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ThreadChatsModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.textController?.clear();
      });
      setState(() {
        _model.conversation =
            _model.conversation.toList().cast<MessageStruct>();
      });
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConversationsRecord>(
      stream: ConversationsRecord.getDocument(widget.conversationRef!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  FlutterFlowTheme.of(context).primary,
                ),
              ),
            ),
          );
        }
        final cardCommentConversationsRecord = snapshot.data!;
        return Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxWidth: 700.0,
          ),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(0.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: StreamBuilder<List<ConversationsRecord>>(
                  stream: queryConversationsRecord(
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ),
                      );
                    }
                    List<ConversationsRecord> listViewConversationsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final listViewConversationsRecord =
                        listViewConversationsRecordList.isNotEmpty
                            ? listViewConversationsRecordList.first
                            : null;
                    return Builder(
                      builder: (context) {
                        final chatMessages = cardCommentConversationsRecord
                            .conversation
                            .toList();
                        return ListView.separated(
                          padding: EdgeInsets.fromLTRB(
                            0,
                            0,
                            0,
                            24.0,
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: chatMessages.length,
                          separatorBuilder: (_, __) => SizedBox(height: 0.0),
                          itemBuilder: (context, chatMessagesIndex) {
                            final chatMessagesItem =
                                chatMessages[chatMessagesIndex];
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Builder(
                                  builder: (context) {
                                    if (!chatMessagesItem.userSent) {
                                      return Container(
                                        decoration: BoxDecoration(),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 8.0, 12.0, 8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 36.0,
                                                    height: 36.0,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .balanceScale,
                                                        size: 22.0,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      'Sheria AI',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyLarge
                                                          .override(
                                                            fontFamily:
                                                                'Instrument Sans',
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ),
                                                  Text(
                                                    dateTimeFormat(
                                                        'relative',
                                                        chatMessagesItem
                                                            .timeCreated!),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelSmall
                                                        .override(
                                                          fontFamily: 'Figtree',
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(width: 12.0)),
                                              ),
                                              Text(
                                                chatMessagesItem.text,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Instrument Sans',
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ].divide(SizedBox(height: 8.0)),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        decoration: BoxDecoration(),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 8.0, 12.0, 8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 36.0,
                                                    height: 36.0,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child:
                                                          AuthUserStreamWidget(
                                                        builder: (context) =>
                                                            Text(
                                                          valueOrDefault<
                                                              String>(
                                                            currentUserDisplayName,
                                                            'A',
                                                          ).maybeHandleOverflow(
                                                              maxChars: 1),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineSmall
                                                              .override(
                                                                fontFamily:
                                                                    'Figtree',
                                                                fontSize: 20.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: AuthUserStreamWidget(
                                                      builder: (context) =>
                                                          Text(
                                                        currentUserDisplayName,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Instrument Sans',
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    dateTimeFormat(
                                                        'relative',
                                                        chatMessagesItem
                                                            .timeCreated!),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelSmall
                                                        .override(
                                                          fontFamily: 'Figtree',
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(width: 12.0)),
                                              ),
                                              Text(
                                                chatMessagesItem.text,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .override(
                                                          fontFamily: 'Figtree',
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ].divide(SizedBox(height: 8.0)),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                          controller: _model.listViewController,
                        );
                      },
                    );
                  },
                ),
              ),
              Divider(
                height: 1.0,
                thickness: 1.0,
                color: FlutterFlowTheme.of(context).alternate,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 36.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional(1.0, 1.0),
                    children: [
                      Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _model.textController,
                          focusNode: _model.textFieldFocusNode,
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Figtree',
                                  letterSpacing: 0.0,
                                ),
                            alignLabelWithHint: false,
                            hintText: 'message',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Figtree',
                                  letterSpacing: 0.0,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            filled: true,
                            fillColor: (_model.textFieldFocusNode?.hasFocus ??
                                    false)
                                ? FlutterFlowTheme.of(context).primaryBackground
                                : FlutterFlowTheme.of(context)
                                    .primaryBackground,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 90.0, 16.0),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Instrument Sans',
                                    letterSpacing: 0.0,
                                  ),
                          maxLines: 8,
                          minLines: 2,
                          validator: _model.textControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(1.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 8.0, 8.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              // myMessage

                              await cardCommentConversationsRecord.reference
                                  .update({
                                ...createConversationsRecordData(
                                  name: cardCommentConversationsRecord
                                          .hasConversation()
                                      ? cardCommentConversationsRecord
                                          .conversation.first.text
                                      : _model.textController.text,
                                ),
                                ...mapToFirestore(
                                  {
                                    'conversation': FieldValue.arrayUnion([
                                      getMessageFirestoreData(
                                        updateMessageStruct(
                                          MessageStruct(
                                            text: _model.textController.text,
                                            userSent: true,
                                            timeCreated: getCurrentTimestamp,
                                            type: 'prompt',
                                          ),
                                          clearUnsetFields: false,
                                        ),
                                        true,
                                      )
                                    ]),
                                  },
                                ),
                              });
                              setState(() {
                                _model.addToConversation(MessageStruct(
                                  text: _model.textController.text,
                                  userSent: true,
                                  timeCreated: getCurrentTimestamp,
                                  type: 'prompt',
                                ));
                                _model.currentConversation =
                                    cardCommentConversationsRecord;
                              });
                              unawaited(
                                () async {
                                  await _model.listViewController?.animateTo(
                                    _model.listViewController!.position
                                        .maxScrollExtent,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.ease,
                                  );
                                }(),
                              );
                              _model.listMessages =
                                  await ConversationsRecord.getDocumentOnce(
                                      cardCommentConversationsRecord.reference);
                              _model.createdText = await GeminiCall.call(
                                query: _model.textController.text,
                              );
                              setState(() {
                                _model.textController?.clear();
                              });
                              // geminiResponse

                              await cardCommentConversationsRecord.reference
                                  .update({
                                ...mapToFirestore(
                                  {
                                    'conversation': FieldValue.arrayUnion([
                                      getMessageFirestoreData(
                                        updateMessageStruct(
                                          MessageStruct(
                                            text: getJsonField(
                                              (_model.createdText?.jsonBody ??
                                                  ''),
                                              r'''$.reply.summary.summaryWithMetadata.summary''',
                                            ).toString(),
                                            userSent: false,
                                            timeCreated: getCurrentTimestamp,
                                            type: 'response',
                                          ),
                                          clearUnsetFields: false,
                                        ),
                                        true,
                                      )
                                    ]),
                                  },
                                ),
                              });
                              // showResponse
                              setState(() {
                                _model.addToConversation(MessageStruct(
                                  text: getJsonField(
                                    (_model.createdText?.jsonBody ?? ''),
                                    r'''$''',
                                  ).toString(),
                                  userSent: false,
                                  timeCreated: getCurrentTimestamp,
                                  type: 'response',
                                ));
                              });
                              await Future.delayed(
                                  const Duration(milliseconds: 1000));
                              unawaited(
                                () async {
                                  await _model.listViewController?.animateTo(
                                    _model.listViewController!.position
                                        .maxScrollExtent,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.ease,
                                  );
                                }(),
                              );

                              setState(() {});
                            },
                            text: 'Send',
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 12.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Colors.black,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Instrument Sans',
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(44.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ].divide(SizedBox(height: 0.0)),
          ),
        );
      },
    );
  }
}

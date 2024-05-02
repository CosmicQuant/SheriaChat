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
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chat_thread_model.dart';
export 'chat_thread_model.dart';

class ChatThreadWidget extends StatefulWidget {
  const ChatThreadWidget({super.key});

  @override
  State<ChatThreadWidget> createState() => _ChatThreadWidgetState();
}

class _ChatThreadWidgetState extends State<ChatThreadWidget> {
  late ChatThreadModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatThreadModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.textController?.clear();
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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 56.0, 16.0, 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                FlutterFlowIconButton(
                  borderColor: FlutterFlowTheme.of(context).primaryBackground,
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  fillColor: FlutterFlowTheme.of(context).primaryBackground,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    context.safePop();
                  },
                ),
              ],
            ),
          ),
          Divider(
            height: 1.0,
            thickness: 1.0,
            color: FlutterFlowTheme.of(context).alternate,
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                final messages = _model.conversation.toList();
                if (messages.isEmpty) {
                  return EmptyListWidget();
                }
                return ListView.separated(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    0,
                    0,
                    12.0,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: messages.length,
                  separatorBuilder: (_, __) => SizedBox(height: 0.0),
                  itemBuilder: (context, messagesIndex) {
                    final messagesItem = messages[messagesIndex];
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Builder(
                          builder: (context) {
                            if (!messagesItem.userSent) {
                              return Container(
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
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
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: FaIcon(
                                                FontAwesomeIcons.balanceScale,
                                                size: 22.0,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Gemini Ai',
                                              style:
                                                  FlutterFlowTheme.of(context)
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
                                            dateTimeFormat('relative',
                                                messagesItem.timeCreated!),
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  fontFamily: 'Figtree',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 12.0)),
                                      ),
                                      Text(
                                        messagesItem.text,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Instrument Sans',
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
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
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: AuthUserStreamWidget(
                                                builder: (context) => Text(
                                                  valueOrDefault<String>(
                                                    currentUserDisplayName,
                                                    'A',
                                                  ).maybeHandleOverflow(
                                                      maxChars: 1),
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .headlineSmall
                                                      .override(
                                                        fontFamily: 'Figtree',
                                                        fontSize: 20.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: AuthUserStreamWidget(
                                              builder: (context) => Text(
                                                currentUserDisplayName,
                                                style:
                                                    FlutterFlowTheme.of(context)
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
                                          ),
                                          Text(
                                            dateTimeFormat('relative',
                                                messagesItem.timeCreated!),
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  fontFamily: 'Figtree',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 12.0)),
                                      ),
                                      Text(
                                        messagesItem.text,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Instrument Sans',
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
                borderRadius: BorderRadius.circular(12.0),
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
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Figtree',
                                  letterSpacing: 0.0,
                                ),
                        alignLabelWithHint: true,
                        hintText: 'message',
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
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
                            : FlutterFlowTheme.of(context).primaryBackground,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 100.0, 16.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Instrument Sans',
                            letterSpacing: 0.0,
                          ),
                      maxLines: 8,
                      minLines: 2,
                      validator:
                          _model.textControllerValidator.asValidator(context),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(1.0, 1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 12.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          // updatePrompt
                          setState(() {
                            _model.addToConversation(MessageStruct(
                              text: _model.textController.text,
                              userSent: true,
                              timeCreated: getCurrentTimestamp,
                              type: 'prompt',
                            ));
                          });
                          unawaited(
                            () async {
                              await _model.listViewController?.animateTo(
                                _model.listViewController!.position
                                    .maxScrollExtent,
                                duration: Duration(milliseconds: 100),
                                curve: Curves.ease,
                              );
                            }(),
                          );
                          _model.createdText = await GeminiCall.call(
                            query: _model.textController.text,
                          );
                          setState(() {
                            _model.textController?.clear();
                          });
                          // showResponse
                          setState(() {
                            _model.addToConversation(MessageStruct(
                              text: getJsonField(
                                (_model.createdText?.jsonBody ?? ''),
                                r'''$.reply.summary.summaryWithMetadata.summary''',
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
                          height: 36.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 12.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Colors.black,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Instrument Sans',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
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
  }
}

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
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chat_main_model.dart';
export 'chat_main_model.dart';

class ChatMainWidget extends StatefulWidget {
  const ChatMainWidget({super.key});

  @override
  State<ChatMainWidget> createState() => _ChatMainWidgetState();
}

class _ChatMainWidgetState extends State<ChatMainWidget>
    with TickerProviderStateMixin {
  late ChatMainModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatMainModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.hasActiveChat = false;
      });
    });

    animationsMap.addAll({
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 50.ms),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 100.0.ms,
            begin: Offset(-8.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 100.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'columnOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 100.0.ms,
            begin: Offset(0.0, 12.0),
            end: Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 100.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: valueOrDefault<double>(
                  () {
                    if ((MediaQuery.sizeOf(context).width <= 571.0) &&
                        !FFAppState().expandMenu) {
                      return 0.0;
                    } else if (FFAppState().expandMenu) {
                      return 300.0;
                    } else {
                      return 72.0;
                    }
                  }(),
                  300.0,
                ),
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 8.0, 16.0, 8.0),
                        child: FlutterFlowIconButton(
                          borderColor: FlutterFlowTheme.of(context).accent4,
                          borderRadius: 44.0,
                          borderWidth: 2.0,
                          buttonSize: 40.0,
                          fillColor: FlutterFlowTheme.of(context).accent4,
                          icon: Icon(
                            Icons.menu_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            setState(() {
                              FFAppState().expandMenu =
                                  !FFAppState().expandMenu;
                            });
                          },
                        ),
                      ),
                      MouseRegion(
                        opaque: true,
                        cursor: SystemMouseCursors.click ?? MouseCursor.defer,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 8.0, 16.0, 8.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              var conversationsRecordReference =
                                  ConversationsRecord.collection.doc();
                              await conversationsRecordReference
                                  .set(createConversationsRecordData(
                                userRef: currentUserReference,
                                timeCreated: getCurrentTimestamp,
                                timeEdited: getCurrentTimestamp,
                                id: random_data.randomInteger(0, 1000000000),
                              ));
                              _model.newConversation =
                                  ConversationsRecord.getDocumentFromData(
                                      createConversationsRecordData(
                                        userRef: currentUserReference,
                                        timeCreated: getCurrentTimestamp,
                                        timeEdited: getCurrentTimestamp,
                                        id: random_data.randomInteger(
                                            0, 1000000000),
                                      ),
                                      conversationsRecordReference);
                              setState(() {
                                _model.activeChat =
                                    _model.newConversation?.reference;
                                _model.hasActiveChat = true;
                              });

                              setState(() {});
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              width: valueOrDefault<double>(
                                FFAppState().expandMenu ? 136.0 : 40.0,
                                136.0,
                              ),
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: _model.mouseRegionHovered!
                                    ? FlutterFlowTheme.of(context)
                                        .primaryBackground
                                    : FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                borderRadius: BorderRadius.circular(44.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  width: 0.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    valueOrDefault<double>(
                                      FFAppState().expandMenu ? 8.0 : 0.0,
                                      0.0,
                                    ),
                                    0.0,
                                    valueOrDefault<double>(
                                      FFAppState().expandMenu ? 8.0 : 0.0,
                                      0.0,
                                    ),
                                    0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Icon(
                                        Icons.add_rounded,
                                        color: _model.mouseRegionHovered!
                                            ? FlutterFlowTheme.of(context)
                                                .primaryText
                                            : FlutterFlowTheme.of(context)
                                                .primaryText,
                                        size: 28.0,
                                      ),
                                    ),
                                    if (FFAppState().expandMenu)
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 12.0, 0.0),
                                        child: Text(
                                          'New Chat',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Instrument Sans',
                                                color:
                                                    _model.mouseRegionHovered!
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                letterSpacing: 0.0,
                                              ),
                                        ).animateOnPageLoad(animationsMap[
                                            'textOnPageLoadAnimation']!),
                                      ),
                                  ]
                                      .divide(SizedBox(width: 8.0))
                                      .addToStart(SizedBox(width: 4.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        onEnter: ((event) async {
                          setState(() => _model.mouseRegionHovered = true);
                        }),
                        onExit: ((event) async {
                          setState(() => _model.mouseRegionHovered = false);
                        }),
                      ),
                      if (FFAppState().expandMenu)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recents',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Instrument Sans',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: StreamBuilder<List<ConversationsRecord>>(
                                  stream: _model.conversations(
                                    overrideCache: _model.hasActiveChat != null,
                                    requestFn: () => queryConversationsRecord(
                                      queryBuilder: (conversationsRecord) =>
                                          conversationsRecord
                                              .where(
                                                'userRef',
                                                isEqualTo: currentUserReference,
                                              )
                                              .orderBy('timeEdited',
                                                  descending: true),
                                      limit: 8,
                                    ),
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50.0,
                                          height: 50.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<ConversationsRecord>
                                        listViewConversationsRecordList =
                                        snapshot.data!;
                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: listViewConversationsRecordList
                                          .length,
                                      itemBuilder: (context, listViewIndex) {
                                        final listViewConversationsRecord =
                                            listViewConversationsRecordList[
                                                listViewIndex];
                                        return Builder(
                                          builder: (context) => InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              setState(() {
                                                _model.activeChat =
                                                    listViewConversationsRecord
                                                        .reference;
                                                _model.hasActiveChat = true;
                                              });
                                            },
                                            child: wrapWithModel(
                                              model: _model
                                                  .conversationCardModels
                                                  .getModel(
                                                listViewConversationsRecord
                                                    .reference.id,
                                                listViewIndex,
                                              ),
                                              updateCallback: () =>
                                                  setState(() {}),
                                              updateOnChange: true,
                                              child: ConversationCardWidget(
                                                key: Key(
                                                  'Keyo4i_${listViewConversationsRecord.reference.id}',
                                                ),
                                                convoName:
                                                    listViewConversationsRecord
                                                        .name,
                                                action: () async {
                                                  await showAlignedDialog(
                                                    context: context,
                                                    isGlobal: false,
                                                    avoidOverflow: true,
                                                    targetAnchor:
                                                        AlignmentDirectional(
                                                                1.0, 0.0)
                                                            .resolve(
                                                                Directionality.of(
                                                                    context)),
                                                    followerAnchor:
                                                        AlignmentDirectional(
                                                                -1.0, 0.0)
                                                            .resolve(
                                                                Directionality.of(
                                                                    context)),
                                                    builder: (dialogContext) {
                                                      return Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: GestureDetector(
                                                          onTap: () => _model
                                                                  .unfocusNode
                                                                  .canRequestFocus
                                                              ? FocusScope.of(
                                                                      context)
                                                                  .requestFocus(
                                                                      _model
                                                                          .unfocusNode)
                                                              : FocusScope.of(
                                                                      context)
                                                                  .unfocus(),
                                                          child:
                                                              DropdownEditConversationWidget(
                                                            renameAction:
                                                                () async {
                                                              await listViewConversationsRecord
                                                                  .reference
                                                                  .update(
                                                                      createConversationsRecordData(
                                                                name:
                                                                    FFAppState()
                                                                        .newName,
                                                              ));
                                                              setState(() {
                                                                FFAppState()
                                                                    .newName = '';
                                                              });
                                                            },
                                                            deleteAction:
                                                                () async {
                                                              await listViewConversationsRecord
                                                                  .reference
                                                                  .delete();
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      setState(() {}));
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ].divide(SizedBox(height: 8.0)),
                          ).animateOnPageLoad(
                              animationsMap['columnOnPageLoadAnimation']!),
                        ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              wrapWithModel(
                                model: _model.darkSwitchModel,
                                updateCallback: () => setState(() {}),
                                child: DarkSwitchWidget(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (responsiveVisibility(
                            context: context,
                            tabletLandscape: false,
                            desktop: false,
                          ))
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 8.0),
                              child: FlutterFlowIconButton(
                                borderColor:
                                    FlutterFlowTheme.of(context).accent4,
                                borderRadius: 44.0,
                                borderWidth: 2.0,
                                buttonSize: 40.0,
                                fillColor: FlutterFlowTheme.of(context).accent4,
                                icon: Icon(
                                  Icons.menu_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    FFAppState().expandMenu =
                                        !FFAppState().expandMenu;
                                  });
                                },
                              ),
                            ),
                          Expanded(
                            child: Text(
                              'Sheria Chat',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    fontFamily: 'Figtree',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            width: 44.0,
                            height: 44.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed('profilePage');
                              },
                              child: Icon(
                                Icons.person,
                                size: 24.0,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 16.0)),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(0.0, -1.0),
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: 1000.0,
                          ),
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (!_model.hasActiveChat)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 16.0, 0.0, 0.0),
                                        child: Text(
                                          'Hello.',
                                          style: FlutterFlowTheme.of(context)
                                              .displayLarge
                                              .override(
                                                fontFamily: 'Figtree',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 4.0, 0.0, 0.0),
                                        child: Text(
                                          'How can I help you today?',
                                          style: FlutterFlowTheme.of(context)
                                              .displaySmall
                                              .override(
                                                fontFamily: 'Figtree',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 12.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[]
                                              .divide(SizedBox(width: 16.0)),
                                        ),
                                      ),
                                      if (responsiveVisibility(
                                        context: context,
                                        tablet: false,
                                        tabletLandscape: false,
                                        desktop: false,
                                      ))
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 12.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[]
                                                .divide(SizedBox(width: 16.0)),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              if (_model.hasActiveChat)
                                Expanded(
                                  child: Container(
                                    width: 600.0,
                                    height: 400.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: wrapWithModel(
                                      model: _model.threadChatsModel,
                                      updateCallback: () => setState(() {}),
                                      updateOnChange: true,
                                      child: ThreadChatsWidget(
                                        conversationRef: _model.activeChat!,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

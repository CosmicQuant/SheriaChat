// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PathStruct extends FFFirebaseStruct {
  PathStruct({
    String? path,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _path = path,
        super(firestoreUtilData);

  // "path" field.
  String? _path;
  String get path => _path ?? '';
  set path(String? val) => _path = val;
  bool hasPath() => _path != null;

  static PathStruct fromMap(Map<String, dynamic> data) => PathStruct(
        path: data['path'] as String?,
      );

  static PathStruct? maybeFromMap(dynamic data) =>
      data is Map ? PathStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'path': _path,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'path': serializeParam(
          _path,
          ParamType.String,
        ),
      }.withoutNulls;

  static PathStruct fromSerializableMap(Map<String, dynamic> data) =>
      PathStruct(
        path: deserializeParam(
          data['path'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PathStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PathStruct && path == other.path;
  }

  @override
  int get hashCode => const ListEquality().hash([path]);
}

PathStruct createPathStruct({
  String? path,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PathStruct(
      path: path,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PathStruct? updatePathStruct(
  PathStruct? pathStruct, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    pathStruct
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPathStructData(
  Map<String, dynamic> firestoreData,
  PathStruct? pathStruct,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (pathStruct == null) {
    return;
  }
  if (pathStruct.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && pathStruct.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final pathStructData = getPathFirestoreData(pathStruct, forFieldValue);
  final nestedData = pathStructData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = pathStruct.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPathFirestoreData(
  PathStruct? pathStruct, [
  bool forFieldValue = false,
]) {
  if (pathStruct == null) {
    return {};
  }
  final firestoreData = mapToFirestore(pathStruct.toMap());

  // Add any Firestore field values
  pathStruct.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPathListFirestoreData(
  List<PathStruct>? pathStructs,
) =>
    pathStructs?.map((e) => getPathFirestoreData(e, true)).toList() ?? [];

import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GeminiCall {
  static Future<ApiCallResponse> call({
    String? query = '',
    String? id = '',
  }) async {
    final ffApiRequestBody = '''
{
  "query": {
    "input": "${query}"
  },
  "summarySpec": {
    "summaryResultCount": 5,
    "modelPromptSpec": {
      "preamble": "You are referencing from the Kenyan Law. When generating the summary always include the sections you have generated the summary from as a list after the summary. Given the conversation between a user and a helpful assistant and some search results, create a final answer for the assistant. The answer should use all relevant information from the search results, not introduce any additional information, and use exactly the same words as the search results when possible. The assistant's answer should be no more than 20 sentences. The user is a member of the general public who doesn't have in-depth knowledge of the subject matter. The assistant should avoid using specialized knowledge, and instead answer in a non-technical manner that anyone can understand."
    },
    "modelSpec": {
      "version": "preview"
    },
    "ignoreAdversarialQuery": true,
    "includeCitations": true
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'gemini',
      apiUrl: 'https://discoveryengine.googleapis.com/v1alpha/${id}:converse',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ya29.a0AXooCguri2f_uu-8gmgp9FUPCXMU1jJOY0gj_CmJXVFTWmtD0xvI1BwXWHtnILB4GGlGqrzIQYGnRYHA-0-refTLyA3ClVx-kWau9nHo-nVEsn8gyzHw8xiyreXApEgHl5XJLlGIRdqQUiHSCmDIcpmD3ARrA60BrPr3elqqtnN1QBDc-UYdR1pCn0himDB7djShTqQ8P5wNV8S7qUTG4frsq_xYrq9IS31hX-OCW5fQX4jmEk11lc9y6RP1XjTUjquQvSGehjrsrZrbQaP_iVm_SZlfrCDNCH-RrLcbumqh-Ia_Tw11W_efsMba6QNsxLe4TQ49ts5vzD7zhPbevtbnboE1O5-p1cnrO8Wt29lSU-aWZC8jQTPewu85EXdYAZqG2Fb8NAjWCyG0vOyu1FLA_6lEwz6maCgYKAXsSARISFQHGX2MiehkPcdORFECRdb9eiN48iw0423',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static String? response(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.reply.summary.summaryWithMetadata.summary''',
      ));
}

class CreategeminiCall {
  static Future<ApiCallResponse> call({
    String? uid = '',
  }) async {
    final ffApiRequestBody = '''
{
  "user_pseudo_id": "${uid}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'creategemini',
      apiUrl:
          'https://discoveryengine.googleapis.com/v1alpha/projects/373835513072/locations/global/collections/default_collection/dataStores/criminal-and-affordable_1714399264882/conversations/',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ya29.a0AXooCguri2f_uu-8gmgp9FUPCXMU1jJOY0gj_CmJXVFTWmtD0xvI1BwXWHtnILB4GGlGqrzIQYGnRYHA-0-refTLyA3ClVx-kWau9nHo-nVEsn8gyzHw8xiyreXApEgHl5XJLlGIRdqQUiHSCmDIcpmD3ARrA60BrPr3elqqtnN1QBDc-UYdR1pCn0himDB7djShTqQ8P5wNV8S7qUTG4frsq_xYrq9IS31hX-OCW5fQX4jmEk11lc9y6RP1XjTUjquQvSGehjrsrZrbQaP_iVm_SZlfrCDNCH-RrLcbumqh-Ia_Tw11W_efsMba6QNsxLe4TQ49ts5vzD7zhPbevtbnboE1O5-p1cnrO8Wt29lSU-aWZC8jQTPewu85EXdYAZqG2Fb8NAjWCyG0vOyu1FLA_6lEwz6maCgYKAXsSARISFQHGX2MiehkPcdORFECRdb9eiN48iw0423',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static String? id(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.name''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}

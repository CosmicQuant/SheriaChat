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
      apiUrl:
          'https://discoveryengine.googleapis.com/v1alpha/projects/373835513072/locations/global/collections/default_collection/dataStores/criminal-and-affordable_1714399264882/conversations/-:converse',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ya29.c.c0AY_VpZhhvDn8VGbp4mxwxaD-vUs9JK5-dG6q3bXKyAXcrGJA7pFCEoe3bNAUs_M0rfDJQIQioEeoBAJLeXNH-XoGCZcfNZeKmQ622IhQ3Jj2sZzDl-QzuYpyk4sCjuspd5ZFQsmocGh_ofWynNERMeV2U74r53Wv9_4nHPPHrdC9bCBKuvRrLm8T3HoZuH1ELAgIA4g9EVDU2xVt4KtiDJJ2zOTOLhsnubdXVPlSjydjHK3SPg402WkUHS21COBiK1LO9VEqsBFVMSiRJDg5hyNMUTN6OhidnhYcdbchB58wuMd4Gy1U3qLmC5GMJxQPnd1Exg_ubQbFG7HIVcTQDG91A6vYRGVwfrSEuEdASnvle2Pgm8F3O4EuAcc6i_KfOqMhtQhxunJdiaA9LGsN412PBaQxvhdz0fn0vI2S6pzRekkayR4BvM1t9bhx5ibtIUlSF4Bzk6bbQWlg5chbgYIMaarXYtQF0WMUWeWSzaxzg0v0Ol-5Zcvb8Blg_oRyWdplsJRfyU9o_fh01rSrv-n7iqzUncccV33dOBOi_040yVxX8do6r7isYIk8FM2J3Mxx1nxfJit6r9RIbjpwjj7h0jlXm_OZf_stxbs5wiyB4ZbnqtQtapngqjurtsex0kV417Oc6db_Jr9l2Rkped7e1F4QyfSOriVuMViyfOUyQgMmX6r2aRQ8uSXRI_b4JJYoyVz-sUIzIy3rdp1ySuSJ3I-0sJfyJeQtIfkfh88UIku0aSOxnaglvkvSmMBz99eqoiO7uXrpY_YIBnQv5ouIW6JyaJ6Ut0vv2MFJu7sZ0hz9nyh_4JwYw5l8yilO5hQfBvr7aIRy04wIJxOgZ1lUbYxmUWJ1MS-7i05s8fgRXIIW7tezb0q0m-x_Bj1MyXcFhzpneaIap_Oy-Bnk5r1F4va7dntl9nrwJnMB9jpIW1i-9yl7BUYs1fleSrcW1aaagBXzfF-uounp2hfMFO8lu39kQ-Xhl4rfix17Mg-2g0nq9bu262J',
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

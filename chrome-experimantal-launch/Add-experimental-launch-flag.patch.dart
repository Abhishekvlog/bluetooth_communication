import 'dart:convert';
import 'dart:html';
import '';

void main() {
  final jsonData = <String, dynamic>{
    'browser': <String, dynamic>{
      'enable_labs_experiments': <String>[
        'enable-experimental-web-platform-features',
        'enable-web-bluetooth-new-permissions-backend@1',
        'enable-web-bluetooth@1'
      ]
    }
  };

  final jsonStr = jsonEncode(jsonData);

  // Store data in localStorage
  window.localStorage['myData'] = jsonStr;

  // Retrieve data from localStorage
  final storedData = window.localStorage['myData'];
  if (storedData != null) {
    final parsedData = jsonDecode(storedData);
    print(parsedData);
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:petamin_api/petamin_api.dart';

void main() {
  group('Auth', () {
    group('fromJson', () {
      test('returns correct Auth object', () {
        expect(
            Auth.fromJson(
              <String, dynamic>{
                "accessToken":
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImtoYUBnbWFpbC5jb20iLCJ1c2VySWQiOiI5MGE1YzkwOC0zMTc4LTRlMDAtOTZjNi04ZTAwMjA1ZDQ1YTUiLCJpYXQiOjE2NjU5MTE2MDMsImV4cCI6MTY2NTk5ODAwM30.R0p-VXEqoVe_PYo3VGf59-JBVmH4rQTP95K58hQnbu8",
              },
            ),
            isA<Auth>().having((w) => w.accessToken, 'accessToken',
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImtoYUBnbWFpbC5jb20iLCJ1c2VySWQiOiI5MGE1YzkwOC0zMTc4LTRlMDAtOTZjNi04ZTAwMjA1ZDQ1YTUiLCJpYXQiOjE2NjU5MTE2MDMsImV4cCI6MTY2NTk5ODAwM30.R0p-VXEqoVe_PYo3VGf59-JBVmH4rQTP95K58hQnbu8'));
      });
    });
  });
}

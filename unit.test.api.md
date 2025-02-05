Example 1:
The repository 
```
import 'package:http/http.dart' as http;

import 'user.dart';

class UserRepository {
  final http.Client client;
  UserRepository(this.client);
  Future<User> getUser() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));
    if (response.statusCode == 200) {
      return User.fromJson(response.body);
    } else {
      throw Exception('Failed to load user');
    }
  }
}
```
repository_test.dart: 

```
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_app/user.dart';
import 'package:test_app/user.repository.dart';
import 'package:http/http.dart' as http;

class MockHTTPClient extends Mock implements http.Client {}

void main() {
  late UserRepository userRepo;
  late MockHTTPClient mockHttpClient;
  final placeholderUri =
      Uri.parse('https://jsonplaceholder.typicode.com/users/1');
  setUp(() {
    mockHttpClient = MockHTTPClient();
    userRepo = UserRepository(mockHttpClient);
  });
  group(
    'UseRepository',
    () {
      group(
        'getUser',
        () {
          test(
              'Given UserRepository class when call getUser and status code is 200 then return User        ',
              () async {
            //Arrange
            //Stubbing
            when(() => mockHttpClient.get(placeholderUri)).thenAnswer(
              (_) async => http.Response('{"name": "John", "age": "20"}', 200),
            );
            //Act
            final user = await userRepo.getUser();
            //Assert
            expect(user, isA<User>());
          });

          test(
              'Given UserRepository class when call getUser and status code is not 200 then throw Exception',
              () {
            //Arrenge
            //Stubbing
            when(() => mockHttpClient.get(placeholderUri))
                .thenAnswer((i) async => http.Response('{}', 500));
            //Act
            final user = userRepo.getUser();
            expectLater(user, throwsException);
            //Assert
          });
        },
      );
    },
  );
}

```
### example 2: GET
```
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHTTPClient extends Mock implements http.Client {}

void main() {
  late MockHTTPClient mockClient;

  setUp(() {
    mockClient = MockHTTPClient();
  });

  test('API test with Mocktail', () async {
    // Registering fallback values (Mocktail requires this for non-nullable parameters)
    registerFallbackValue(Uri());

    // Stubbing the mock to return a fake response
    when(() => mockClient.get(any()))
        .thenAnswer((_) async => http.Response('{"message": "Success"}', 200));

    // Call the mocked API
    final response = await mockClient.get(Uri.parse('https://example.com'));

    // Assertions
    expect(response.statusCode, 200);
    expect(response.body, '{"message": "Success"}');

    // Verify that the method was called once with the correct argument
    verify(() => mockClient.get(Uri.parse('https://example.com'))).called(1);
  });
}
```
### Example 3: POST 
```
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<http.Response> sendPostRequest(http.Client client, String url, Map<String, dynamic> body) async {
  final response = await client.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(body),
  );
  return response;
}
```
Test: 
```
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MockHTTPClient extends Mock implements http.Client {}

void main() {
  late MockHTTPClient mockClient;

  setUp(() {
    mockClient = MockHTTPClient();
    registerFallbackValue(Uri()); // Required for non-nullable Uri
  });

  test('POST request returns successful response', () async {
    // Arrange: Define the test data
    const String url = 'https://example.com/api';
    final Map<String, dynamic> requestBody = {'name': 'John Doe', 'age': 30};

    // Expected response
    final responseBody = jsonEncode({'success': true});
    
    // Stub the mockClient to return a fake response when post() is called
    when(() => mockClient.post(
          any(), 
          headers: any(named: 'headers'), 
          body: any(named: 'body'),
        )).thenAnswer((_) async => http.Response(responseBody, 201)); // 201 Created

    // Act: Call the function under test
    final response = await sendPostRequest(mockClient, url, requestBody);

    // Assert: Validate the response
    expect(response.statusCode, 201);
    expect(response.body, responseBody);

    // Verify the request was made with the correct parameters
    verify(() => mockClient.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestBody),
        )).called(1);
  });
}
```

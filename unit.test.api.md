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

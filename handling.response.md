## Example of a get api and handling situations 
### Example API
```
Future<Result<List<User>>> getUsers({
  required http.Client client,
  String? limit,
  String? offset,
  // required Ref<List<SingleLiveGameModel>?> ref,
  bool isFetch = false,
}) async {
  try {
    final response = await client.get(Uri.parse('https://your-api-url.com')).timeout(Duration(seconds: 10));

    if (response.statusCode == 200) {
      final res = json.decode(response.body)['data'];
      final users = res == null
          ? <User>[] // Explicitly set as List<User>
          : res.map<User>((x) => User.fromMap(x as Map<String, dynamic>)).toList();

      return Result.success(users);
    } else {
      throw Exception('Failed to get users');
    }
  } on SocketException catch (_) {
    debugPrint('No Internet Connection');
    // throw SocketException('No Internet Connection'); // Rethrow for UI to handle
    return Result.failure('No Internet Connection');
  } on FormatException {
    print('Invalid JSON format');
    return Result.failure('Invalid data format');
  } on TimeoutException {
    print('Request timed out');
    return Result.failure('Request timeout');
  } catch (e) {
    print('Unexpected error: ${e.toString()}');
    return Result.failure('Unexpected error occured');
  }
}
```
### A result class to handle different scenarios
```
class Result<T> {
  final T? data;
  final String? error;

  Result.success(this.data) : error = null;
  Result.failure(this.error) : data = null;
}
```
### A dummy user class 
```
class User {
  final int id;
  final String name;
  User({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);
}
```

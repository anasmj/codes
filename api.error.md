When using Riverpod in Flutter, error handling should be structured in a way that keeps concerns separated
- API Layer: Handle raw errors (e.g., SocketException, HttpException) and convert them into meaningful exceptions.
- Repository Layer: Process the response, throw domain-specific exceptions.
- State Management (Riverpod): Catch and expose errors via providers.
- UI Layer: Listen to state and display error messages appropriately (e.g., show a Snackbar or Dialog).

### API Layer (Service Class)
This layer communicates with the network. Here, we catch low-level exceptions like SocketException and rethrow them in a structured format
```
class ApiService {
  final Dio _dio = Dio(); // or http package

  Future<Response> getData(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw NetworkException("No internet connection");
      } else {
        throw ApiException("Failed to fetch data");
      }
    } catch (e) {
      throw UnknownException("Something went wrong");
    }
  }
}
```
### Repository Layer
This layer processes API responses and maps them to models.
```
class DataRepository {
  final ApiService _apiService;

  DataRepository(this._apiService);

  Future<List<DataModel>> fetchData() async {
    try {
      final response = await _apiService.getData("https://api.example.com/data");
      return (response.data as List).map((e) => DataModel.fromJson(e)).toList();
    } on NetworkException {
      throw DataFetchException("No internet, please try again.");
    } on ApiException {
      throw DataFetchException("Server error, try again later.");
    } catch (e) {
      throw DataFetchException("Unexpected error occurred.");
    }
  }
}
```
### State Management with Riverpod
Here, we handle the loading, success, and error states.
```
final repositoryProvider = Provider<DataRepository>((ref) {
  return DataRepository(ApiService());
});

final dataProvider = StateNotifierProvider<DataNotifier, AsyncValue<List<DataModel>>>((ref) {
  final repository = ref.watch(repositoryProvider);
  return DataNotifier(repository);
});

class DataNotifier extends StateNotifier<AsyncValue<List<DataModel>>> {
  final DataRepository _repository;

  DataNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      state = const AsyncValue.loading();
      final data = await _repository.fetchData();
      state = AsyncValue.data(data);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
```
### 
When using Riverpod in Flutter, error handling should be structured in a way that keeps concerns separated:

API Layer: Handle raw errors (e.g., SocketException, HttpException) and convert them into meaningful exceptions.
Repository Layer: Process the response, throw domain-specific exceptions.
State Management (Riverpod): Catch and expose errors via providers.
UI Layer: Listen to state and display error messages appropriately (e.g., show a Snackbar or Dialog).
1️⃣ Error Handling Structure
API Layer (Service Class)
This layer communicates with the network. Here, we catch low-level exceptions like SocketException and rethrow them in a structured format.

 ```
class ApiService {
  final Dio _dio = Dio(); // or http package

  Future<Response> getData(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw NetworkException("No internet connection");
      } else {
        throw ApiException("Failed to fetch data");
      }
    } catch (e) {
      throw UnknownException("Something went wrong");
    }
  }
}
```
### Repository Layer
This layer processes API responses and maps them to models.
```
class DataRepository {
  final ApiService _apiService;

  DataRepository(this._apiService);

  Future<List<DataModel>> fetchData() async {
    try {
      final response = await _apiService.getData("https://api.example.com/data");
      return (response.data as List).map((e) => DataModel.fromJson(e)).toList();
    } on NetworkException {
      throw DataFetchException("No internet, please try again.");
    } on ApiException {
      throw DataFetchException("Server error, try again later.");
    } catch (e) {
      throw DataFetchException("Unexpected error occurred.");
    }
  }
}
```
### State Management with Riverpod
Here, we handle the loading, success, and error states.
```
final repositoryProvider = Provider<DataRepository>((ref) {
  return DataRepository(ApiService());
});

final dataProvider = StateNotifierProvider<DataNotifier, AsyncValue<List<DataModel>>>((ref) {
  final repository = ref.watch(repositoryProvider);
  return DataNotifier(repository);
});

class DataNotifier extends StateNotifier<AsyncValue<List<DataModel>>> {
  final DataRepository _repository;

  DataNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      state = const AsyncValue.loading();
      final data = await _repository.fetchData();
      state = AsyncValue.data(data);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
```
UI Layer: Handling Errors and Showing a Dialog
- Using ref.watch(dataProvider), we can show loading indicators, data, or error messages.
- If an error occurs, we show a Dialog in the UI.
```
class DataScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataState = ref.watch(dataProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Data Screen")),
      body: dataState.when(
        loading: () => Center(child: CircularProgressIndicator()),
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) => ListTile(title: Text(data[index].title)),
        ),
        error: (error, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showErrorDialog(context, error.toString());
          });
          return Center(child: Text("Error occurred"));
        },
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
```
 

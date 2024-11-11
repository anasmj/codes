```
class LocalDataService {
  static late LocalDataService instance;
  static late SharedPreferences _sharedPreferences;

  LocalDataService._();

  static Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.reload();
    instance = LocalDataService._();
  }

  Future<void> reload() {
    return _sharedPreferences.reload();
  }

  Future<void> setPrefferedLocale(String locale) async {
    await _sharedPreferences.setString('location', locale);
  }

  String getPrefferedLocale() {
    return _sharedPreferences.getString('location') ?? 'UTC';
  }

 
  bool getDarkModePreference() {
    return _sharedPreferences.getBool('darkModePreference') ?? true;
  }

  Future<void> setDarkModePreference(bool value) async {
    await _sharedPreferences.setBool('darkModePreference', value);
  }

  Future<void> setIndexOfPage(int index) async {
    await _sharedPreferences.setInt('index', index);
  }

  int getIndexOfPage() {
    return _sharedPreferences.getInt('index') ?? 0;
  }

  Future<void> setOnboardingCompleted(bool bool) async {
    await _sharedPreferences.setBool('onboardingCompleted', bool);
  }

  bool isOnboardingCompleted() {
    return _sharedPreferences.getBool('onboardingCompleted') ?? false;
  }

  Future<void> setAccessToken(String accessToken) async {
    await _sharedPreferences.setString('access', accessToken);
  }

  Future<void> setRefreshToken(String refresh) async {
    await _sharedPreferences.setString('refresh', refresh);
  }

  String? getAccessToken() {
    return _sharedPreferences.getString('access');
  }

  String? getRefreshToken() {
    return _sharedPreferences.getString('refresh');
  }

  Future<void> clearSharedPref() async {
    await _sharedPreferences.clear();
  }
}
```

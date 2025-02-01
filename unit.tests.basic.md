## Unit Tests 
Standard Description pattern : 
Given [initial state], when [action happens], then [expected result].
Exmaple:
```
class Counter {
  int _count = 0;

  int get count => _count;

  increment() => _count++;
  decrement() => _count != 0 ? _count-- : 0;
}
```
In counter_test.dart: (file name must follow _test.dart)
```
void main() {
  test(
      'Given a counter class when its instantiated then the value count should be 0',
      () {
    final Counter counter = Counter();
    expect(counter.count, 0);
  });
  test(
      'Given a counter class when its incremented then the value count should be 1',
      () {
    final counter = Counter();
    counter.increment();
    expect(counter.count, 1);
  });
  test('given a class when its decermented then the value should be 0 ', () {
    final counter = Counter();
    counter.decrement();
    expect(counter.count, 0);
  });
}
```
It can be grouped like this 
```
void main() {
  final Counter counter = Counter();
  group(
    'Counter test-',
    () {
      test(' ', () {});
      test('', () {});
      test('', () {});
    },
  );
}
```

### Pre test, test and post test functions
```
  void main() {
  final Counter counter = Counter();
   //Pre-test
  setUp(() {}); // before every test : setup-> test -> setup -> test -> setup->test
  setUpAll(() {}); //Called before all test: setup-> test -> test-> testÏ
  
  //test 
  group(
    'Counter test-',
    () {
      test(' ', () {});
      test('', () {});
      test('', () {});
    },
  );
  //Post-test
  tearDown(() {}); //Called after every test: test-> tearDown-> test-> teardown -> test -> teardown
  tearDownAll(() {}); //Called after all the test : test -> test-> test-> teardownAll
}
```
Instead of instantiate [counter] every time, instantiate it on setUp(). Each test indipendent and get new instance of counter every time
```
void main() {
  late Counter counter;
  //Pre-test
  setUp(() => counter = Counter());
  group(
    'Counter test-',
    () {
      test(
          'Given a counter class when its instantiated then the value count should be 0',
          () {
        expect(counter.count, 0);
      });
      test(
          'Given a counter class when its incremented then the value count should be 1',
          () {
        counter.increment();
        expect(counter.count, 1);
      });
      test('given a class when its decermented then the value should be 0 ',
          () {
        counter.decrement();
        expect(counter.count, 0);
      });
      test('Given the class when its reset then the value should be 0', () {
        counter.reset();
        expect(counter.count, 0);
      });
    },
  );
}
```
  

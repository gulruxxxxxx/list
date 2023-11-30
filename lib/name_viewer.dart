import 'dart:async';

class NameBloc {
  final List<String> nameList = [
    'Jasur', 'Akbarali', 'Feruzbek', 'Muhammadrasul', 'Ahmadjon', 'Fotima',
    'Aziza', 'Gulrux', 'Mahmudxon', 'Muhammadsaid', 'Xojiakbar', 'Ozod',
    'Jahongir', 'Sohibjon', 'Mehrojiddin', 'Sardor', 'Dovudxon', 'Muhammadziyo', 'Muhammadamin',
  ];
  final _currentIndexController = StreamController<int>();
  final _atEndController = StreamController<bool>();

  int _currentIndex = 0;

  NameBloc() {
    _currentIndexController.add(_currentIndex);
    _atEndController.add(false);
  }

  Stream<int> get currentIndex => _currentIndexController.stream;
  Stream<bool> get atEnd => _atEndController.stream;

  String getName(int index) {
    return nameList[index];
  }

  void nextName() {
    _currentIndex = (_currentIndex + 1) % nameList.length;
    _currentIndexController.add(_currentIndex);

    if (_currentIndex == 0) {
      _atEndController.add(true);
    } else {
      _atEndController.add(false);
    }
  }

  void previousName() {
    _currentIndex = (_currentIndex - 1 + nameList.length) % nameList.length;
    _currentIndexController.add(_currentIndex);
    _atEndController.add(false);
  }

  void dispose() {
    _currentIndexController.close();
    _atEndController.close();
  }
}


class DataProvider<T> {
  Stream<T> Function() _getData;
  Function(T) _setData;
  Future<T> Function() _loadDataFromRemote;
  bool Function(T) _isDataValid;

  late Stream<T> _data;

  DataProvider(
    this._getData,
    this._setData,
    this._loadDataFromRemote,
    this._isDataValid,
  ) {
    _data = _getData();
  }

  Stream<T> getData() {
    loadData();
    return _data;
  }

  void loadData() async {
    T currentData = await _getData().first;
    if (_isDataValid(currentData)) return;

    T dataFromRemote = await _loadDataFromRemote();

    _setData(dataFromRemote);
  }
}

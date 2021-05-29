class DataProvider<T> {
  Stream<T> Function() _getData;
  Function(T) _setData;
  Future<T> Function() _loadDataFromRemote;
  bool Function(T) _isDataValid;

  DataProvider(
    this._getData,
    this._setData,
    this._loadDataFromRemote,
    this._isDataValid,
  );

  Stream<T> getData() {
    loadDataIfNeeded();
    return _getData();
  }

  void loadDataIfNeeded() async {
    T currentData = await _getData().first;
    if (_isDataValid(currentData)) return;

    T dataFromRemote = await _loadDataFromRemote();

    _setData(dataFromRemote);
  }
}

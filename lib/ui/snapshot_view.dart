import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SnapshotView<T> extends StatelessWidget {
  final AsyncSnapshot<T> snapshot;
  final Widget Function(T) onHasData;
  final Widget Function(Object) onError;
  final Widget Function() onLoading;

  SnapshotView({
    required this.snapshot,
    required this.onHasData,
    this.onError = createDefaultOnError,
    this.onLoading = createDefaultOnLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      return onHasData(snapshot.data!);
    } else if (snapshot.hasError) {
      return onError(snapshot.error!);
    } else
      return onLoading();
  }

  static Widget createDefaultOnError(Object error) => throw error;

  static Widget createDefaultOnLoading() =>
      Center(child: CircularProgressIndicator());
}

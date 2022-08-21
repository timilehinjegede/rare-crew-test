import 'package:flutter/material.dart' hide State;

enum Status { idle, loading, data, error }

class ViewState<T> {
  ViewState({
    this.message = 'Unknown error occurred',
    this.data,
    this.status,
  });

  ViewState.idle() : status = Status.idle;
  ViewState.loading(this.message) : status = Status.loading;
  ViewState.data(this.data) : status = Status.data;
  ViewState.error(this.message) : status = Status.error;

  Status? status;
  T? data;
  String message = '';

  bool isInitialState() => !(status == Status.data && data != null);

  @override
  String toString() {
    return 'Status : $status \n Message : $message \n Data : $data';
  }

  bool get isIdle => status == Status.idle;
  bool get isLoading => status == Status.loading;
  bool get isData => status == Status.data;
  bool get isError => status == Status.error;

  Widget when({
    required Widget Function(T data) done,
    required Widget Function(String message) error,
    required Widget Function() loading,
  }) {
    switch (status) {
      case Status.idle:
        {
          return const SizedBox.shrink();
        }
      case Status.loading:
        {
          return loading();
        }
      case Status.data:
        {
          return done(data as T);
        }
      case Status.error:
        {
          return error(message);
        }
      default:
        return const SizedBox.shrink();
    }
  }
}

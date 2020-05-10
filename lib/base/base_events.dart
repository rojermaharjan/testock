import 'package:rxdart/rxdart.dart';

class BasePublishEvent<T> {
  PublishSubject<T> _event;

  T _state;

  BasePublishEvent() {
    _event = new PublishSubject<T>();
  }

  void updateState(T state) {
    this._state = state;
  }

  T getCurrentState() {
    return this._state;
  }

  Stream<T> getStream() {
    return _event.stream;
  }
}

class BaseBehaviorBloc<T> {
  BehaviorSubject<T> _event;

  T _state;

  BaseBehaviorBloc() {
   _event=new BehaviorSubject<T>();
  }

  BaseBehaviorBloc.withInitialData(T initialData) {
    _event = new BehaviorSubject<T>.seeded(initialData);
    this._state = initialData;
  }

  void updateState(T state) {
    this._state = state;
    if (_event != null) _event.sink.add(state);
  }

  T getCurrentState() {
    return this._state;
  }

  Stream<T> getStream() {
    return _event.stream;
  }
}

class UseCaseEvent<T> {
  T _data;
  String _message;
  UseCaseStatus _useCaseStatus;

  UseCaseEvent(this._data, this._useCaseStatus, this._message);

  UseCaseStatus get useCaseStatus => _useCaseStatus;

  T get data => _data;

  String get message => _message;
}

enum UseCaseStatus { LOADING, SUCCESS, FAILED }

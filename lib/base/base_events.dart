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

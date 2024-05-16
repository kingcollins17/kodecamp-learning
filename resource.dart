import 'dart:async';

///This is Singleton, only one object of class can exist
// ignore_for_file: unused_element

class Resource {
  static Resource? _instance;
  final String value;

  Resource._([this.value = 'Singleton Resource']);

  static Resource get instance => _instance ??= Resource._();
}

///Consumer is [Function] that takes in the Resource and uses it for whatever
typedef Consumer<T> = FutureOr<T> Function(Resource resource);

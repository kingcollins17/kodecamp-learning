//
import 'dart:async';
import 'dart:collection';

import 'resource_queue.dart';
// ignore_for_file: unused_element

void main() {
  final callQueue = ResourceQueue();
  //
  final future1 = callQueue.add((resource) async {
    await Future.delayed(Duration(seconds: 2));
    print('First call is consuming the resource');
  });

  final future2 =
      callQueue.add((resource) => Future.delayed(Duration(seconds: 4), () {
            print('Using the resource the second time');
          }));

  ///Again the problem is, i want to future1 to complete when the closure inside callQueue.add()
  ///has run.
}

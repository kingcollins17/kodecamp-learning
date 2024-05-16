import 'dart:collection';

import 'resource.dart';

///Queues up [Consumer]s and calls them one by one
class ResourceQueue {
  var _queue = DoubleLinkedQueue<Consumer>();

  ///Whether the call is running
  bool _isRunning = false;

  Future<void> _callConsumers() async {
    //set to true to indicate that the consumers inside the queue
    //are being called so that we dont end up calling it twice
    if (!_isRunning) {
      _isRunning = true;

      while (_queue.isNotEmpty) {
        final consumer = _queue.removeFirst();
        await consumer(
            Resource.instance); //Pass the resource and run this consumer

        ///Now the problem here is, when the consumer is done running.
        ///I want to programmatically complete the Future that was returned
        /// when someone called
        ///   add((resource) async {
        ///         // use the resource for whatever
        ///     })
      }
      _isRunning =
          false; //set to false to indicate that this is no longer running
    }
  }

  ///This method should return a future that completes when consumer is called with
  ///the [Resource] object.
  ///
  ///I need to find a way that programmatically complete a future when the consumer is called
  Future<T> add<T>(Consumer<T> consumer) async {
    _queue.addLast(consumer); //queue up the consumer to be called later

    if (!_isRunning) _callConsumers();

    ///Return a future that completes when this consumer is actually called with the [Resource]
    //object
    return Future.delayed(Duration(seconds: 2));
  }
}

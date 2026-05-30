import 'dart:async';
import '../events/realtime_event.dart';
import 'realtime_service.dart';

class LocalRealtimeService implements RealtimeService {
  final StreamController<RealtimeEvent> _controller =
      StreamController<RealtimeEvent>.broadcast();

  @override
  void emit(RealtimeEvent event) {
    _controller.add(event);
  }

  @override
  Stream<RealtimeEvent> get eventStream => _controller.stream;

  @override
  Stream<T> events<T extends RealtimeEvent>() {
    return _controller.stream.where((e) => e is T).cast<T>();
  }

  @override
  void dispose() {
    _controller.close();
  }
}

import '../events/realtime_event.dart';

abstract class RealtimeService {
  void emit(RealtimeEvent event);
  Stream<RealtimeEvent> get eventStream;
  Stream<T> events<T extends RealtimeEvent>();
  void dispose();
}

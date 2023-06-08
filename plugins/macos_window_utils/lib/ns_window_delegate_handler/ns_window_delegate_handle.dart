import 'ns_window_delegate_handler.dart';

class NSWindowDelegateHandle {
  /// The ID of the next [NSWindowDelegateHandle] to be created.
  static int _nextId = 0;

  /// This handle's ID.
  final int _id;

  /// This handle's [NSWindowDelegateHandler].
  final NSWindowDelegateHandler handler;

  NSWindowDelegateHandle._({required this.handler, required int id}) : _id = id;

  /// Creates a [NSWindowDelegateHandle].
  factory NSWindowDelegateHandle.create(NSWindowDelegateHandler handler) {
    final nextId = _getNextId();
    return NSWindowDelegateHandle._(handler: handler, id: nextId);
  }

  /// Removes this handle's [NSWindowDelegate] from this handle's [handler].
  void removeFromHandler() {
    handler.removeDelegate(this);
  }

  @override
  bool operator ==(other) =>
      other is NSWindowDelegateHandle && _id == other._id;

  @override
  int get hashCode => _id.hashCode;

  /// Returns the ID of the next [NSWindowDelegateHandle] to be created.
  static int _getNextId() {
    final nextId = _nextId;
    _nextId += 1;
    return nextId;
  }
}

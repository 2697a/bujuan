/// This class represents a method called by an [NSWindowDelegate] object.
class NSWindowDelegateEvent {
  /// Creates a [NSWindowDelegateEvent] with a given [name].
  NSWindowDelegateEvent({required this.name, this.numberOfOccurrences = 1});

  /// The name of the event, which should correspond to the name of the method
  /// that it represents.
  final String name;

  /// The number of times the event has occurred in a row.
  final int numberOfOccurrences;

  /// Creates a new [NSWindowDelegateEvent] with an incremented number of
  /// occurrences.
  NSWindowDelegateEvent withIncrementedNumberOfOccurrences() {
    return NSWindowDelegateEvent(
      name: name,
      numberOfOccurrences: numberOfOccurrences + 1,
    );
  }
}

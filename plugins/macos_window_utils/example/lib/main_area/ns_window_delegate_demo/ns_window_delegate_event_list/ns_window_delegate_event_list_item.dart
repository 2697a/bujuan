import 'package:example/main_area/ns_window_delegate_demo/ns_window_delegate_event.dart';
import 'package:flutter/cupertino.dart';

class NSWindowDelegateEventListItem extends StatelessWidget {
  const NSWindowDelegateEventListItem({super.key, required this.event});

  final NSWindowDelegateEvent event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          if (event.numberOfOccurrences != 1)
            Container(
              margin: const EdgeInsets.only(right: 4.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                color: Color.fromRGBO(128, 128, 128, 0.5),
              ),
              child: Text('${event.numberOfOccurrences}'),
            ),
          Text(event.name),
          const Spacer(),
        ],
      ),
    );
  }
}

# tabler_icons
This repository is an auto generated version of the official tabler icon pack. This repository takes care of generating all the icons in the font pack and then lists them down.

The official [Tabler Icon Pack](https://github.com/tabler/tabler-icons).

official Tabler icons version: 1.68

## pubspec.yaml
```yml
dependencies:
  flutter:
    sdk: flutter
  tabler_icons: 
    git:
      url: git://github.com/decafdevs/tabler-icons.git
      ref: master
```

## Usage
```Dart
import 'package:tabler_icons/tabler_icons.dart';

class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return new IconButton(
      icon: new Icon(TablerIcons.ambulance),
      onPressed: () { print('Ambulance pressed'); }
     );
  }
}
```

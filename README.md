# MyFest 1.0

ESTA APP FUNCIONA SOLO PARA ANDROID 10+

### Pagina principal
lib/pages/main.dart

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)


## Documentación

* [Install Flutter](https://flutter.dev/get-started/)
* [Flutter documentation](https://docs.flutter.dev/)
* [Development wiki](https://github.com/flutter/flutter/wiki)
* [Contributing to Flutter](https://github.com/flutter/flutter/blob/master/CONTRIBUTING.md)

## Compilar 
```
flutter pub get
flutter run --no-sound-null-safety
```
## Librerias con sus versiones
_Todas las librerias estan en el archivo pubspec.yaml
  * cupertino_icons: ^1.0.2
  * clay_containers: ^0.3.2
  * flutter_bloc: ^8.0.1
  * image_picker: ^0.8.4
  * file_picker: ^5.2.2
  * models: ^0.0.2
  * google_maps_flutter: ^2.1.8
  * flutter_polyline_points: ^1.0.0
  * dio: ^4.0.6
  * google_maps_flutter_web: ^0.4.0+1
  * google_maps: ^6.2.0
  * font_awesome_flutter: ^10.1.0
  * expansion_card: ^0.1.0
  * vertical_card_pager: ^1.5.0
  * clippy_flutter: ^1.1.1
  * sizer: ^2.0.15
  * http: ^0.13.5
  * permission: ^0.1.7
  * flutter_speed_dial: ^6.2.0
  * permission_handler: ^10.2.0
  * location: ^4.2.0
  * cloud_firestore: ^4.0.4
  * datetime_picker_formfield: ^2.0.1
  * firebase_auth: ^4.1.1
  * email_validator: ^2.1.17
  * simple_animations: ^1.3.3
  * google_fonts: ^3.0.1
  * badges: ^2.0.3
  * auto_size_text: ^3.0.0
  * animations: ^2.0.7
  * easy_debounce: ^2.0.2+1
  * equatable: ^2.0.5
  * firebase_database: ^10.0.6
  * date_format: ^2.0.7
  * firebase_storage: ^11.0.6
  * uuid: ^3.0.7
  * flutter_dotenv: ^5.0.2
  * firebase_messaging: ^14.1.3
  * flutter_local_notifications: ^12.0.4
  * flutter_slidable: ^2.0.0
  * animated_theme_switcher: ^2.0.7
 
  * flutter_launcher_icons: ^0.10.0
  * build_runner: ^1.0.0
  * json_serializable: any
## PERMISOS
_La app tiene permisos para uso en cualquier dispositivo por parte de FIRBASE_
### Reglas
```
rules_version = '2';
    service cloud.firestore {
     match /databases/{database}/documents {
        match /{document=**} {
        allow read, write: if request.time < timestamp.date(2024, 1, 1);
        }
     }
    }
```

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

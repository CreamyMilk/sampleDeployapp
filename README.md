# sampledeployapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Services to be created
- Authentication service
  When one send us the OTP when we get back the user-data we store it in shared prefernces
  We can used Token based auth where when user need data they just send a get request matchingg what they need JWT
  On next login if you have a token just get user details and skip login
  If not login
- Report Generation

Show Snack Bar on notification 

```Dart
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage :$message");
        //Disply SnackBar
        final snackbar = SnackBar(
          content: Text(message['notification']['title']),
          action: SnackBarAction(
            label: "Go",
            onPressed: () =>
                null, //Can Add logic to navigate to diffrent screen o
          ),
        );
        Scaffold.of(context).showSnackBar(snackbar);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onMessage :$message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onMessage :$message");
      },
    );

```



```Dart
_icons.asMap().entries.map(MapEntry map) =>_buildIcon(map.key),
  ).toList())
```
A Flutter plugin for sharing file to specified app.

## Example
```dart
final _shareSpecifiedAppPlugin = ShareSpecifiedApp();

_shareSpecifiedAppPlugin.shareFile(
  path: filePath, // provide local file path
  packageName: "com.tencent.mobileqq", // share file to qq
  whenNotFoundApp: () {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Not found app.')));
  });
```
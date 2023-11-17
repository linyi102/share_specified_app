import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:share_specified_app/share_specified_app.dart';
import 'package:share_specified_app_example/enums/other_app.dart';
import 'package:share_specified_app_example/widgets/other_app_logo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('分享文件'), centerTitle: true),
        body: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _shareSpecifiedAppPlugin = ShareSpecifiedApp();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
      ),
      itemCount: OtherApp.values.length,
      itemBuilder: (context, index) {
        final cloudDrive = OtherApp.values[index];
        return _buildCloudDriveItem(cloudDrive);
      },
    );
  }

  InkWell _buildCloudDriveItem(OtherApp app) {
    return InkWell(
      onTap: () => _shareFile(app),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [OtherAppLogo(app: app), Text('分享到${app.title}')],
      ),
    );
  }

  Future<void> _shareFile(OtherApp app) async {
    final file = await _generateFile();
    _shareSpecifiedAppPlugin.shareFile(
        path: file.path,
        packageName: app.packageName,
        whenNotFoundApp: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('没有找到该应用')));
        });
  }

  Future<File> _generateFile() async {
    final dir = await getTemporaryDirectory();
    final now = DateTime.now();
    final fileName = 'hello_${now.millisecondsSinceEpoch}';
    final file = File(p.join(dir.path, fileName));
    await file.writeAsString(now.toString());
    return file;
  }
}

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:process_run/shell.dart';
import 'camera_screen.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late CameraDescription frontCamera;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    frontCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front);
  }

  void _runPythonScript() async {
    var shell = Shell();
    await shell.run('''
    python /path/to/your/python_script.py
    ''');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Media Controller'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _initializeCamera();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraScreen(camera: frontCamera)),
                );
                _runPythonScript();
              },
              child: Text('Run'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TutorialsScreen()),
                );
              },
              child: Text('Tutorials'),
            ),
          ],
        ),
      ),
    );
  }
}

class TutorialsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture Tutorials'),
      ),
      body: Center(
        child: Text('Here are the gestures and their functions...'),
      ),
    );
  }
}

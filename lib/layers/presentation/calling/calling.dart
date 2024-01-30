import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

class Calling extends StatefulWidget {
  const Calling({super.key});

  @override
  State<Calling> createState() => _CallingState();
}

class _CallingState extends State<Calling> {
  late RtcEngine _engine;

  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: 'ee86190e0e2844a582c9a7064170c4e3',
      channelName: 'test',
      username: 'user',
    ),
  );

  Future<void> initAgora() async {
    await client.initialize();
  }

  @override
  void initState() {
    initAgora();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calling'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(
              client: client,
              layoutType: Layout.floating,
              enableHostControls: true,
            ),
            AgoraVideoButtons(
              client: client,
              addScreenSharing: false,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }
}

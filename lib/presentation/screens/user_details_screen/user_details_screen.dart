import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/constants/font_weight.dart';
import '../../../data/model/user.dart';
import '../../../logic/cubit/voice_note/voice_note_cubit.dart';
import '../../widgets/custom_text.dart';

class UserDetailScreen extends StatefulWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  bool isRecording = false;

  Future<void> _checkPermissions() async {
    if (await Permission.microphone.request().isGranted) {
      // Permission granted
    } else {
      // Handle permission denied
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Microphone permission is required to record voice notes.')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    // Load voice notes for the specific user ID
    context.read<VoiceNoteCubit>().loadVoiceNotes(widget.user.id.toString());
  }

  void _toggleRecording() async {
    if (isRecording) {
      await context.read<VoiceNoteCubit>().stopRecording(widget.user.id.toString());
      setState(() => isRecording = false);
    } else {
      setState(() => isRecording = true);
      await context
          .read<VoiceNoteCubit>()
          .startRecording(widget.user.id.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: CustomText(
        text: "${widget.user.name} Details",
        size: 20,
        fontWeight: medium,
        clr: black101010Color,
      )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "User ID: ${widget.user.id}",
                        size: 16,
                        fontWeight: normal,
                        clr: black101010Color,
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: "Name: ${widget.user.name}",
                        size: 16,
                        fontWeight: normal,
                        clr: black101010Color,
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: "Email: ${widget.user.email}",
                        size: 16,
                        fontWeight: normal,
                        clr: black101010Color,
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: "Phone: ${widget.user.phone}",
                        size: 16,
                        fontWeight: normal,
                        clr: black101010Color,
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: "Address: ${widget.user.address}",
                        size: 16,
                        fontWeight: normal,
                        clr: black101010Color,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const CustomText(
              text: "Voice Notes:",
              size: 18,
              fontWeight: medium,
              clr: black101010Color,
            ),
            Expanded(
              child: BlocBuilder<VoiceNoteCubit, List<String>>(
                builder: (context, voiceNotes) {
                  if (voiceNotes.isEmpty) {
                    return Container();
                  }
                  return ListView.builder(
                    itemCount: voiceNotes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: CustomText(
                          text: "'Voice Note ${index + 1}'",
                          size: 14,
                          fontWeight: normal,
                          clr: black101010Color,
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.play_arrow,
                          ),
                          onPressed: () => context.read<VoiceNoteCubit>().playRecording(voiceNotes[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _toggleRecording,
              child: CustomText(
                text: isRecording ? 'Stop Recording' : 'Start Recording',
                size: 14,
                fontWeight: normal,
                clr: black101010Color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:io';

import '../../../core/colors/app_colors.dart';
import '../../../core/constants/font_weight.dart';
import '../../../data/model/user.dart';
import '../../widgets/custom_text.dart';

class UserDetailScreen extends StatefulWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  bool isRecording = false;

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
              child: ListView.builder(
                itemCount: widget.user.voiceNotes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Voice Note ${index + 1}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.play_arrow),
                      onPressed: () {

                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(isRecording ? 'Stop Recording' : 'Record Voice Note'),
            ),
          ],
        ),
      ),
    );
  }
}

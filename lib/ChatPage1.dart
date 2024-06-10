import 'package:agarly/ChatService.dart';
import 'package:agarly/HomeScreen.dart';
import 'package:agarly/NavBar.dart';
import 'package:agarly/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ChatPage1 extends StatefulWidget {
  final String reciverUserEmail;
  final String reciverUserid;

  const ChatPage1({
    Key? key,
    required this.reciverUserEmail,
    required this.reciverUserid,
  }) : super(key: key);

  @override
  State<ChatPage1> createState() => _ChatPage1State();
}

class _ChatPage1State extends State<ChatPage1> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    // Initialize FCM
    _configureFCM();
    _initLocalNotifications();
    // Rest of your existing initState code...
  }

  void _initLocalNotifications() async {
    // Initialization code for local notifications
  }

  void _configureFCM() {
    // FCM configuration code
  }

  void SendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.reciverUserid,
        _messageController.text,
      );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reciverUserEmail),
        backgroundColor: Color.fromARGB(255, 227, 183, 121),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  top: MediaQuery.of(context).size.height / 6.3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 216, 15, 15),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: StreamBuilder(
                      stream: _chatService.getMessages(
                        widget.reciverUserid,
                        _firebaseAuth.currentUser?.uid ?? '',
                      ),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          print('Error: ${snapshot.error}');
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          print('Waiting for data...');
                          return CircularProgressIndicator();
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          print('No messages found.');
                          return Text('No messages Yet, Start a conversation.');
                        }

                        print(
                            'Received ${snapshot.data!.docs.length} messages.');

                        return ListView(
                          children: snapshot.data!.docs
                              .map((document) => _buildMessageItem(document))
                              .toList(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1, // Set the index for the 'Chat' icon
        onTap: (index) {
          // Handle navigation as needed
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          rentBuyOption: '',
                          title: '',
                        )),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
              break;
            default:
              break;
          }
        },
      ),
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    // Placeholder implementation for message item widget
    return ListTile(
      title: Text(document['message']),
    );
  }

  Widget _buildProfilePicture(String senderId) {
    // Placeholder implementation for profile picture widget
    return CircleAvatar(
      backgroundColor: Colors.blue,
    );
  }

  Widget _buildMessageInput() {
    // Placeholder implementation for message input widget
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Enter your message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: SendMessage,
          ),
        ],
      ),
    );
  }
}

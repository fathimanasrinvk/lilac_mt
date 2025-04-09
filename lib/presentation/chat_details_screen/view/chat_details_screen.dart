import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/textstyles.dart';


class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({Key? key}) : super(key: key);

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final List<Message> _messages = [
    Message(
      text: "Happy Birthday",
      isMe: false,
      time: "10:00 AM",
      hasAttachment: true,
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(
          Message(
            text: _messageController.text,
            isMe: true,
            time: _getCurrentTime(),
            hasAttachment: false,
          ),
        );
        _messageController.clear();
      });
    }
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    String period = now.hour >= 12 ? 'PM' : 'AM';
    int hour = now.hour > 12 ? now.hour - 12 : now.hour;
    if (hour == 0) hour = 12;
    String minute = now.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Chat header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, size: 24.h),
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/avatar2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Regina Bearden',
                        style: GLTextStyles.poppinsStyle(
                          size: 14.sp,
                          weight: FontWeight.w600,
                          color: ColorTheme.black,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 8.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Online',
                            style: GLTextStyles.poppinsStyle(
                              size: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Chat messages
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ListView.builder(
                  reverse: true,
                  itemCount: _messages.length + 1, // +1 for the date header
                  itemBuilder: (context, index) {
                    if (index == _messages.length) {
                      // Date header at the top (when reversed)
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              'Today',
                              style: GLTextStyles.poppinsStyle(
                                size: 12.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    // Messages (in reverse order)
                    final message = _messages[_messages.length - 1 - index];

                    if (message.isMe) {
                      return _buildSentMessage(
                        message.text,
                        message.time,
                      );
                    } else {
                      return _buildReceivedMessage(
                        message.text,
                        message.time,
                        message.hasAttachment,
                      );
                    }
                  },
                ),
              ),
            ),
            // Message input
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                  ),
                  Container(
                    height: 36.h,
                    width: 1,
                    color: Colors.grey[300],
                  ),
                  // Text input area
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: TextField(
                        controller: _messageController,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14.sp,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                        ),
                        style: GLTextStyles.poppinsStyle(
                          size: 14.sp,
                          color: ColorTheme.black,
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  // Button row - emoticons, attachments, etc.
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Text(
                          'GIF',
                          style: GLTextStyles.poppinsStyle(
                            size: 14.sp,
                            weight: FontWeight.w600,
                            color: Colors.grey[400],
                          ),
                        ),
                        iconSize: 20,
                        padding: EdgeInsets.all(4),
                        constraints: BoxConstraints(),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.photo_library_outlined,
                          color: Colors.grey[400],
                        ),
                        iconSize: 20,
                        padding: EdgeInsets.all(4),
                        constraints: BoxConstraints(),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.emoji_emotions_outlined,
                          color: Colors.grey[400],
                        ),
                        iconSize: 20,
                        padding: EdgeInsets.all(4),
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),
                  // Send button
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      width: 36.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        color: Colors.pink[400],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: _messageController.text.isEmpty
                            ? Icon(
                          Icons.mic,
                          color: Colors.white,
                          size: 20,
                        )
                            : Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceivedMessage(String message, String time, bool hasAttachment) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 260.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    message,
                    style: GLTextStyles.poppinsStyle(
                      size: 14.sp,
                      color: ColorTheme.black,
                    ),
                  ),
                ),
                if (hasAttachment) ...[
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.play_arrow,
                    color: Colors.red,
                    size: 20,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSentMessage(String message, String time) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 260.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: ColorTheme.mainColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
                bottomLeft: Radius.circular(16.r),
              ),
            ),
            child: Text(
              message,
              style: GLTextStyles.poppinsStyle(
                size: 14.sp,
                color: ColorTheme.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Message model for chat
class Message {
  final String text;
  final bool isMe;
  final String time;
  final bool hasAttachment;

  Message({
    required this.text,
    required this.isMe,
    required this.time,
    this.hasAttachment = false,
  });
}
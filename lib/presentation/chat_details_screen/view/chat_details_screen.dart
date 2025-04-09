import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lilac_infotech/core/constants/colors.dart';
import 'package:provider/provider.dart';
import '../../../repository/api/chat_details_screen/model/chat_details_screen_model.dart';
import '../controller/chat_details-screen_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.name, required this.active,  required this.profilepic,
  });
  final String name;
  final bool active;
  final dynamic profilepic;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final int currentUserId = 55;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChatController>(context, listen: false).fetchChats(context);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    final message = _controller.text.trim();
    if (message.isNotEmpty) {
      _controller.clear();
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildDayTag(),
          _buildMessagesList(),
          _buildMessageInput(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(80.h),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              icon:  Icon(Icons.arrow_back_ios_new, color:ColorTheme.black),
              onPressed: () => Navigator.pop(context),
            ),
            CircleAvatar(
              radius: 20.r,
              backgroundImage: widget.profilepic.isNotEmpty
                  ? NetworkImage(widget.profilepic)
                  : const Icon(Icons.person) as ImageProvider,
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                _buildOnlineStatus(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOnlineStatus() {
    return Row(
      children: [
        Text(
          widget.active ? "Online" : "Offline",
          style: TextStyle(
            color: widget.active ? Colors.green : Colors.grey,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(width: 4.w),
        Icon(
          Icons.circle,
          size: 6,
          color: widget.active ? Colors.green : Colors.grey,
        ),
      ],
    );
  }

  Widget _buildDayTag() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Text("Today", style: TextStyle(fontSize: 12.sp)),
        ),
      ),
    );
  }

  Widget _buildMessagesList() {
    return Expanded(
      child: Consumer<ChatController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.chatList.isEmpty) {
            return const Center(child: Text("No messages yet"));
          }

          WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

          return ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: controller.chatList.length,
            itemBuilder: (context, index) {
              final message = controller.chatList[index];
              final isSentByMe = message.attributes?.senderId == currentUserId;
              return _buildMessageBubble(message, isSentByMe);
            },
          );
        },
      ),
    );
  }

  Widget _buildMessageBubble(ChatModel message, bool isSentByMe) {
    final messageText = message.attributes?.message ?? '';
    final formattedTime = _formatMessageTime(message.attributes?.sentAt);

    return Padding(
      padding: EdgeInsets.only(
        left: isSentByMe ? 80.w : 16.w,
        right: isSentByMe ? 16.w : 80.w,
        bottom: 12.h,
      ),
      child: Column(
        crossAxisAlignment: isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 250.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSentByMe ? const Color(0xFFFF4D67) : Colors.grey.shade200,
              borderRadius: _getMessageBorderRadius(isSentByMe),
            ),
            child: Text(
              messageText,
              style: TextStyle(
                color: isSentByMe ? Colors.white : Colors.black,
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          _buildMessageTimeRow(formattedTime, isSentByMe),
        ],
      ),
    );
  }

  BorderRadius _getMessageBorderRadius(bool isSentByMe) {
    return isSentByMe
        ? BorderRadius.only(
      topLeft: Radius.circular(12.r),
      topRight: Radius.circular(12.r),
      bottomLeft: Radius.circular(12.r),
    )
        : BorderRadius.only(
      topLeft: Radius.circular(12.r),
      topRight: Radius.circular(12.r),
      bottomRight: Radius.circular(12.r),
    );
  }

  Widget _buildMessageTimeRow(String time, bool isSentByMe) {
    return Row(
      mainAxisAlignment: isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Text(
          time,
          style: TextStyle(fontSize: 11.sp, color: Colors.grey),
        ),
        if (isSentByMe) SizedBox(width: 3.w),
        if (isSentByMe)
          Icon(Icons.done_all, size: 11.sp, color: Colors.grey),
      ],
    );
  }

  String _formatMessageTime(DateTime? messageTime) {
    if (messageTime == null) return '';
    final hour = messageTime.hour.toString().padLeft(2, '0');
    final minute = messageTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: "Type a message...",
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            IconButton(
              onPressed: _sendMessage,
              icon: const Icon(Icons.send, color: Colors.pink),
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../repository/api/all_message_list_screen/model/all_message_list_screen_model.dart';
import '../../chat_details_screen/view/chat_details_screen.dart';
import '../controller/all_message_list_controller.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MessageListController>().fetchMessages(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        'Messages',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: false,
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Consumer<MessageListController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHorizontalUserList(controller),
              SizedBox(height: 20.h),
              _buildSearchBar(),
              SizedBox(height: 20.h),
              _buildMessageList(controller),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHorizontalUserList(MessageListController controller) {
    return SizedBox(
      height: 80.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: controller.messageList.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final message = controller.messageList[index];
          return _buildUserAvatar(message);
        },
      ),
    );
  }

  Widget _buildUserAvatar(MessageModel message) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24.r,
          backgroundColor: Colors.black,
          backgroundImage: NetworkImage(
            message.attributes?.profilePhotoUrl ?? "",
          ),
        ),
        Text(
          message.attributes?.name ?? "Unknown",
          style: TextStyle(fontSize: 12.sp),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          SizedBox(width: 12.w),
          const Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 8.w),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(MessageListController controller) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.messageList.length,
        itemBuilder: (context, index) {
          final message = controller.messageList[index];
          return _buildMessageTile(message);
        },
      ),
    );
  }

  Widget _buildMessageTile(MessageModel message) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 24.r,
        backgroundColor: Colors.black,
        backgroundImage: NetworkImage(
          message.attributes?.profilePhotoUrl ?? "",
        ),
      ),
      title: Text(
        message.attributes?.name ?? "Unknown",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 15.sp,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              name: message.attributes?.name ?? "",
              active: message.attributes?.isOnline ?? false,
                profilepic: message.attributes?.profilePhotoUrl ?? "",

            ),
          ),
        );
      },
    );
  }
}
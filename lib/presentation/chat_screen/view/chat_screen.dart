import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/textstyles.dart';
import '../../../repository/api/chatlist_screen/model/chat_screen_model.dart';
import '../controller/chat-screen-controller.dart';


class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MessagesController>(context, listen: false).fetchChatProfiles();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<MessagesController>(
          builder: (context, controller, child) {
            return Column(
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back, size: 24.h),
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        'Messages',
                        style: GLTextStyles.poppinsStyle(
                          size: 18.sp,
                          weight: FontWeight.w600,
                          color: ColorTheme.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // Stories row
                SizedBox(
                  height: 80.h,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildStoryAvatar('Christina', 'assets/images/avatar1.png'),
                      SizedBox(width: 12.w),
                      _buildStoryAvatar('Patricia', 'assets/images/avatar2.png'),
                      SizedBox(width: 12.w),
                      _buildStoryAvatar('Celestine', 'assets/images/avatar3.png'),
                      SizedBox(width: 12.w),
                      _buildStoryAvatar('Celestine', 'assets/images/avatar4.png'),
                      SizedBox(width: 12.w),
                      _buildStoryAvatar('Elizabeth', 'assets/images/avatar5.png'),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // Search bar
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        controller.setSearchQuery(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14.sp,
                        ),
                        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                        suffixIcon: Icon(Icons.mic, color: Colors.grey[400]),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // Chat label
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Chat',
                      style: GLTextStyles.poppinsStyle(
                        size: 16.sp,
                        weight: FontWeight.w600,
                        color: ColorTheme.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),

                // Chat list
                Expanded(
                  child: controller.isLoading
                      ? Center(
                    child: CircularProgressIndicator(color: ColorTheme.mainColor),
                  )
                      : controller.chatProfiles.isEmpty
                      ? Center(
                    child: Text(
                      'No chat profiles found',
                      style: GLTextStyles.poppinsStyle(
                        size: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  )
                      : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: controller.chatProfiles.length,
                    itemBuilder: (context, index) {
                      ChatProfile profile = controller.chatProfiles[index];
                      return _buildChatItem(
                        profile.name,
                        '', // No message preview in API
                        profile.profilePhotoUrl ?? 'assets/images/avatar1.png',
                        '10:00 AM', // Time not in API
                        false, // Unread status not in API
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStoryAvatar(String name, String imagePath) {
    return Column(
      children: [
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          name,
          style: GLTextStyles.poppinsStyle(
            size: 11.sp,
            color: ColorTheme.black,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildChatItem(
      String name,
      String message,
      String imagePath,
      String time,
      bool hasUnread,
      ) {
    // Handle image path - check if it's a URL or asset
    Widget profileImage;
    if (imagePath.startsWith('http')) {
      profileImage = Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      profileImage = Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        // Handle chat item tap
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            profileImage,
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GLTextStyles.poppinsStyle(
                      size: 14.sp,
                      weight: FontWeight.w600,
                      color: ColorTheme.black,
                    ),
                  ),
                  if (message.isNotEmpty)
                    Text(
                      message,
                      style: GLTextStyles.poppinsStyle(
                        size: 12.sp,
                        color: Colors.grey[600],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            if (time.isNotEmpty)
              Text(
                time,
                style: GLTextStyles.poppinsStyle(
                  size: 12.sp,
                  color: Colors.grey[400],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
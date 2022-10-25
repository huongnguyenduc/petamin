import 'package:Petamin/chat/cubit/chat_detail_cubit.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:Petamin/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatInputField extends StatelessWidget {
  ChatInputField({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;
  final TextEditingController _textMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.0),
        color: AppTheme.colors.superLightPurple,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textMessageController,
              onChanged: (message) => {
                context.read<ChatDetailCubit>().typeMessage(message),
              },
              decoration: InputDecoration(
                  hintText: "Type a message",
                  border: InputBorder.none,
                  hintStyle: CustomTextTheme.caption(context,
                      textColor: AppTheme.colors.grey,
                      fontWeight: FontWeight.w700)),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          GestureDetector(
            onTap: () async => {
              context.read<ChatDetailCubit>().sendMessage(),
              // Scroll to bottom ListView by controller
              await scrollController.animateTo(
                scrollController.position.maxScrollExtent + 75.0,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              ),
              _textMessageController.clear()
            },
            child: SvgPicture.asset(
              "assets/icons/location.svg",
              width: 14.0,
              height: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}

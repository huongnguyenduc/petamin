import 'package:Petamin/theme/app_theme.dart';
import 'package:Petamin/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.0),
                  color: AppTheme.colors.superLightPurple,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Type a message",
                            border: InputBorder.none,
                            hintStyle: CustomTextTheme.caption(context,
                                textColor: AppTheme.colors.grey,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    SvgPicture.asset("assets/icons/location.svg"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

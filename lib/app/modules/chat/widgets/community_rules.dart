import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:flutter/material.dart';

class CommunityRules extends StatelessWidget {
  const CommunityRules({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //rule 1
        Text(
          '1. Be respectful and kind.',
          style: CustomTextStyle.communityRulesHeader(AppColors.black),
        ),
        Text(
          '• Treat others as you would like to be treated.\n• Avoid offensive language, personal attacks, or hate speech.\n• Respect everyone\'s boundaries and preferences.',
          style: TextStyle(
            color: AppColors.thirdColor,
          ),
        ),

        //rule 2
        Text(
          '2. Stay safe.',
          style: CustomTextStyle.communityRulesHeader(AppColors.black),
        ),
        Text(
          '• Never share personal information such as your full name, address, or financial details.\n• Meet in public places for the first few dates.\n• Tell a friend or family member where you are going and who you are meeting.\n• Trust your instincts and end a conversation or date if you feel uncomfortable.',
          style: TextStyle(
            color: AppColors.thirdColor,
          ),
        ),

        //rule 3
        Text(
          '3. Be honest and authentic.',
          style: CustomTextStyle.communityRulesHeader(AppColors.black),
        ),
        Text(
          '• Use your own photos and represent yourself accurately.\n• Be upfront about your intentions and expectations.\n• Don\'t misrepresent your age, interests, or relationship status.',
          style: TextStyle(
            color: AppColors.thirdColor,
          ),
        ),

        //rule 4
        Text(
          '4. Keep it appropriate.',
          style: CustomTextStyle.communityRulesHeader(AppColors.black),
        ),
        Text(
          '• No nudity, sexually suggestive content, or harassment.\n• No spam, advertising, or commercial activity.\n• Do not promote violence, hate speech, or illegal activities.',
          style: TextStyle(
            color: AppColors.thirdColor,
          ),
        ),

        //rule 5
        Text(
          '5. Report any violations.',
          style: CustomTextStyle.communityRulesHeader(AppColors.black),
        ),
        Text(
          '• If you see something that doesn\'t feel right, report it to us immediately.\n• We take all reports seriously and will investigate any potential violations of our community rules.',
          style: TextStyle(
            color: AppColors.thirdColor,
          ),
        ),
      ],
    );
  }
}

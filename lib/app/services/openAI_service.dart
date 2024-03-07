import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dafa/app/core/values/app_consts.dart';

class OpenAIService {
  final openAI = OpenAI.instance.build(
    token: AppConsts.openAI_API_Key,
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 10)),
    enableLog: true,
  );

  Future<bool> CommunityRulesViolationCheck(List<String> messages) async {
    String promt =
        'Among the following sentences, which one is a sentence that has violated community rules. If there is at least 1 sentence violating community rules, answer only with the word \'True\'; if not, answer only with the word \'False\':\n';
    messages.forEach(
      (message) {
        promt = promt + '\'' + message + '\'\n';
      },
    );
    final request = ChatCompleteText(
      model: GptTurbo0631Model(),
      maxToken: 200,
      messages: [
        Messages(
          role: Role.user,
          content: promt,
        ),
      ],
    );
    final response = await openAI.onChatCompletion(request: request);
    String answer = '';
    for (var element in response!.choices) {
      if (element.message != null) {
        answer = element.message!.content;
      }
    }
    if (answer == 'True') {
      return true;
    } else {
      return false;
    }
  }

  Future<String> ChatBotReply(String message) async {
    String promt =
        'Bạn tên là Cupid, nhiệm vụ của bạn chỉ là tư vấn về tình yêu, không trả lời câu hỏi không liên quan đến tình yêu, hãy trả lời câu hỏi sau: ' +
            message;
    final request = ChatCompleteText(
      model: GptTurbo0631Model(),
      maxToken: 500,
      messages: [
        Messages(
          role: Role.user,
          content: promt,
        ),
      ],
    );
    final response = await openAI.onChatCompletion(request: request);
    String answer = 'Xin hãy đặt câu hỏi khác.';
    for (var element in response!.choices) {
      if (element.message != null) {
        answer = element.message!.content;
      }
    }
    return answer;
  }

  Future<String> SuggestRep(String message) async {
    String promt =
        'Hãy giúp user tán tỉnh đối phương bằng cách trả lời tin nhắn sau, chỉ cần nội dung câu trả lời chứ không cần những phần thừa: ' +
            message;
    final request = ChatCompleteText(
      model: GptTurbo0631Model(),
      maxToken: 200,
      messages: [
        Messages(
          role: Role.user,
          content: promt,
        ),
      ],
    );
    final response = await openAI.onChatCompletion(request: request);
    String answer = '';
    for (var element in response!.choices) {
      if (element.message != null) {
        answer = element.message!.content;
      }
    }
    return answer;
  }
}

import 'package:petamin_repository/petamin_repository.dart';

class Conversation {
  String id;
  LastMessage lastMessage;
  Profile partner;

  Conversation({
    required this.id,
    required this.lastMessage,
    required this.partner,
  });
}

import 'package:commons/commons.dart';
import 'package:finplus/layers/domain/entities/room_model.dart';
import 'package:finplus/layers/domain/repository/chat_repository.dart';

class ChatRoomController extends GetxController {
  final ChatRepository _chatRepository;

  final Rx<List<RoomModel>> _rooms = Rx([]);

  ChatRoomController(this._chatRepository);

  List<RoomModel> get rooms => _rooms.value;

  @override
  void onReady() {
    _getChatRooms();
    super.onReady();
  }

  Future<void> _getChatRooms() async {
    final user = _chatRepository.getUserFromStorage();
    if (user != null) {
      final res = await _chatRepository.getRooms(user: user);

      res.map((right) {
        if (right != null) {
          _rooms.value = right;
        }
      });
      
    }
  }
}

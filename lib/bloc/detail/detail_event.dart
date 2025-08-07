abstract class DetailEvent {}

class GetPostDetail extends DetailEvent {
  final int id;

  GetPostDetail(this.id);
}

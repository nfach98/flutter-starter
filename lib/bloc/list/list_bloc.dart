import 'package:bloc/bloc.dart';
import 'package:starter/bloc/list/list_event.dart';
import 'package:starter/bloc/list/list_state.dart';
import 'package:starter/network/post_repository.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final PostRepository postRepository;

  ListBloc({required this.postRepository}) : super(ListState.initial()) {
    on<GetPosts>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
      ));
      final result = await postRepository.getPosts();
      emit(state.copyWith(
        isLoading: false,
        posts: result,
      ));
    });
  }
}

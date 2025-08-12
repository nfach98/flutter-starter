import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:starter/bloc/list/list_event.dart';
import 'package:starter/bloc/list/list_state.dart';
import 'package:starter/network/post_repository.dart';
import 'package:starter/utils/shared_preferences.dart';

@injectable
class ListBloc extends Bloc<ListEvent, ListState> {
  final PostRepository postRepository;
  final SharedPreferences sp;

  ListBloc({
    required this.postRepository,
    required this.sp,
  }) : super(ListState.initial()) {
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

    on<Logout>((event, emit) async {
      await sp.remove('username');
      emit(state.copyWith(
        isLogout: true,
      ));
    });
  }
}

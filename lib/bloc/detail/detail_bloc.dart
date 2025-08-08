import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:starter/bloc/detail/detail_event.dart';
import 'package:starter/bloc/detail/detail_state.dart';
import 'package:starter/network/post_repository.dart';

@injectable
class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final PostRepository postRepository;

  DetailBloc({required this.postRepository}) : super(DetailState.initial()) {
    on<GetPostDetail>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
      ));
      final result = await postRepository.getPostDetail(event.id);
      emit(state.copyWith(
        isLoading: false,
        post: result,
      ));
    });
  }
}

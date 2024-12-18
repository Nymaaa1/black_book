import 'package:black_book/bloc/refresh_token/bloc.dart';
import 'package:black_book/bloc/refresh_token/event.dart';
import 'package:black_book/models/category/category_response.dart';
import 'package:black_book/models/login/authentication.dart';
import 'package:black_book/service/api.dart';
import 'package:black_book/util/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'event.dart';
import 'state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<CreateCategoryEvent>((event, emit) async {
      emit(CategoryLoading());
      try {
        final apiService = ApiTokenService(Utils.getToken());
        var body = {"name": event.name, "parent": event.parent};
        Response response =
            await apiService.postRequest('/v1/category/create', body: body);
        AuthenticationResponseModel dataResponse =
            AuthenticationResponseModel.fromJson(response.data);
        if (response.statusCode == 200 && dataResponse.status == "success") {
          emit(CategorySuccess());
        } else if (dataResponse.status == "error" &&
            dataResponse.message.reason == "auth_token_error") {
          final bloc = RefreshBloc();
          bloc.add(const RefreshTokenEvent());
          emit(CategoryFailure("Token"));
        } else if (dataResponse.status == "error" &&
            dataResponse.message.show) {
          emit(CategoryFailure(dataResponse.message.text!));
        } else {
          emit(CategoryFailure("Серверийн алдаа"));
        }
      } catch (ex) {
        emit(CategoryFailure("Серверийн алдаа"));
      }
    });
    on<GetCategoryEvent>((event, emit) async {
      emit(GetCategoryLoading());
      try {
        String accessToken = Utils.getToken();
        final apiService = ApiTokenService(accessToken);
        Response response = await apiService
            .getRequest('/v1/category/my/list?parent=${event.type}');
        CategoryResponseModel dataResponse =
            CategoryResponseModel.fromJson(response.data);
        if (response.statusCode == 200 && dataResponse.status == "success") {
          emit(GetCategorySuccess(dataResponse.data!));
        } else if (dataResponse.status == "error" &&
            dataResponse.message.reason == "auth_token_error") {
          final bloc = RefreshBloc();
          bloc.add(const RefreshTokenEvent());
          emit(GetCategoryFailure("Token"));
        } else if (dataResponse.status == "error" &&
            dataResponse.message.show) {
          emit(GetCategoryFailure(dataResponse.message.text!));
        } else {
          emit(GetCategoryFailure("Серверийн алдаа"));
        }
      } catch (ex) {
        emit(GetCategoryFailure("Серверийн алдаа"));
      }
    });
  }
}

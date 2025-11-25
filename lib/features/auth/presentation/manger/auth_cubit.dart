
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/config/api_sevice.dart';
import '../../../../core/config/shered_perferences.dart';
import '../../Model/profile_model.dart';
import '../model/shops_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  /////هنعمل منها object ///
  AuthCubit(this.apiService) : super(AuthInitial());
  ApiService apiService;
  Dio dio = Dio();

  ///login
  void login({
    required String email,
    required String password,
  }) async {
    ///call state here ///
    emit(LoginLoading());
    print('AA');
    print(email);
    print(password);
    try {
      final response = await apiService.postData(
        url: "clients/login",
        data: {
          "email": email,
          "password": password,
        },
      );
      print('B');
      if (response.statusCode == 200) {
        /// token for sucess for sharred perference/////
        emit(LoginSuccess());
        print("B ${response.data}  ");
        CashHelper.saveData(
            key: MyCashKey.token, value: response.data["payload"]["token"]);
        // final SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString("token", response.data["payload"]["token"]);
      } else {
        emit(LoginErrer());
        print("B ${response.data}  ");
      }
    } catch (e) {
      emit(LoginErrer());
      print("B Error${e}  ");
    }
    // // final response = await dio.post(
    // emit(RegisterLoading());
    // try {
    //   final response =
    //       await dio.post("https://probar-ps.com/api/v2/clients/login", data: {
    //     "email": email,
    //     "password": password,
    //   });
    //   if (response.statusCode == 201 || response.statusCode == 201) {
    //     emit(RegisterSuccess());
    //   } else {
    //     emit(RegisterErrer(e.toString()));
    //   }
    // } catch (e) {
    //   emit(RegisterErrer(e.toString()));
    // } //   data: {
    //     "email": email,
    //     "password": password,
    //   },
    // );
    // print(response.data);
    // print(response.statusCode);
  }

  /// Registr///////
  void register({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      final response = await apiService.getData(
        url: "clients/register",
        data: {
          "email": email,
          "phone": phone,
          "password": password,
          "name": name,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(RegisterSuccess());
        CashHelper.saveData(
            key: MyCashKey.token, value: response.data["payload"]["token"]);

        // final SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString("token", response.data["payload"]["token"]);
      } else {
        // print("error in else response ${response.data["message"]}");

        emit(RegisterErrer(response.data["message"]));
      }
    } on DioException catch (e) {
      emit(RegisterErrer("${e.response?.data["message"]}"));
    }
  }

  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController genderC = TextEditingController();

  ModeleProfile? modelProfile;

  void getProfie() async {
    emit(GetProfileLoading());
    String? token = CashHelper.getData(key: MyCashKey.token);

    /// take object from shrredperfernce////
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token =prefs.getString('token');

    try {
      final response = await apiService.getData(
        url: "clients",
        data: {
          "email": emailC,
          "phone": phoneC,
          "name": nameC,
        },
      );
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = ModeleProfile.fromJson(response.data);
        modelProfile = user;
        nameC.text = user.payload?.name ?? '';
        emailC.text = user.payload?.email ?? '';
        phoneC.text = user.payload?.phone ?? '';
        genderC.text = user.payload?.gender ?? '';

        emit(GetProfileSuccess());
      } else {
        emit(GetProfileError());
      }
    } catch (e) {
      emit(GetProfileError());
    } //   data: {
    //     "email": email,
    //     "password": password,
    //   },
    // );
    // print(response.data);
    // print(response.statusCode);
  }

  void updateProfie() async {
    emit(UpdateProfieLoading());

    /// take object from shrredperfernce////
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    /// map for updating    .///
    FormData formData = FormData.fromMap({
      "name": nameC.text,
      "email": emailC.text,
      "phone": phoneC.text,
    });

    try {
      final response = await apiService.postData(
        url: "clients",
        data: formData,
      );
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = ModeleProfile.fromJson(response.data);
        modelProfile = user;
        nameC.text = user.payload?.name ?? '';
        emailC.text = user.payload?.email ?? '';
        phoneC.text = user.payload?.phone ?? '';
        genderC.text = user.payload?.gender ?? '';

        emit(UpdateProfieSuccess());
        String? token = CashHelper.getData(key: MyCashKey.token);
      } else {
        emit(UpdateProfieError());
      }
    } catch (e) {
      emit(UpdateProfieError());
    } //   data: {
    //     "email": email,
    //     "password": password,
    //   },
    // );
    // print(response.data);
    // print(response.statusCode);
  }

  ShopModel? shopModel;
  void getShops() async {
    emit(GetShoppingLoading());
    print('A');
    try {
      final response = await apiService.getData(
        // url: "clients/Shops"
        url: "clients/shops",
      );
      print('AAA');

      final user = ShopModels?.fromJson(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = ShopModel.fromJson(response.data);
        shopModel = user;
        emit(GetShoppingSuccess());
        print('BB');
      } else {
        emit(GetShoppingeError());
      }
    } catch (e) {
      emit(GetShoppingeError());
    }
  }

  void addOrRemoveFavorite(String? shopId) async {
    emit(AddOrRemoveFavoriteLoading());
    try {
      final response = await apiService.getData(url: "clients/favorites",
          data: {"shopId":shopId});
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddOrRemoveFavoriteSuccess());
        print("llllllllllllll");
      } else {
        emit(AddOrRemoveFavoriteError());
        print("kkkkkkkkkkkkkkkkkk");

      }
    } catch (e) {
      emit(AddOrRemoveFavoriteError());
    }
  }

  ShopModel? shopFavoriteList;
  void getFavoriteList(String? shopId) async {
    emit(GetFavoriteLoading());
    try {
      final response = await apiService.getData(url: "clients/favorites",
          data: {"shopId":shopId});
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(GetFavoriteSuccess());
        print("llllllllllllll");
      } else {
        emit(GetFavoriteError());
        print("kkkkkkkkkkkkkkkkkk");

      }
    } catch (e) {
      emit(GetFavoriteError());
    }
  }
}

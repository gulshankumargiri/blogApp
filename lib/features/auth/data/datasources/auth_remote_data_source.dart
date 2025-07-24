import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_prof_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  // This property is used to get the current user session
  Session? get currentUserSession; 

  // This method is used to signup a user with email and password
  Future<UserModel> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  // This method is used to login a user with email and password
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  // This method is used to get the current user data
  Future<UserModel?> getCurrentUserData();
}


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async{
    try{
      final response = await supabaseClient.auth.signInWithPassword(
          password: password,
          email: email,

      );
      if(response.user == null){
        throw const ServerException('User Not Found!');
      }
      return UserModel.fromJson(response.user!.toJson());
    }catch (e){
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async{
  try{
   final response = await supabaseClient.auth.signUp(
      password: password,
      email: email,
      data: {
        'name':name,
      }
    );
   if(response.user == null){
     throw const ServerException('User is Null!');
   }
   return UserModel.fromJson(response.user!.toJson());
  }catch (e){
throw ServerException(e.toString());
  }
  }

  @override
  Future<UserModel?> getCurrentUserData() async{
  try{
    if(currentUserSession != null){
      final userData = await supabaseClient.from('profiles').select().eq(
        'id', currentUserSession!.user.id,
      );
      return UserModel.fromJson(userData.first).copyWith(
        email: currentUserSession!.user.email,
      );
    }
 return null;
  }catch (e){
    throw ServerException(e.toString());
      }
  }

}

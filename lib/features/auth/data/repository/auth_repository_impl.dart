import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/core/common/entities/user_profile.dart';
import 'package:blog_app/features/auth/data/models/user_prof_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  const AuthRepositoryImpl(this.remoteDataSource,this.connectionChecker);

  @override
  Future<Either<Failure, User>> currentUser() async {

    try{
      if(!await (connectionChecker.isConnected)){
       final session = remoteDataSource.currentUserSession;
       if(session==null){
         return  left(Failure('User not Logged In'));
       }
       return right(UserModel(
           id: session.user.id,
           email: session.user.email ??'',
           name: ''));
      }
      final user = await remoteDataSource.getCurrentUserData();
      if(user == null){
        return left(Failure("user is not logged in!"));
      }
      return right(user);

    }on ServerException catch (e){ 
      return left(Failure(e.message));
    }
  }

  // Login with Email Password
  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  })async {
 return _getUser(() async => await
          remoteDataSource.loginWithEmailPassword(
         email: email,
         password: password));
  }

  // SignUp with Email Password Name
  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  })async {
   return _getUser(() async => await
       remoteDataSource.signupWithEmailPassword(
       name: name,
       email: email,
       password: password
   ) ,);

  }

  // get user Exceptions
  Future<Either<Failure,User>> _getUser(

      Future<User> Function() fn,
      ) async{
    try{
      if(!await (connectionChecker.isConnected)){
        return left(Failure('No internet access!'));
      }
      final user= await fn();
      return right(user);
    }on sb.AuthException catch (e){
      return left(Failure(e.message),);
    } on ServerException catch (e){
      return left(Failure(e.message));
    }
  }

}

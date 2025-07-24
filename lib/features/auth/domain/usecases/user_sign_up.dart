import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecases/usecases.dart';
import 'package:blog_app/core/common/entities/user_profile.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements Usecase<User, UserSignUpParams> {

  final AuthRepository authRepository;

  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {

   return await authRepository.signUpWithEmailPassword(

      name: params.name,
      email: params.email,
      password: params.password,
      
    );
  }
}

class UserSignUpParams {
  final String email;
  final String name;
  final String password;

  UserSignUpParams({
   required this.name,
   required this.password,
   required this.email,});
}

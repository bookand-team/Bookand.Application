import 'package:bookand/notifier/login/login_state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../const/login_result.dart';
import '../../data/repository/login/login_repository.dart';
import '../../util/common_util.dart';
import '../../util/logger.dart';

class LoginStateNotifier extends StateNotifier<LoginState> {
  final Ref ref;
  final LoginRepository _loginRepository;

  LoginStateNotifier(this.ref, this._loginRepository) : super(LoginInitial());

  void googleLogin() async {
    state = LoginLoading();

    try {
      final googleSignIn = GoogleSignIn();
      final account = await googleSignIn.signIn();
      final auth = await account?.authentication;
      final accessToken = auth?.accessToken;

      if (accessToken == null) {
        logger.i('사용자에 의해 로그인이 취소됨.');
        state = const LoginError(LoginResult.cancel);
        return;
      }

      final query = {
        'accessToken': accessToken,
        'nickname': account?.displayName,
        'socialType': 'GOOGLE'
      };

      final token = await _loginRepository.fetchLogin(query);
      final encryptionKey = await getEncryptionKey();
      final encryptionBox =
          await Hive.openBox('token', encryptionCipher: HiveAesCipher(encryptionKey));
      encryptionBox.put('token', token);
      state = LoginLoaded();
    } catch (e) {
      logger.e(e.toString());
      state = const LoginError(LoginResult.error);
    }
  }
}

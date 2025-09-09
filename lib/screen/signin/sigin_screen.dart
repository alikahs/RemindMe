import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:remind_task/bloc/auth/login_bloc/login_bloc.dart';
import 'package:remind_task/data/datasources/auth/auth_local_datasources.dart';
import 'package:remind_task/route/route_name.dart';
import 'package:remind_task/style/color_style.dart';
import 'package:remind_task/style/text_style.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

class SiginScreen extends StatefulWidget {
  const SiginScreen({super.key});

  @override
  State<SiginScreen> createState() => _SiginScreenState();
}

class _SiginScreenState extends State<SiginScreen> {
  @override
  void initState() {
    super.initState();
    _googleSignIn.initialize();
  }

  final List<String> userAuthenticateHint = ['email', 'profile'];

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      final account = await _googleSignIn.authenticate(
        scopeHint: userAuthenticateHint,
      );

      final auth = await account.authorizationClient.authorizationForScopes(
        userAuthenticateHint,
      );

      final credential = GoogleAuthProvider.credential(
        accessToken: auth?.accessToken,
        idToken: account.authentication.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      return userCredential;
    } catch (e) {
      debugPrint('Error signing in with Google: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthLocalDatasources().isAuth(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // cek mounted biar aman
              if (!context.mounted) return;
              Get.offAllNamed(RouteName.home);
            });
          }
          // return const SizedBox.shrink();
        }
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/signin_background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Center(
                  child: Text(
                    'RemindMe',
                    style: poppins(
                      color: ColorsStyle.truffleTrouble,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          error: (message) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(message),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                          success: (data) {
                            AuthLocalDatasources().saveAuthData(data);
                            Get.offAllNamed(RouteName.home);
                          },
                        );
                      },
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () => InkWell(
                            onTap: () {
                              _signInWithGoogle().whenComplete(() async {
                                final user = FirebaseAuth.instance.currentUser;
                                if (user != null) {
                                  final nama = user.displayName ?? 'No Name';
                                  final email = user.email ?? 'No Email';
                                  final uuid = user.uid;
                                  final token = await user.getIdToken().then(
                                    (token) => token,
                                  );

                                  if (context.mounted) {
                                    BlocProvider.of<LoginBloc>(context).add(
                                      LoginEvent.login(
                                        email: email,
                                        uuid: uuid,
                                        nama: nama,
                                        token: token!,
                                      ),
                                    );
                                  }
                                }
                              });
                            },
                            child: Container(
                              width: 150.0,
                              height: 70.0,
                              decoration: BoxDecoration(
                                color: ColorsStyle.truffleTrouble,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50.0),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 10.0,
                                children: [
                                  Text(
                                    'Sign In',
                                    style: poppins(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    'assets/images/icon_login.svg',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          loading: () => const CircularProgressIndicator(),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

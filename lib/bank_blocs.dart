import "package:bank/authentication/repository/authentication_repository.dart";
import "package:bank/bank.dart";
import "package:bank/change_password/bloc/change_password_bloc.dart";
import "package:bank/data/bloc/data_bloc.dart";
import "package:bank/data/repository/data_repository.dart";
import "package:bank/forgot_password/bloc/forgot_password_bloc.dart";
import "package:bank/image/bloc/image_bloc.dart";
import "package:bank/image/repository/image_repository.dart";
import "package:bank/internet_connectivity/bloc/internet_connectivity_bloc.dart";
import "package:bank/login/bloc/login_bloc.dart";
import "package:bank/profile/repository/profile_repository.dart";
import "package:bank/profile_picture/bloc/profile_picture_bloc.dart";
import "package:bank/profile_picture/repository/profile_picture_repository.dart";
import "package:bank/register/bloc/register_bloc.dart";
import "package:bank/request_reset_password/bloc/request_reset_password_bloc.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:connectivity_plus/connectivity_plus.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:image_picker/image_picker.dart";

class BankBlocs extends StatelessWidget {
  const BankBlocs({super.key});
  static final Connectivity _connectivity = Connectivity();
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DataRepository>(
          create: (context) =>
              DataRepository(firestore: FirebaseFirestore.instance),
        ),
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => AuthenticationRepository(
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
        RepositoryProvider<ProfileRepository>(
          create: (context) => const ProfileRepository(),
        ),
        RepositoryProvider<ImageRepository>(
          create: (context) => ImageRepository(
            imagePicker: ImagePicker(),
          ),
        ),
        RepositoryProvider<ProfilePictureRepository>(
          create: (context) => ProfilePictureRepository(
            firebaseStorage: FirebaseStorage.instance,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DataBloc>(
            create: (context) => DataBloc(context.read<DataRepository>()),
            // ..add(const DataEvent.onLoadedData()),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
            ),
          ),
          BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(
              context.read<AuthenticationRepository>(),
            ),
          ),
          BlocProvider<ForgotPasswordBloc>(
            create: (context) => ForgotPasswordBloc(
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
            ),
          ),
          BlocProvider<ChangePasswordBloc>(
            create: (context) => ChangePasswordBloc(
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
            ),
          ),
          BlocProvider<RequestResetPasswordBloc>(
            create: (context) => RequestResetPasswordBloc(
              context.read<AuthenticationRepository>(),
            ),
          ),
          BlocProvider<ImageBloc>(
            create: (context) => ImageBloc(
              imageRepository: context.read<ImageRepository>(),
            ),
          ),
          BlocProvider<ProfilePictureBloc>(
            create: (context) => ProfilePictureBloc(
              profilePictureRepository:
                  context.read<ProfilePictureRepository>(),
            ),
          ),
          BlocProvider<InternetConnectivityBloc>(
            create: (context) => InternetConnectivityBloc(
              connectivity: _connectivity,
            )..add(const InternetConnectivityEvent.onInternetConnected()),
          ),
        ],
        child: const Bank(),
      ),
    );
  }
}

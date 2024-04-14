#!/bin/bash

echo "Criando projeto Flutter completo com Firebase e Bloc"

# Instalar o Flutter SDK
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"
flutter precache
flutter doctor

# Criar um novo projeto Flutter
flutter create meu_app_flutter
cd meu_app_flutter

# Adicionar os pacotes necessários ao pubspec.yaml
cat > pubspec.yaml <<EOF
name: meu_app_flutter
description: Um aplicativo Flutter criado com o script de automação.

environment:
  sdk: ">=2.12.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^1.10.0
  firebase_auth: ^4.5.0
  firebase_database: ^12.1.0
  provider: ^5.0.0
  flutter_bloc: ^8.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
EOF

# Obter dependências do projeto
flutter pub get

# Criar a estrutura de pastas e arquivos
mkdir -p lib/blocs
mkdir -p lib/models
mkdir -p lib/services
mkdir -p lib/screens

# Criar arquivos para a autenticação
touch lib/services/authentication_service.dart
cat > lib/services/authentication_service.dart <<EOF
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User user = result.user;
      return user;
    } catch (error) {
      throw error;
    }
  }

  Future<User> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User user = result.user;
      return user;
    } catch (error) {
      throw error;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
EOF

# Criar um modelo de usuário
touch lib/models/user_model.dart
cat > lib/models/user_model.dart <<EOF
class UserModel {
  final String uid;
  final String email;

  UserModel({required this.uid, required this.email});
}
EOF

# Criar um bloco de autenticação
touch lib/blocs/authentication_bloc.dart
cat > lib/blocs/authentication_bloc.dart <<EOF
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meu_app_flutter/models/user_model.dart';
import 'package:meu_app_flutter/services/authentication_service.dart';

class AuthenticationBloc extends Bloc {
  final AuthenticationService authenticationService;

  AuthenticationBloc({required this.authenticationService}) : super(Initial());

  @override
  Stream mapEventToState(AuthenticationEvent event) async* {
    if (event is AppStarted) {
      try {
        final currentUser = authenticationService.getCurrentUser();
        if (currentUser != null) {
          yield Authenticated(user: currentUser);
        } else {
          yield Unauthenticated();
        }
      } catch (error) {
        yield Unauthenticated();
      }
    }
    if (event is LoggedIn) {
      yield Authenticated(user: event.user);
    }
    if (event is LoggedOut) {
      yield Unauthenticated();
      authenticationService.signOut();
    }
  }
}

abstract class AuthenticationEvent {}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final UserModel user;

  LoggedIn({required this.user});
}

class LoggedOut extends AuthenticationEvent {}
EOF

# Criar um serviço para gerenciar o usuário autenticado
touch lib/services/user_service.dart
cat > lib/services/user_service.dart <<EOF
import 'package:meu_app_flutter/models/user_model.dart';

class UserService {
  UserModel _currentUser;

  UserModel get currentUser => _currentUser;

  void setCurrentUser(UserModel user) {
    _currentUser = user;
  }
}
EOF

# Criar telas de autenticação
touch lib/screens/login_screen.dart
touch lib/screens/register_screen.dart

# Criar uma página inicial
touch lib/screens/home_screen.dart

# Criar uma página de perfil
touch lib/screens/profile_screen.dart

# Criar uma página de configurações
touch lib/screens/settings_screen.dart

# Criar uma tela de loading
touch lib/screens/loading_screen.dart

# Criar um arquivo para gerenciar rotas
touch lib/route_generator.dart

# Atualizar o arquivo main.dart para configurar a inicialização do aplicativo
cat > lib/main.dart <<EOF
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meu_app_flutter/blocs/authentication_bloc.dart';
import 'package:meu_app_flutter/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationBloc(authenticationService: AuthenticationService())),
      ],
      child: MaterialApp(
        title: 'Meu App Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/loading',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
EOF

# Executar o aplicativo Flutter
flutter run


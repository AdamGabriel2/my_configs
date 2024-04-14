#!/bin/bash

echo "Criando projeto Flutter completo"

# Instalar o Flutter SDK
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"
flutter precache
flutter doctor

# Criar um novo projeto Flutter
flutter create meu_app_flutter
cd meu_app_flutter

# Criar diretórios para componentes, modelos, serviços e telas
mkdir lib/components
mkdir lib/models
mkdir lib/services
mkdir lib/screens

# Criar arquivos de exemplo para componentes, modelos, serviços e telas
touch lib/components/button.dart
touch lib/models/user.dart
touch lib/services/api_service.dart
touch lib/screens/home_screen.dart
touch lib/screens/login_screen.dart

# Conteúdo do arquivo button.dart
cat > lib/components/button.dart <<EOF
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  MyButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
EOF

# Conteúdo do arquivo user.dart
cat > lib/models/user.dart <<EOF
class User {
  final String id;
  final String name;
  final String email;

  User({this.id, this.name, this.email});
}
EOF

# Conteúdo do arquivo api_service.dart
cat > lib/services/api_service.dart <<EOF
import 'package:meu_app_flutter/models/user.dart';

class ApiService {
  Future<User> getUser() async {
    // Simulação de chamada de API
    await Future.delayed(Duration(seconds: 2));
    return User(id: '1', name: 'John Doe', email: 'john@example.com');
  }
}
EOF

# Conteúdo do arquivo home_screen.dart
cat > lib/screens/home_screen.dart <<EOF
import 'package:flutter/material.dart';
import 'package:meu_app_flutter/components/button.dart';
import 'package:meu_app_flutter/models/user.dart';
import 'package:meu_app_flutter/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User user;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    final ApiService apiService = ApiService();
    final fetchedUser = await apiService.getUser();
    setState(() {
      user = fetchedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Welcome, ${user.name}!'),
                  SizedBox(height: 20),
                  MyButton(
                    text: 'Logout',
                    onPressed: () {
                      // Implement logout logic here
                    },
                  ),
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
EOF

# Conteúdo do arquivo login_screen.dart
cat > lib/screens/login_screen.dart <<EOF
import 'package:flutter/material.dart';
import 'package:meu_app_flutter/components/button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: MyButton(
          text: 'Login',
          onPressed: () {
            // Implement login logic here
          },
        ),
      ),
    );
  }
}
EOF

# Atualizar o arquivo main.dart para incluir rotas e iniciar o aplicativo
cat > lib/main.dart <<EOF
import 'package:flutter/material.dart';
import 'package:meu_app_flutter/screens/home_screen.dart';
import 'package:meu_app_flutter/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
EOF

# Executar o aplicativo Flutter
flutter run


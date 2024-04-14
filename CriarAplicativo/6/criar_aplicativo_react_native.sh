#!/bin/bash

echo "Criar Projeto em React Native (JavaScript) com Firebase para autenticação e armazenamento de dados"

# Instalar o ambiente de desenvolvimento do React Native
npm install -g react-native-cli
brew install cocoapods # Apenas para usuários macOS

# Criar um novo projeto React Native
react-native init MeuAppReactNative

# Entrar no diretório do projeto
cd MeuAppReactNative

# Instalar dependências do Firebase
npm install @react-native-firebase/app @react-native-firebase/auth @react-native-firebase/database

# Criar a estrutura de pastas do projeto
mkdir src
mkdir src/screens
mkdir src/components

# Criar a tela de login
touch src/screens/LoginScreen.js
cat > src/screens/LoginScreen.js <<EOF
import React, { useState } from 'react';
import { View, Text, TextInput, Button } from 'react-native';
import auth from '@react-native-firebase/auth';

const LoginScreen = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleLogin = async () => {
    try {
      const userCredentials = await auth().signInWithEmailAndPassword(email, password);
      console.log('User logged in successfully!', userCredentials);
    } catch (error) {
      console.error('Error logging in:', error);
    }
  };

  return (
    <View>
      <Text>Email:</Text>
      <TextInput
        value={email}
        onChangeText={setEmail}
        placeholder="Email"
      />
      <Text>Password:</Text>
      <TextInput
        value={password}
        onChangeText={setPassword}
        placeholder="Password"
        secureTextEntry
      />
      <Button
        title="Login"
        onPress={handleLogin}
      />
    </View>
  );
};

export default LoginScreen;
EOF

# Criar a tela de registro
touch src/screens/RegisterScreen.js
cat > src/screens/RegisterScreen.js <<EOF
import React, { useState } from 'react';
import { View, Text, TextInput, Button } from 'react-native';
import auth from '@react-native-firebase/auth';

const RegisterScreen = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleRegister = async () => {
    try {
      const userCredentials = await auth().createUserWithEmailAndPassword(email, password);
      console.log('User registered successfully!', userCredentials);
    } catch (error) {
      console.error('Error registering user:', error);
    }
  };

  return (
    <View>
      <Text>Email:</Text>
      <TextInput
        value={email}
        onChangeText={setEmail}
        placeholder="Email"
      />
      <Text>Password:</Text>
      <TextInput
        value={password}
        onChangeText={setPassword}
        placeholder="Password"
        secureTextEntry
      />
      <Button
        title="Register"
        onPress={handleRegister}
      />
    </View>
  );
};

export default RegisterScreen;
EOF

# Configurar a navegação entre telas com React Navigation
npm install @react-navigation/native @react-navigation/stack
cd ios && pod install && cd ..

# Atualizar o arquivo App.js com a navegação entre telas
cat > App.js <<EOF
import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import LoginScreen from './src/screens/LoginScreen';
import RegisterScreen from './src/screens/RegisterScreen';

const Stack = createStackNavigator();

const App = () => {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen name="Login" component={LoginScreen} />
        <Stack.Screen name="Register" component={RegisterScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
};

export default App;
EOF

# Criar um serviço para gerenciamento de autenticação (AuthService)
mkdir src/services
touch src/services/AuthService.js
cat > src/services/AuthService.js <<EOF
import auth from '@react-native-firebase/auth';

const AuthService = {
  async login(email, password) {
    try {
      const userCredentials = await auth().signInWithEmailAndPassword(email, password);
      return userCredentials.user;
    } catch (error) {
      throw error;
    }
  },

  async register(email, password) {
    try {
      const userCredentials = await auth().createUserWithEmailAndPassword(email, password);
      return userCredentials.user;
    } catch (error) {
      throw error;
    }
  },

  async logout() {
    try {
      await auth().signOut();
    } catch (error) {
      throw error;
    }
  },
};

export default AuthService;
EOF

# Atualizar os arquivos LoginScreen.js e RegisterScreen.js para utilizar o AuthService
sed -i '' '/import auth/a\
import AuthService from '../services/AuthService';
' src/screens/LoginScreen.js
sed -i '' '/import auth/a\
import AuthService from '../services/AuthService';
' src/screens/RegisterScreen.js

# Atualizar os métodos handleLogin e handleRegister para chamar os métodos do AuthService
sed -i '' '/const handleLogin = async () => {/a\
    try {\
      await AuthService.login(email, password);\
      console.log('User logged in successfully!');\
    } catch (error) {\
      console.error('Error logging in:', error);\
    }\
'' src/screens/LoginScreen.js

sed -i '' '/const handleRegister = async () => {/a\
    try {\
      await AuthService.register(email, password);\
      console.log('User registered successfully!');\
    } catch (error) {\
      console.error('Error registering user:', error);\
    }\
'' src/screens/RegisterScreen.js

# Criar um serviço para gerenciamento de dados (DataService)
touch src/services/DataService.js
cat > src/services/DataService.js <<EOF
import database from '@react-native-firebase/database';

const DataService = {
  async getData() {
    try {
      const snapshot = await database().ref('data').once('value');
      return snapshot.val();
    } catch (error) {
      throw error;
    }
  },

  async setData(data) {
    try {
      await database().ref('data').set(data);
    } catch (error) {
      throw error;
    }
  },
};

export default DataService;
EOF

# Criar uma tela para exibir e modificar dados (DataScreen)
touch src/screens/DataScreen.js
cat > src/screens/DataScreen.js <<EOF
import React, { useState, useEffect } from 'react';
import { View, Text, TextInput, Button } from 'react-native';
import DataService from '../services/DataService';
import ButtonComponent from '../components/ButtonComponent';
import CommonStyles from '../styles/CommonStyles';

const { container } = CommonStyles;

const DataScreen = () => {
  const [data, setData] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  const fetchData = async () => {
    setIsLoading(true);
    try {
      const fetchedData = await DataService.getData();
      setData(fetchedData);
    } catch (error) {
      console.error('Error fetching data:', error);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchData();
  }, []);

  const handleSaveData = async () => {
    try {
      setIsLoading(true);
      await DataService.setData(data);
      console.log('Data saved successfully!');
    } catch (error) {
      console.error('Error saving data:', error);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <View style={container}>
      <Text>Data:</Text>
      <TextInput
        value={data}
        onChangeText={setData}
        placeholder="Enter data"
        style={{ borderWidth: 1, borderColor: 'gray', padding: 10, marginBottom: 10 }}
      />
      <ButtonComponent
        title="Save Data"
        onPress={handleSaveData}
        disabled={isLoading}
      />
    </View>
  );
};

export default DataScreen;
EOF

# Atualizar o arquivo App.js para incluir a tela de dados (DataScreen)
sed -i '' '/import RegisterScreen/a\
import DataScreen from './src/screens/DataScreen';
' App.js

sed -i '' 's/            <Stack.Screen name="Register" component={RegisterScreen} \/>/            <Stack.Screen name="Data" component={DataScreen} \/>\
            <Stack.Screen name="Register" component={RegisterScreen} \/>/' App.js

# Executar o aplicativo React Native
react-native run-android # ou react-native run-ios


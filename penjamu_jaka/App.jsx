import React, { useEffect, useState } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import AsyncStorage from '@react-native-async-storage/async-storage';
import AuthStack from './src/Navigation/AuthStack';
import OnOrderStack from './src/Navigation/OnOrderStack';
import Appstack from './src/Navigation/Appstack';

const App = () => {
  const [userToken, setUserToken] = useState(null);

  useEffect(() => {
    const checkToken = async () => {
      try {
        const token = await AsyncStorage.getItem('userToken');
        setUserToken(token);
      } catch (error) {
        console.error('Error retrieving user token:', error);
      }
    };

    checkToken();
  }, []);

  return (
    <NavigationContainer>
      {userToken ? <Appstack /> : <AuthStack />}
    </NavigationContainer>
  );
};

export default App;

import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';
import OnBoardingScreen from '../Screens/OnBoardingScreen';
import LoginScreen from '../Screens/LoginScreen';
import RegisterScreen from '../Screens/RegisterScreen';
import OTPScreen from '../Screens/OTPScreen';
import Appstack from './Appstack';
import VerifikasiKTM from '../Screens/VerifikasiKTM';
import WaitingScreen from '../Screens/WaitingScreen';

const Stack = createStackNavigator();

const AuthStack = () => {
    return (
        <Stack.Navigator screenOptions={{ headerShown: false }}>
            <Stack.Screen name="OnBoarding" component={OnBoardingScreen} />
            <Stack.Screen name="Login" component={LoginScreen} />
            <Stack.Screen name="Register" component={RegisterScreen} />
            <Stack.Screen name="OTP" component={OTPScreen} />
            <Stack.Screen name="AppStack" component={Appstack} />
            <Stack.Screen name="WaitingScreen" component={WaitingScreen} />
            <Stack.Screen name="VerfikasiKTM" component={VerifikasiKTM} />
        </Stack.Navigator>
    );
};

export default AuthStack;

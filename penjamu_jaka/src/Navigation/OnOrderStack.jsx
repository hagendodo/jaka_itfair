import { View, Text } from 'react-native'
import React from 'react'
import { createStackNavigator } from '@react-navigation/stack';
import DetailOrder from '../Screens/DetailOrder';
import ChatScreen from '../Screens/ChatScreen';
import Appstack from './Appstack';

const Stack = createStackNavigator();


const OnOrderStack = () => {
    return (
        <Stack.Navigator initialRouteName="DetailOrder" screenOptions={{ headerShown: false }}>
            <Stack.Screen name="DetailOrder" component={DetailOrder} />
            <Stack.Screen name="Chat" component={ChatScreen} />
            <Stack.Screen name="AppStack" component={Appstack} />
        </Stack.Navigator>
    );
};

export default OnOrderStack
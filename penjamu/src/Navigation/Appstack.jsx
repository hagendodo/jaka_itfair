import React, { useEffect } from 'react';
import { createDrawerNavigator } from '@react-navigation/drawer';
import Homescreen from '../Screens/HomeScreen';
import SettingsScreen from '../Screens/SettingsScreen';
import CustomDrawer from '../Components/CustomDrawer';
import HistoryScreen from '../Screens/HistoryScreen';
import Ionicons from 'react-native-vector-icons/Ionicons';
import Colors from '../Constants/Colors';
import { Dimensions } from 'react-native';
import AuthStack from './AuthStack';
import DetailOrder from '../Screens/DetailOrder';
import ChatScreen from '../Screens/ChatScreen';

const Drawer = createDrawerNavigator();

const Appstack = () => {

    useEffect(() => {

    }, []);

    return (
        <Drawer.Navigator
            drawerContent={props => <CustomDrawer {...props} />}
            screenOptions={{
                headerShown: false,
                drawerStyle: { width: Dimensions.get('window').width - 150 }
            }}
        >
            <Drawer.Screen
                name="Home"
                component={Homescreen}
                options={{
                    drawerIcon: ({ focused, size }) => (
                        <Ionicons name={focused ? 'home' : 'home-outline'} size={size} color={Colors.PRIMARY} />
                    ),
                }}
            />
            <Drawer.Screen
                name="History"
                component={HistoryScreen}
                options={{
                    drawerIcon: ({ focused, size }) => (
                        <Ionicons name={focused ? 'time' : 'time-outline'} size={size} color={Colors.PRIMARY} />
                    ),
                }}
            />
            <Drawer.Screen
                name="Settings"
                component={SettingsScreen}
                options={{
                    drawerIcon: ({ focused, size }) => (
                        <Ionicons name={focused ? 'settings' : 'settings-outline'} size={size} color={Colors.PRIMARY} />
                    ),
                }}
            />
            <Drawer.Screen name="Chat" component={ChatScreen} />
            <Drawer.Screen name="DetailOrder" component={DetailOrder} />
            <Drawer.Screen name="AuthStack" component={AuthStack} options={{ drawerLabel: () => null }} />
        </Drawer.Navigator>
    );
};

export default Appstack;

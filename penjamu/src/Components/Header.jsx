import React, { useEffect, useState } from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import Entypo from 'react-native-vector-icons/Entypo';
import MaterialIcons from 'react-native-vector-icons/MaterialIcons';
import ToggleSwitch from 'toggle-switch-react-native';
import axios from 'axios';
import Colors from '../Constants/Colors';
import Fonts from '../Constants/Fonts';
import AsyncStorage from '@react-native-async-storage/async-storage';

const Header = (props) => {
    const navigation = useNavigation();
    const [isEnabled, setIsEnabled] = useState(false);
    const [userId, setUserId] = useState(null);

    useEffect(() => {
        const fetchUserId = async () => {
            try {
                const id = await AsyncStorage.getItem('userId');
                console.log(id);
                if (id) {
                    setUserId(id);
                }
            } catch (error) {
                console.error('Error retrieving user ID:', error);
            }
        };

        fetchUserId();
    }, []);

    useEffect(() => {
        let interval;

        const checkForNewOrder = async () => {
            try {
                if (isEnabled) { // Check if the switch is enabled
                    const response = await axios.get(`https://jaka-itfair.vercel.app/api/v1/penjamu-activities/check-order/${userId}`);
                    console.log(response.data);
                    if (response.data.status === 'order') {
                        navigation.navigate('DetailOrder');
                    }
                }
            } catch (error) {
                console.error('Error checking for new order:', error);
            }
        };

        if (isEnabled) {
            interval = setInterval(checkForNewOrder, 15000); // Check every 15 seconds
        } else {
            // Clear the interval when the switch is disabled or component unmounts
            clearInterval(interval);
        }

        return () => clearInterval(interval); // Clean up the interval on unmount or switch disable

    }, [isEnabled, navigation, userId]);

    useEffect(() => {
        const fetchStatus = async () => {
            try {
                const status = await AsyncStorage.getItem('onlineStatus');
                console.log(status);
                if (status) {
                    setIsEnabled(true);
                }
            } catch (error) {
                console.error('Error retrieving status:', error);
            }
        };

        fetchStatus();
    }, []);

    const toggleSwitch = async () => {
        try {
            if (isEnabled) {
                const response = await axios.post(`https://jaka-itfair.vercel.app/api/v1/penjamu-activities/${isEnabled ? 'deactivate' : 'activate'}/${userId}`);
                await AsyncStorage.removeItem('onlineStatus');
                console.log(response.data);
            } else {
                const response = await axios.post(`https://jaka-itfair.vercel.app/api/v1/penjamu-activities/${isEnabled ? 'deactivate' : 'activate'}/${userId}`);
                console.log(response.data);
                await AsyncStorage.setItem('onlineStatus', JSON.stringify(response.data.message));
            }
            setIsEnabled(previousState => !previousState);
        } catch (error) {
            console.error('Toggle switch error:', error);
        }
    };


    return (
        <View style={styles.header}>
            <View>
                {props?.goBack === true ? (
                    <TouchableOpacity onPress={() => navigation.goBack()}>
                        <MaterialIcons name="arrow-back-ios" size={22} color={Colors.BLACK} />
                    </TouchableOpacity>
                ) : (
                    <TouchableOpacity onPress={() => navigation.openDrawer()}>
                        <Entypo name="menu" size={25} />
                    </TouchableOpacity>
                )}
            </View>
            {props?.onlineSwitch === true ? (
                <Text style={styles.textWithSwitch}>{props?.name}</Text>
            ) : (
                <Text style={styles.textNoSwitch}>{props?.name}</Text>
            )}
            <View>
                {props?.onlineSwitch === true ? (
                    <ToggleSwitch
                        isOn={isEnabled}
                        onColor={Colors.PRIMARY}
                        offColor={Colors.BLACK}
                        size="medium"
                        animationSpeed={300}
                        onToggle={toggleSwitch}
                    />
                ) : null}
            </View>
        </View>
    );
};

const styles = StyleSheet.create({
    header: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        paddingHorizontal: 20,
        paddingVertical: 15,
        color: Colors.WHITE,
        height: 'auto',
    },
    textWithSwitch: {
        fontFamily: Fonts.bold,
        fontSize: 18,
        color: Colors.BLACK,
    },
    textNoSwitch: {
        fontFamily: Fonts.bold,
        fontSize: 18,
        color: Colors.BLACK,
    },
});

export default Header;

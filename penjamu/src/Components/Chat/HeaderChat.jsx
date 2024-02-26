import React, { useEffect, useState } from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import Entypo from 'react-native-vector-icons/Entypo';
import MaterialIcons from 'react-native-vector-icons/MaterialIcons';
import ToggleSwitch from 'toggle-switch-react-native';
import axios from 'axios';
import Colors from '../../Constants/Colors';
import Fonts from '../../Constants/Fonts';
import AsyncStorage from '@react-native-async-storage/async-storage';

const Header = (props) => {
    const navigation = useNavigation();
    const [isEnabled, setIsEnabled] = useState(false);
    const [userId, setUserId] = useState(null);
    const [hasOrder, setHasOrder] = useState(false);

    useEffect(() => {
        const fetchUserId = async () => {
            try {
                const id = await AsyncStorage.getItem('userId');
                if (id !== null) {
                    setUserId(id);
                }
            } catch (error) {
                console.error('Error retrieving user ID:', error);
            }
        };

        const getDriverStatus = async () => {
            try {
                const status = await AsyncStorage.getItem('driverStatus');
                if (status !== null) {
                    setIsEnabled(status === 'active');
                }
            } catch (error) {
                console.error('Error retrieving driver status:', error);
            }
        };

        fetchUserId();
        getDriverStatus();
    }, []);

    useEffect(() => {
        const checkOrders = async () => {
            try {
                if (userId) {
                    const response = await axios.get(`https://jaka-itfair.vercel.app/api/v1/penjamu-activities/check-order/${userId}`);
                    setHasOrder(response.data.hasOrder || false);
                }
            } catch (error) {
                console.error('Error checking orders:', error);
            }
        };

        checkOrders();
    }, [userId, isEnabled]);

    const toggleSwitch = async () => {
        try {
            if (userId) {
                const response = await axios.post(`https://jaka-itfair.vercel.app/api/v1/penjamu-activities/${isEnabled ? 'deactivate' : 'activate'}/${userId}`);
                console.log(response.data);
                setIsEnabled((previousState) => !previousState);
                await AsyncStorage.setItem('driverStatus', !isEnabled ? 'active' : 'inactive');
            }
        } catch (error) {
            console.error('Toggle switch error:', error);
        }
    };

    useEffect(() => {
        if (hasOrder) {
            navigation.navigate('DetailOrder');
        }
    }, [hasOrder, navigation]);

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

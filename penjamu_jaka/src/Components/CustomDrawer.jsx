import { View, Text, ImageBackground, Image, StyleSheet } from 'react-native'
import React, { useEffect, useState } from 'react'
import { DrawerContentScrollView, DrawerItemList } from '@react-navigation/drawer'
import Colors from '../Constants/Colors';
import Fonts from '../Constants/Fonts';
import Ionicons from 'react-native-vector-icons/Ionicons';
import { TouchableOpacity } from '@gorhom/bottom-sheet';
import AsyncStorage from '@react-native-async-storage/async-storage';
import axios from 'axios';
import { useNavigation } from '@react-navigation/native';

const CustomDrawer = (props) => {
    const [token, setToken] = useState('');
    const navigation = useNavigation();

    useEffect(() => {
        const fetchToken = async () => {
            try {
                const storedToken = await AsyncStorage.getItem('userToken');
                if (storedToken !== null) {
                    const parsedToken = JSON.parse(storedToken);
                    console.log(parsedToken);
                    setToken(parsedToken);
                }
            } catch (error) {
                console.error('Error fetching token:', error);
            }
        };

        fetchToken();
    }, []);

    const handleSignOut = async () => {
        console.log(token);
        try {
            // const requestBody = {
            //     token: token,
            // };

            // const response = await axios.post(
            //     'https://jaka-itfair.vercel.app/api/v1/auth/logout',
            //     requestBody,
            //     {
            //         headers: {
            //             'Content-Type': 'application/json',
            //             Authorization: 'Bearer ' + token,
            //         },
            //     }
            // );

            // console.log(response.data);

            await AsyncStorage.removeItem('userToken');
            navigation.navigate('AuthStack');
        } catch (error) {
            await AsyncStorage.removeItem('userToken');
            navigation.navigate('AuthStack');
            console.error('Sign out error:', error);
        }
    };

    return (
        <View style={styles.container}>
            <DrawerContentScrollView
                {...props}
                contentContainerStyle={styles.drawerContentContainer}>
                <View style={styles.profileContainer}>
                    <Image
                        source={require('../assets/images/user-profile.jpg')}
                        style={styles.profileImage}
                    />
                    <View style={styles.infoContainer}>
                        <Text style={styles.nameText}>
                            John Doe
                        </Text>
                        <Text style={styles.gmailText}>
                            JohnDoe@gmail.com
                        </Text>
                    </View>
                </View>
                <View style={styles.itemListContainer}>
                    <DrawerItemList {...props} />
                </View>
            </DrawerContentScrollView>
            <TouchableOpacity style={styles.signOutButton} onPress={handleSignOut}>
                <Ionicons name="log-out" size={24} color={Colors.RED} />
                <Text style={styles.signOutText}>Sign Out</Text>
            </TouchableOpacity>
        </View>
    )
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    drawerContentContainer: {
        backgroundColor: Colors.PRIMARY,
        flex: 1,
        paddingTop: 20,
    },
    profileContainer: {
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems: 'center',
        paddingRight: 15,
        marginBottom: 20,
    },
    profileImage: {
        height: 55,
        width: 55,
        borderRadius: 40,
        marginRight: 10,
    },
    nameText: {
        fontFamily: Fonts.bold,
        color: Colors.WHITE,
        fontSize: 20,
    },
    itemListContainer: {
        flex: 1,
        backgroundColor: Colors.WHITE,
        paddingTop: 10,
    },
    infoContainer: {
        flexDirection: 'column',
    },
    gmailText: {
        fontFamily: Fonts.semibold,
        color: Colors.BROKENWHITE,
        fontSize: 12,
    },
    signOutButton: {
        flexDirection: 'row',
        alignItems: 'center',
        paddingHorizontal: 20,
        paddingVertical: 15,
        marginBottom: 15,
    },
    signOutText: {
        marginLeft: 10,
        fontFamily: Fonts.bold,
        fontSize: 16,
        color: Colors.BLACK,
    },
});

export default CustomDrawer;

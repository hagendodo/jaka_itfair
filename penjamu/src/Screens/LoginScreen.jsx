import React, { useState } from 'react';
import { View, Text, StyleSheet, Dimensions, TouchableOpacity, Image, Alert, ActivityIndicator, ToastAndroid } from 'react-native';
import Colors from '../Constants/Colors';
import Fonts from '../Constants/Fonts';
import { TextInput } from 'react-native-element-textinput';
import { useNavigation } from '@react-navigation/native';
import axios from 'axios';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { ALERT_TYPE, Dialog, AlertNotificationRoot } from 'react-native-alert-notification';

const LoginScreen = () => {
    const [phone, setPhone] = useState('');
    const [password, setPassword] = useState('');
    const [isLoading, setIsLoading] = useState(false);
    const navigation = useNavigation();

    const handleLogin = async () => {
        // Validate phone and password
        if (!phone || !password) {
            ToastAndroid.showWithGravity('Form ada yang belum terisi', ToastAndroid.LONG, ToastAndroid.BOTTOM);
            return;
        }

        setIsLoading(true);

        try {
            const userData = {
                phone,
                password,
                type: 'penjamu',
            };

            // Attempt login
            const response = await axios.post('https://jaka-itfair.vercel.app/api/v1/auth/login', userData);
            const responseData = response.data.data;

            // Check for missing user data or token in response
            if (!responseData || !responseData.user || !responseData.token) {
                throw new Error('Missing user data or token in response');
            }

            // Extract user data and token
            const { user, token } = responseData;
            const { id, email, name, nim } = user;

            // Store user data in AsyncStorage
            await AsyncStorage.multiSet([
                ['userToken', JSON.stringify(token)],
                ['userId', id.toString()],
                ['userEmail', email.toString()],
                ['userName', name.toString()],
                ['userNIM', nim.toString()],
                ['userPhone', phone.toString()],
            ]);

            console.log('Data stored successfully.');

            // Navigate to AppStack
            navigation.reset({
                index: 0,
                routes: [{ name: 'AppStack' }],
            });
        } catch (error) {
            console.error('Login failed:', error);
            ToastAndroid.showWithGravity('Nomor whatsapp atau password salah. Mohon coba lagi.', ToastAndroid.LONG, ToastAndroid.BOTTOM);
        } finally {
            setIsLoading(false);
        }
    };

    return (
        <AlertNotificationRoot>
            <View style={styles.container}>
                <View style={styles.imageBehind}>
                    <Image style={styles.image} source={require('../assets/images/Background.png')} />
                </View>
                <View style={styles.contentContainer}>
                    <View style={styles.backgroundImageContainer}>
                        <View style={styles.textContainer}>
                            <Text style={styles.signUpText}>Masuk<Text style={styles.headerText}> dengan Nomor WhatsApp</Text></Text>
                        </View>
                    </View>
                    <View style={styles.signUpContainer}>
                        <TextInput
                            inputMode="numeric"
                            value={phone}
                            style={styles.input}
                            inputStyle={styles.inputStyle}
                            placeholderStyle={styles.placeholderStyle}
                            textErrorStyle={styles.textErrorStyle}
                            placeholder="Nomor WhatsApp"
                            placeholderTextColor={Colors.GREY}
                            onChangeText={text => {
                                setPhone(text);
                            }}
                        />
                        <TextInput
                            mode="password"
                            value={password}
                            style={styles.input}
                            inputStyle={styles.inputStyle}
                            placeholderStyle={styles.placeholderStyle}
                            textErrorStyle={styles.textErrorStyle}
                            placeholder="Kata Sandi"
                            placeholderTextColor={Colors.GREY}
                            onChangeText={text => {
                                setPassword(text);
                            }}
                        />
                        <View style={styles.signUpButtonContainer}>
                            <TouchableOpacity style={styles.signUpButton} onPress={handleLogin}>
                                {isLoading ? (
                                    <ActivityIndicator size="large" color={Colors.WHITE} />
                                ) : (
                                    <Text style={styles.signUpButtonText}>Masuk</Text>
                                )}
                            </TouchableOpacity>
                        </View>
                    </View>
                </View>
                <View style={styles.loginButtonContainer}>
                    <TouchableOpacity style={styles.loginButton} onPress={() => navigation.navigate('Register')}>
                        <Text style={styles.loginDefaultText}>Belum punya akun? <Text style={styles.loginBoldText}>Daftar</Text></Text>
                    </TouchableOpacity>
                </View>
            </View>
        </AlertNotificationRoot>

    )
}

const windowWidth = Dimensions.get('window').width;
const windowHeight = Dimensions.get('window').height;
const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
    },
    imageBehind: {
        backgroundColor: Colors.PRIMARY,
        height: windowHeight * 0.3,
    },
    image: {
        width: windowWidth,
        height: windowHeight * 0.15,
        top: windowHeight * 0.15,
    },
    contentContainer: {
        backgroundColor: Colors.WHITE,
        width: windowWidth - 30,
        height: 'auto',
        elevation: 5,
        top: -windowHeight * 0.05,
        borderRadius: 15,
    },
    backgroundImageContainer: {
        borderTopLeftRadius: 15,
        borderTopRightRadius: 15,
        overflow: 'hidden',
    },
    signUpContainer: {
        padding: 20,
    },
    textContainer: {
        flexDirection: 'row',
        width: '100%',
        paddingHorizontal: windowWidth * 0.05,
        paddingTop: windowHeight * 0.02,
    },
    signUpText: {
        fontFamily: Fonts.black,
        fontSize: windowWidth * 0.09,
        color: Colors.BLACK,
    },
    headerText: {
        fontFamily: Fonts.regular,
    },
    input: {
        height: windowHeight * 0.06,
        paddingHorizontal: 10,
        borderRadius: 10,
        backgroundColor: Colors.WHITE,
        shadowColor: Colors.BLACK,
        shadowOffset: {
            width: 0,
            height: 1,
        },
        shadowOpacity: 0.2,
        shadowRadius: 1.41,
        elevation: 2,
        marginVertical: windowHeight * 0.01,
        width: '100%',
    },
    inputStyle: {
        fontFamily: Fonts.regular,
        fontSize: windowWidth * 0.04,
    },
    placeholderStyle: {
        fontFamily: Fonts.regular,
        fontSize: windowWidth * 0.04,
    },
    textErrorStyle: {
        fontFamily: Fonts.regular,
        fontSize: windowWidth * 0.04,
    },
    signUpButtonContainer: {
        alignItems: 'center',
        marginTop: windowHeight * 0.015,
    },
    signUpButton: {
        width: windowWidth - 70,
        height: windowHeight * 0.06,
        borderRadius: 10,
        backgroundColor: Colors.PRIMARY,
        alignItems: 'center',
        justifyContent: 'center',
        elevation: 2,
    },
    signUpButtonText: {
        fontFamily: Fonts.bold,
        color: Colors.WHITE,
        fontSize: windowWidth * 0.05,
    },
    loginButtonContainer: {
        alignItems: 'center',
    },
    loginDefaultText: {
        fontFamily: Fonts.regular,
        color: Colors.BLACK,
    },
    loginBoldText: {
        fontFamily: Fonts.bold,
    }
});

export default LoginScreen;

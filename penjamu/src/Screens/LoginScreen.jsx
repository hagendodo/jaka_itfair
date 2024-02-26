import React, { useState } from 'react';
import { View, Text, StyleSheet, Dimensions, TouchableOpacity, Image, Alert, ActivityIndicator } from 'react-native';
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

    const handleLogin = () => {
        if (!phone || !password) {
            Dialog.show({
                type: ALERT_TYPE.DANGER,
                title: 'Form ada yang belum terisi',
                textBody: 'Isi formnya dengan benar yuk!',
                button: 'Tutup',
            });
            return;
        }

        setIsLoading(true);

        const userData = {
            phone: phone,
            password: password,
            type: 'penjamu',
        };

        axios.post('https://jaka-itfair.vercel.app/api/v1/auth/login', userData)
            .then(async (response) => {
                console.log('Login successful:', response.data);

                const userData = response.data.data; // Assuming the user data object contains the token
                const id = userData.user.id;
                const email = userData.user.email;
                const name = userData.user.name;
                const nim = userData.user.nim;
                const token = userData.token;

                if (id && token) {
                    await AsyncStorage.setItem('userToken', JSON.stringify(token));
                    await AsyncStorage.setItem('userId', id.toString());
                    await AsyncStorage.setItem('userEmail', email.toString());
                    await AsyncStorage.setItem('userName', name.toString());
                    await AsyncStorage.setItem('userNIM', nim.toString());
                    await AsyncStorage.setItem('userPhone', phone.toString());
                    console.log('Data stored successfully.');
                    navigation.navigate('AppStack');
                } else {
                    console.error('User ID or token is missing in the response data.');
                }
            })
            .catch(error => {
                console.error('Login failed:', error);
                Dialog.show({
                    type: ALERT_TYPE.WARNING,
                    title: 'Login Gagal',
                    textBody: ' Nomor whatsapp atau password salah. Mohon coba lagi.',
                    button: 'Coba Lagi',
                });
            })
            .finally(() => {
                setIsLoading(false);
            });
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

const styles = StyleSheet.create({
    container: {
        alignItems: 'center',
    },
    imageBehind: {
        backgroundColor: Colors.PRIMARY,
        height: Dimensions.get('window').height - 650,
    },
    image: {
        width: Dimensions.get('window').width,
        height: Dimensions.get('window').height - 750,
        top: 100,
    },
    contentContainer: {
        backgroundColor: Colors.WHITE,
        width: Dimensions.get('window').width - 30,
        height: 'auto',
        elevation: 5,
        top: -50,
        borderRadius: 15,
    },
    backgroundImageContainer: {
        borderTopLeftRadius: 15,
        borderTopRightRadius: 15,
    },
    signUpContainer: {
        padding: 20,
    },
    textContainer: {
        display: 'flex',
        flexDirection: 'row',
        width: '90%',
        paddingHorizontal: 25,
        paddingTop: 20,
    },
    signUpText: {
        fontFamily: Fonts.black,
        fontSize: 35,
        color: Colors.BLACK,
    },
    headerText: {
        fontFamily: Fonts.regular
    },
    input: {
        height: 50,
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
        marginVertical: 5,
    },
    inputStyle: { fontFamily: Fonts.regular, fontSize: 15 },
    placeholderStyle: { fontFamily: Fonts.regular, fontSize: 15 },
    textErrorStyle: { fontFamily: Fonts.regular, fontSize: 15 },
    signUpButtonContainer: {
        alignItems: 'center',
        marginTop: 15,
    },
    signUpButton: {
        width: Dimensions.get('window').width - 70,
        height: 50,
        borderRadius: 10,
        backgroundColor: Colors.PRIMARY,
        alignItems: 'center',
        justifyContent: 'center',
        elevation: 2,
    },
    signUpButtonText: {
        fontFamily: Fonts.bold,
        color: Colors.WHITE,
        fontSize: 18,
    },
    loginButtonContainer: {
        alignItems: 'center',
        justifyContent: 'flex-end',
        height: Dimensions.get('window').height - 630,
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

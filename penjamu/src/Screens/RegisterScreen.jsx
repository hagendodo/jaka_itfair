import { View, Text, StyleSheet, Dimensions, ImageBackground, Image, TouchableOpacity, KeyboardAvoidingView, ScrollView, ActivityIndicator, ToastAndroid } from 'react-native'
import React, { useState } from 'react';
import Colors from '../Constants/Colors';
import Fonts from '../Constants/Fonts';
import { useNavigation } from '@react-navigation/native';
import { TextInput } from 'react-native-element-textinput';
import axios from 'axios';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { ALERT_TYPE, Dialog, AlertNotificationRoot, Toast } from 'react-native-alert-notification';

const RegisterScreen = () => {
    const [name, setName] = useState('');
    const [nim, setNim] = useState('');
    const [email, setEmail] = useState('');
    const [phone, setPhone] = useState('');
    const [password, setPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [isLoading, setIsLoading] = useState(false);
    const navigation = useNavigation();

    const handleRegister = () => {
        // Regular expressions for validation
        const phoneRegex = /^\d{10,12}$/; // 10 to 12 digits for phone number
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // Email format validation
        const passwordRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,20}$/; // Password format validation

        if (!name || !nim || !email || !phone || !password || !confirmPassword) {
            ToastAndroid.showWithGravity('Form ada yang belum terisi', ToastAndroid.LONG, ToastAndroid.BOTTOM);
            return;
        }

        if (!phone.match(phoneRegex)) {
            ToastAndroid.showWithGravity('Format Nomor Whatsapp tidak valid', ToastAndroid.LONG, ToastAndroid.BOTTOM);
            return;
        }

        if (!email.match(emailRegex)) {
            ToastAndroid.showWithGravity('Format Alamat Email tidak valid', ToastAndroid.LONG, ToastAndroid.BOTTOM);
            return;
        }

        if (!password.match(passwordRegex)) {
            ToastAndroid.showWithGravity('Format Kata Sandi tidak valid', ToastAndroid.LONG, ToastAndroid.BOTTOM);
            return;
        }

        if (password !== confirmPassword) {
            ToastAndroid.showWithGravity('Konfirmasi Kata Sandi tidak cocok', ToastAndroid.LONG, ToastAndroid.BOTTOM);
            return;
        }

        setIsLoading(true);

        const userData = {
            name: name,
            nim: nim,
            email: email,
            phone: phone,
            password: password,
            type: 'penjamu',
        };

        AsyncStorage.setItem('userDataNIM', JSON.stringify(userData.nim))
            .then(() => {
                axios.post('https://jaka-itfair.vercel.app/api/v1/auth/register', userData)
                    .then(response => {
                        console.log('User Data:', userData);
                        console.log('Registration successful:', response.data);
                        console.log(nim);
                        navigation.navigate('OTP');
                    })
                    .catch(error => {
                        console.error('User Data:', userData);
                        console.error('Registration failed:', error);
                        ToastAndroid.showWithGravity('Pendaftaran Gagal', ToastAndroid.LONG, ToastAndroid.BOTTOM);
                    })
                    .finally(() => {
                        setIsLoading(false);
                    });
            })
            .catch(error => {
                console.error('Error storing user data:', error);
                setIsLoading(false);
            });
    };

    return (
        <AlertNotificationRoot>
            <KeyboardAvoidingView
                style={{ flex: 1 }}
            >
                <ScrollView contentContainerStyle={styles.container}>
                    <View style={styles.contentContainer}>
                        <View style={styles.backgroundImageContainer}>
                            <View style={styles.textContainer}>
                                <Text style={styles.signUpText}>Daftar<Text style={styles.headerText}> dengan email dan Nomor Whatsapp</Text></Text>
                            </View>
                            <Image style={styles.imageBackground} source={require('../assets/images/Background.png')} />
                        </View>
                        <View style={styles.signUpContainer}>
                            <View>
                                <TextInput
                                    inputMode="text"
                                    value={name}
                                    style={styles.input}
                                    inputStyle={styles.inputStyle}
                                    placeholderStyle={styles.placeholderStyle}
                                    textErrorStyle={styles.textErrorStyle}
                                    placeholder="Nama Lengkap"
                                    placeholderTextColor={Colors.GREY}
                                    onChangeText={text => {
                                        setName(text);
                                    }}
                                />
                                <TextInput
                                    inputMode="numeric"
                                    value={nim}
                                    style={styles.input}
                                    inputStyle={styles.inputStyle}
                                    placeholderStyle={styles.placeholderStyle}
                                    textErrorStyle={styles.textErrorStyle}
                                    placeholder="NIM"
                                    placeholderTextColor={Colors.GREY}
                                    onChangeText={text => {
                                        setNim(text);
                                    }}
                                />
                                <TextInput
                                    inputMode="email"
                                    value={email}
                                    style={styles.input}
                                    inputStyle={styles.inputStyle}
                                    placeholderStyle={styles.placeholderStyle}
                                    textErrorStyle={styles.textErrorStyle}
                                    placeholder="Alamat Email"
                                    placeholderTextColor={Colors.GREY}
                                    onChangeText={text => {
                                        setEmail(text);
                                    }}
                                />
                                <TextInput
                                    inputMode="numeric"
                                    value={phone}
                                    style={styles.input}
                                    inputStyle={styles.inputStyle}
                                    placeholderStyle={styles.placeholderStyle}
                                    textErrorStyle={styles.textErrorStyle}
                                    placeholder="Nomor Whatsapp"
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
                                <TextInput
                                    mode="password"
                                    value={confirmPassword}
                                    style={styles.input}
                                    inputStyle={styles.inputStyle}
                                    placeholderStyle={styles.placeholderStyle}
                                    textErrorStyle={styles.textErrorStyle}
                                    placeholder="Konfirmasi Kata Sandi"
                                    placeholderTextColor={Colors.GREY}
                                    onChangeText={text => {
                                        setConfirmPassword(text);
                                    }}
                                />
                            </View>
                            <View style={styles.signUpButtonContainer}>
                                <TouchableOpacity style={styles.signUpButton} onPress={handleRegister} disabled={isLoading}>
                                    {isLoading ? (
                                        <ActivityIndicator size="large" color={Colors.WHITE} />
                                    ) : (
                                        <Text style={styles.signUpButtonText}>Daftar</Text>
                                    )}
                                </TouchableOpacity>
                            </View>
                        </View>
                    </View>
                    <TouchableOpacity style={styles.loginButton} onPress={() => navigation.navigate('Login')}>
                        <Text style={styles.loginDefaultText}>Sudah punya akun? <Text style={styles.loginBoldText}>Masuk</Text></Text>
                    </TouchableOpacity>
                </ScrollView>
            </KeyboardAvoidingView>
        </AlertNotificationRoot>
    );
};

const windowWidth = Dimensions.get('window').width;
const windowHeight = Dimensions.get('window').height;

const styles = StyleSheet.create({
    container: {
        padding: 0.01 * windowHeight,
        alignItems: 'center',
    },
    contentContainer: {
        backgroundColor: Colors.WHITE,
        width: windowWidth - 30,
        height: 'auto',
        elevation: 5,
        borderRadius: 15,
    },
    backgroundImageContainer: {
        height: 0.35 * windowHeight,
        backgroundColor: Colors.PRIMARY,
        borderTopLeftRadius: 15,
        borderTopRightRadius: 15,
        overflow: 'hidden',
    },
    signUpContainer: {
        backgroundColor: Colors.WHITE,
        padding: 0.02 * windowHeight,
        borderBottomLeftRadius: 15,
        borderBottomRightRadius: 15,
    },
    imageBackground: {
        width: windowWidth,
        height: windowHeight * 0.15,
        top: windowHeight * 0.04,
    },
    textContainer: {
        display: 'flex',
        flexDirection: 'row',
        width: '90%',
        padding: 0.033 * windowHeight,
    },
    signUpText: {
        fontFamily: Fonts.black,
        fontSize: 0.04 * windowHeight,
        color: Colors.WHITE,
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
        fontSize: 0.02 * windowHeight,
    },
    loginDefaultText: {
        fontFamily: Fonts.regular,
        color: Colors.BLACK,
    },
    loginBoldText: {
        fontFamily: Fonts.bold,
    },
    loginButton: {
        marginVertical: 0.05 * windowHeight,
    },
});

export default RegisterScreen
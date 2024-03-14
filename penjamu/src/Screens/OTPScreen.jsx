import React, { useEffect, useState } from 'react';
import { View, Text, SafeAreaView, StyleSheet, TouchableOpacity } from 'react-native';
import { OtpInput } from 'react-native-otp-entry';
import axios from 'axios';
import MaterialCommunityIcons from 'react-native-vector-icons/MaterialCommunityIcons';
import Colors from '../Constants/Colors';
import AsyncStorage from '@react-native-async-storage/async-storage';
import Header from '../Components/Header';
import Fonts from '../Constants/Fonts';

const OTPScreen = ({ navigation, route }) => {
    const [code, setCode] = useState('');
    const [NIM, setNIM] = useState('');

    useEffect(() => {
        const fetchNIM = async () => {
            try {
                const storedNIM = await AsyncStorage.getItem('userDataNIM');
                if (storedNIM !== null) {
                    const parsedNIM = JSON.parse(storedNIM);
                    setNIM(parsedNIM);
                }
            } catch (error) {
                console.error('Error fetching NIM:', error);
            }
        };

        fetchNIM();
    }, []);

    const handleOTP = async () => {
        const userOTP = {
            nim: NIM,
            otp: code,
            type: 'penjamu',
        };

        try {
            console.log('==ON OTPSCREEN==');
            console.log('Print NIM: ', NIM);
            const response = await axios.post('https://jaka-itfair.vercel.app/api/v1/auth/verify-otp', userOTP);
            console.log('Print User OTP:', userOTP);
            console.log('Verification successful:', response.data);
            navigation.navigate('VerfikasiKTM');
        } catch (error) {
            console.error('User OTP:', userOTP);
            console.error('Verification failed:', error);
        }
    };

    return (
        <SafeAreaView style={{ backgroundColor: Colors.WHITE, flex: 1 }}>
            <Header goBack={true} name="Verifikasi OTP" />
            <View style={styles.contentContainer}>
                <Text style={styles.title}>Masukkan Kode Verifikasi OTP</Text>
                <OtpInput
                    numberOfDigits={6}
                    focusColor={Colors.PRIMARY}
                    hideStick
                    onFilled={(code) => setCode(code)}
                    theme={{
                        pinCodeTextStyle: styles.pinCodeTextStyle,
                        focusedPinCodeContainerStyle: styles.focusPinCodeContainerStyle
                    }}
                />
                <Text style={styles.infoText}>Kode verifikasi sudah dikirim ke Whatsapp. Ayo cek sekarang.</Text>
                <TouchableOpacity onPress={handleOTP} style={styles.verifyButton}>
                    <Text style={styles.verifyButtonText}>Verify</Text>
                </TouchableOpacity>
            </View>
        </SafeAreaView>
    );
};

const styles = StyleSheet.create({
    headerContainer: {
        paddingHorizontal: 20,
        marginTop: 50,
        flexDirection: 'row',
        alignItems: 'center',
    },
    headerText: {
        marginLeft: 90,
        fontFamily: Fonts.semibold,
        fontSize: 20,
    },
    contentContainer: {
        paddingHorizontal: 25,
        marginVertical: 20
    },
    title: {
        fontFamily: Fonts.bold,
        fontSize: 40,
        marginTop: 40,
        marginBottom: 10,
    },
    pinCodeTextStyle: {
        fontFamily: Fonts.bold,
        fontSize: 25,
    },
    focusPinCodeContainerStyle: {
        borderWidth: 1
    },
    infoText: {
        fontFamily: 'poppins',
        fontSize: 15,
        maxWidth: 400,
        marginTop: 10
    },
    verifyButton: {
        backgroundColor: Colors.PRIMARY,
        width: '100%',
        height: 45,
        borderRadius: 10,
        alignItems: 'center',
        justifyContent: 'center',
        marginTop: 20
    },
    verifyButtonText: {
        color: Colors.WHITE,
        fontFamily: Fonts.bold,
        fontSize: 16,
    }
});

export default OTPScreen;

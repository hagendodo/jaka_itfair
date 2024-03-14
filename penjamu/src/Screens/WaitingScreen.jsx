import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import LottieView from 'lottie-react-native';
import axios from 'axios';
import Colors from '../Constants/Colors';
import { useNavigation } from '@react-navigation/native';
import AsyncStorage from '@react-native-async-storage/async-storage';

const WaitingScreen = () => {
    const [refreshCounter, setRefreshCounter] = useState(0);
    const navigation = useNavigation();
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

    useEffect(() => {
        const interval = setInterval(() => {
            setRefreshCounter(prevCounter => prevCounter + 1);
        }, 60000); // Refresh every 1 minute (60 seconds)

        return () => clearInterval(interval); // Cleanup interval on component unmount
    }, []);

    useEffect(() => {
        const checkVerification = async () => {
            try {
                console.log('==ON WAITING SCREEN==');
                console.log('Print NIM: ', NIM);
                const response = await axios.post('https://jaka-itfair.vercel.app/api/v1/auth/check-verify', { nim: NIM });
                console.log('Verification status:', response.data);
                if (response.data.data.is_verified !== null) {
                    navigation.navigate('Login');
                }
            } catch (error) {
                console.error('Error checking verification status:', error);
            }
        };

        // Call checkVerification initially
        checkVerification();

        // Refresh verification status every minute
        const refreshInterval = setInterval(() => {
            checkVerification();
        }, 60000); // Refresh every 1 minute (60 seconds)

        // Cleanup function
        return () => clearInterval(refreshInterval);
    }, [navigation, NIM]);


    return (
        <View style={styles.container}>
            <LottieView
                source={require('../assets/lottie/Waiting.json')}
                style={{ width: '80%', height: '80%' }}
                autoPlay
                loop
            />
            <View style={styles.textContainer}>
                <Text style={styles.waitingText}>Menunggu Verifikasi</Text>
                <Text style={styles.waitingDetailText}>Sebelum Anda bisa memakai layanan Jaka Driver, kami perlu memverifikasi Anda terlebih dahulu. Ini akan memakan waktu sekitar 1-3 hari.</Text>
            </View>
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: Colors.WHITE,
    },
    textContainer: {
        alignItems: 'center',
        marginTop: 20,
    },
    waitingText: {
        fontSize: 20,
        fontWeight: 'bold',
        color: Colors.BLACK,
    },
    waitingDetailText: {
        marginTop: 10,
        textAlign: 'center',
        color: Colors.GREY,
    },
});

export default WaitingScreen;

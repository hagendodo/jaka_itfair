import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, Image, ActivityIndicator, Platform, PermissionsAndroid, Dimensions } from 'react-native';
import Colors from '../Constants/Colors';
import Fonts from '../Constants/Fonts';
import Header from '../Components/Header';
import FontAwesome from 'react-native-vector-icons/FontAwesome';
import { launchCamera } from 'react-native-image-picker';
import ImageResizer from 'react-native-image-resizer';
import axios from 'axios';
import { useNavigation } from '@react-navigation/native';
import AsyncStorage from '@react-native-async-storage/async-storage';

const VerifikasiKTM = () => {
    const [isProcessing, setIsProcessing] = useState(false);
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

    const openCamera = async () => {
        try {
            if (Platform.OS === 'android') {
                const granted = await PermissionsAndroid.request(
                    PermissionsAndroid.PERMISSIONS.CAMERA,
                );
                if (granted === PermissionsAndroid.RESULTS.GRANTED) {
                    launchCameraAndSave();
                } else {
                    console.log('Camera permission denied');
                }
            } else {
                launchCameraAndSave();
            }
        } catch (error) {
            console.error('Error requesting camera permission:', error);
        }
    };

    const launchCameraAndSave = async () => {
        setIsProcessing(true);
        launchCamera({ mediaType: 'photo', saveToPhotos: true }, async (response) => {
            setIsProcessing(false);
            if (response.didCancel) {
                console.log('User cancelled image picker');
            } else if (response.error) {
                console.log('ImagePicker Error: ', response.error);
            } else {
                console.log('Image response:', response.assets[0].uri);
                uploadImage(response.assets[0].uri);
            }
        });
    };


    const uploadImage = async (imageUri) => {
        try {
            const compressedImageUri = await compressImage(imageUri);

            const formData = new FormData();
            const filename = compressedImageUri.split('/').pop();

            formData.append('ktm', {
                uri: compressedImageUri,
                type: 'image/jpeg',
                name: filename,
                nim: NIM,
            });

            const response = await axios.post('https://jaka-itfair.vercel.app/api/v1/auth/upload-ktm', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
            });

            console.log('Upload response:', response.data);
            navigation.navigate('WaitingScreen');
        } catch (error) {
            console.error('Error uploading image:', error);
        }
    };

    const compressImage = async (imageUri) => {
        try {
            const resizedImage = await ImageResizer.createResizedImage(
                imageUri,
                800, // max width
                600, // max height
                'JPEG', // format
                80, // quality (0 to 100)
                0, // rotation
            );

            return resizedImage.uri;
        } catch (error) {
            console.error('Error compressing image:', error);
            return imageUri; // Return original image URI in case of error
        }
    };

    return (
        <View style={styles.container}>
            <Header goBack={true} />
            <View style={styles.contentContainer}>
                <Image source={require('../assets/images/KTM.png')} style={styles.ktmImage} />
                <Text style={styles.verifikasiText}>Verifikasi Kartu Tanda Mahasiswa dulu yuk!</Text>
                <Text style={styles.verifikasiDetailText}>Bergabunglah dengan tim kami sebagai driver terverifikasi dengan Kartu Tanda Mahasiswa (KTM).</Text>
            </View>
            <View style={styles.signUpButtonContainer}>
                <TouchableOpacity style={styles.signUpButton} onPress={openCamera} disabled={isProcessing}>
                    {isProcessing ? (
                        <ActivityIndicator size="small" color={Colors.WHITE} />
                    ) : (
                        <FontAwesome name="camera" size={24} color={Colors.WHITE} />
                    )}
                </TouchableOpacity>
            </View>
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        backgroundColor: Colors.WHITE,
        height: '100%'
    },
    contentContainer: {
        alignItems: 'center',
    },
    verifikasiText: {
        textAlign: 'center',
        fontFamily: Fonts.bold,
        fontSize: 20,
        width: 310,
    },
    verifikasiDetailText: {
        textAlign: 'center',
        fontFamily: Fonts.regular,
        fontSize: 13,
        marginTop: 10,
        width: 310,
    },
    ktmImage: {
        width: 300,
        height: 300,
    },
    signUpButtonContainer: {
        alignItems: 'center',
        marginTop: 15,
    },
    signUpButton: {
        width: Dimensions.get('window').width - 300,
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
});

export default VerifikasiKTM;

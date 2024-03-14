import { View, Text, Image, StyleSheet, Dimensions } from 'react-native'
import React, { useEffect, useState } from 'react'
import Colors from '../Constants/Colors'
import Feather from 'react-native-vector-icons/Feather';
import Ionicons from 'react-native-vector-icons/Ionicons';
import Octicons from 'react-native-vector-icons/Octicons';
import Fonts from '../Constants/Fonts';
import AsyncStorage from '@react-native-async-storage/async-storage';

const ProfileStack = () => {
    const [name, setName] = useState('');
    console.log(name);

    useEffect(() => {
        const fetchUserName = async () => {
            try {
                const userName = await AsyncStorage.getItem('userName');
                setName(userName || '');
            } catch (error) {
                console.error('Error fetching user name:', error);
            }
        };

        fetchUserName();
    }, []);

    return (
        <View>
            <View style={styles.profile}>
                <Image source={require('../assets/images/user-profile.jpg')} style={styles.profilePicture} />
                <View style={styles.profileInfo}>
                    <View>
                        <Text style={styles.profileTextBlack}>{name}</Text>
                        <Text style={styles.ProfileTextGrey}>Basic Level</Text>
                    </View>
                    <View style={styles.profileInfoEarn}>
                        <Text style={styles.profileTextBlack}>Rp 250.000</Text>
                        <Text style={styles.ProfileTextGrey}>Earned</Text>
                    </View>
                </View>
            </View>
            <View style={styles.performanceInfoContainer}>
                <View style={styles.performanceInfo}>
                    <View style={styles.performance}>
                        <Feather name="clock" size={30} color={Colors.BROKENWHITE} />
                        <Text style={styles.performanceInfoTextBold}>10.2</Text>
                        <Text style={styles.performanceInfoTextRegular}>HOURS ONLINE</Text>
                    </View>
                    <View style={styles.performance}>
                        <Ionicons name="speedometer-outline" size={30} color={Colors.BROKENWHITE} />
                        <Text style={styles.performanceInfoTextBold}>30 KM</Text>
                        <Text style={styles.performanceInfoTextRegular}>TOTAL DISTANCE</Text>
                    </View>
                    <View style={styles.performance}>
                        <Octicons name="checklist" size={30} color={Colors.BROKENWHITE} />
                        <Text style={styles.performanceInfoTextBold}>20</Text>
                        <Text style={styles.performanceInfoTextRegular}>TOTAL JOBS</Text>
                    </View>
                </View>
            </View>
        </View>
    );
};

const styles = StyleSheet.create({
    profile: {
        padding: 15,
        display: 'flex',
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems: 'center',
    },
    profileInfo: {
        display: 'flex',
        flexDirection: 'row',
        paddingHorizontal: 15,
        justifyContent: 'space-between',
        width: Dimensions.get('screen').width - 80,
    },
    profileInfoEarn: {
        alignItems: 'flex-end',
    },
    profilePicture: {
        borderRadius: 50,
        width: 50,
        height: 50,
        marginLeft: 15,
    },
    profileTextBlack: {
        fontFamily: Fonts.semibold,
        color: Colors.BLACK,
        fontSize: 16,
    },
    ProfileTextGrey: {
        fontFamily: Fonts.regular,
        color: Colors.GREY,
        fontSize: 12,
    },
    performanceInfoContainer: {
        alignItems: 'center',
    },
    performanceInfo: {
        backgroundColor: Colors.PRIMARY,
        width: Dimensions.get('screen').width - 45,
        height: 150,
        borderRadius: 15,
        padding: 15,
        elevation: 5,
        display: 'flex',
        flexDirection: 'row',
        justifyContent: 'space-around',
        alignItems: 'center',
    },
    performance: {
        alignItems: 'center',
        display: 'flex',
        flexDirection: 'column',
        gap: 5,

    },
    performanceInfoTextBold: {
        fontFamily: Fonts.extrabold,
        fontSize: 18,
        color: Colors.WHITE,
    },
    performanceInfoTextRegular: {
        fontFamily: Fonts.semibold,
        fontSize: 11,
        color: Colors.BROKENWHITE,
    },
});

export default ProfileStack;

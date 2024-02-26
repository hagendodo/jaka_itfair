import { View, Text, StyleSheet, Image, Dimensions, TouchableOpacity } from 'react-native'
import React from 'react'
import MaterialIcons from 'react-native-vector-icons/MaterialIcons';
import Colors from '../Constants/Colors';
import Fonts from '../Constants/Fonts';
import { useNavigation } from '@react-navigation/native';

const CardHistory = () => {
    const navigation = useNavigation();
    return (
        <View style={styles.historyContainer}>
            <View style={styles.history}>
                <TouchableOpacity style={styles.historyTextContainer} onPress={() => navigation.navigate('History')}>
                    <Text style={styles.historyText}>History</Text>
                    <MaterialIcons name="arrow-forward-ios" size={12} color={Colors.WHITE} />
                </TouchableOpacity>
                {
                    Array.from({ length: 3 }, (_, i) => (
                        <TouchableOpacity key={i} style={styles.historyList} onPress={() => navigation.navigate('History')}>
                            <View style={styles.historyProfile}>
                                <Image source={require('../assets/images/user-profile.jpg')} style={styles.historyProfilePicture} />
                                <View style={styles.historyProfileInfo}>
                                    <View>
                                        <Text style={styles.profileTextBlack}>Michael</Text>
                                        <Text style={styles.ProfileTextGrey}>Cash</Text>
                                    </View>
                                    <View style={styles.profileInfoEarn}>
                                        <Text style={styles.profileTextBlack}>Rp 25.000</Text>
                                        <Text style={styles.ProfileTextGrey}>1 km</Text>
                                    </View>
                                </View>
                            </View>
                        </TouchableOpacity>
                    ))
                }
            </View>
        </View>
    );
};

const styles = StyleSheet.create({
    historyContainer: {
        alignItems: 'center',
        marginTop: 20,
    },
    historyTextContainer: {
        display: 'flex',
        flexDirection: 'row',
        alignItems: 'center',
        gap: 2,
    },
    historyText: {
        fontFamily: Fonts.semibold,
        color: Colors.WHITE,
        fontSize: 14,
    },
    history: {
        backgroundColor: Colors.PRIMARY,
        width: Dimensions.get('screen').width - 45,
        height: 'auto',
        borderRadius: 15,
        padding: 15,
        elevation: 5,
    },
    historyList: {
        marginTop: 10,
        backgroundColor: Colors.WHITE,
        borderRadius: 15,
        padding: 15,
    },
    historyProfile: {
        display: 'flex',
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems: 'center',
    },
    historyProfileInfo: {
        display: 'flex',
        flexDirection: 'row',
        paddingHorizontal: 10,
        justifyContent: 'space-between',
        width: Dimensions.get('window').width - 130,
    },
    historyProfilePicture: {
        borderRadius: 10,
        width: 40,
        height: 40,
        marginLeft: 10,
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
    profileInfoEarn: {
        alignItems: 'flex-end'
    }
});

export default CardHistory;

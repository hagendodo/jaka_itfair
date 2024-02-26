import { View, Text, Image, StyleSheet } from 'react-native'
import React from 'react'
import { OnboardFlow } from 'react-native-onboard';
import Colors from '../Constants/Colors';
import Fonts from '../Constants/Fonts';
import { useNavigation } from '@react-navigation/native';

const OnBoardingScreen = () => {
    const navigation = useNavigation();

    const handleDone = () => {
        navigation.navigate('Login');
    };

    return (
        <View style={styles.container}>
            <OnboardFlow
                pages={[
                    {
                        title: 'Earn Money',
                        subtitle: 'Discover various ways to earn money and boost your income.',
                        imageComponent: <Image style={styles.imageStyleEarn} source={require('../assets/images/Earn.png')} />,
                    },
                    {
                        title: 'Tracking Realtime',
                        subtitle: 'Track your activities and locations in real-time for better insights.',
                        imageComponent: <Image style={styles.imageStyleLocation} source={require('../assets/images/Location.png')} />,
                    },
                ]}
                type={'fullscreen'}
                primaryButtonStyle={styles.primaryButtonStyle}
                paginationSelectedColor={Colors.PRIMARY}
                titleStyle={styles.titleStyle}
                subtitleStyle={styles.subtitleStyle}
                primaryButtonTextStyle={styles.primaryButtonTextStyle}
                onDone={handleDone}
            />
        </View>
    )
}

const styles = StyleSheet.create({
    container: {
    },
    imageStyleEarn: {
        width: 400,
        height: 250,
        marginBottom: 30,
        marginTop: 80,
    },
    imageStyleLocation: {
        width: 300,
        height: 300,
        marginTop: 60,
    },
    primaryButtonStyle: {
        marginBottom: 50,
        paddingHorizontal: 20,
        borderRadius: 20,
        backgroundColor: Colors.PRIMARY,
    },
    primaryButtonTextStyle: {
        fontFamily: Fonts.bold,
        color: Colors.WHITE,
    },
    titleStyle: {
        fontFamily: Fonts.bold,
        color: Colors.BLACK,
    },
    subtitleStyle: {
        fontFamily: Fonts.semibold,
        color: Colors.GREY,
        fontSize: 15,
    },
});

export default OnBoardingScreen;

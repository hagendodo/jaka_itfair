import { View, StyleSheet, Dimensions, Text, Image, TouchableOpacity, Alert } from 'react-native';
import React, { useCallback, useMemo, useRef, useState } from 'react';
import BottomSheet from '@gorhom/bottom-sheet';
import Header from '../Components/Header';
import Fonts from '../Constants/Fonts';
import Colors from '../Constants/Colors';
import MaterialIcons from 'react-native-vector-icons/MaterialIcons';
import ShowMaps from '../Components/ShowMaps';
import { SwipeButton } from '@arelstone/react-native-swipe-button';

const DetailOrder = () => {
    const bottomSheetRef = useRef(null);

    const snapPoints = useMemo(() => ['25%', '70%'], []);

    const handleSheetChanges = useCallback((index) => {
        console.log('handleSheetChanges', index);
    }, []);

    const [swipeDone, setSwipeDone] = useState(false);

    return (
        <View style={styles.container}>
            <Header name="Detail Order" goBack={true} />
            <ShowMaps />
            <BottomSheet
                ref={bottomSheetRef}
                index={0}
                snapPoints={snapPoints}
                onChange={handleSheetChanges}
                animateOnMount={true}
            >
                <View style={styles.bottomSheetContainer}>
                    <View style={styles.profile}>
                        <Image source={require('../assets/images/user-profile.jpg')} style={styles.profilePicture} />
                        <View style={styles.profileInfo}>
                            <View>
                                <Text style={styles.profileTextBlack}>John Doe</Text>
                                <Text style={styles.ProfileTextGrey}>Order ID 12889120122</Text>
                            </View>
                            <TouchableOpacity>
                                <MaterialIcons name='message' size={30} color={Colors.PRIMARY} />
                            </TouchableOpacity>
                        </View>
                    </View>
                    <View style={styles.deliveryDetailContainer}>
                        <Text style={styles.headerText}>Delivery Details</Text>
                        <View style={styles.deliveryDetail}>
                            <Text style={styles.titleText}>Address</Text>
                            <Text style={styles.detailText}>Fakultas Sains dan Teknologi</Text>
                        </View>
                        <View style={styles.deliveryDetail}>
                            <Text style={[styles.titleText, { marginTop: 10, }]}>Notes</Text>
                            <Text style={styles.detailText}>Jangan lupa bang saya ada di bawah pohon tugu kujang</Text>
                        </View>
                    </View>
                    <View style={styles.orderDetailContainer}>
                        <Text style={styles.headerText}>Orders</Text>
                        {
                            Array.from({ length: 3 }, (_, i) => (
                                <View style={styles.detail} key={i}>
                                    <Text style={styles.detailText}>Mie Goreng</Text>
                                    <View style={styles.quantityOrder}>
                                        <Text style={styles.detailText}>2</Text>
                                        <Text style={styles.detailText}>x</Text>
                                        <Text style={styles.detailText}>10.000</Text>
                                    </View>
                                </View>
                            ))
                        }
                        <View style={styles.detail}>
                            <Text style={styles.detailText}>Total</Text>
                            <Text style={styles.detailText}>20.000</Text>
                        </View>
                    </View>
                    <View>
                        <SwipeButton
                            Icon={
                                swipeDone ? (
                                    <MaterialIcons name="check" size={25} color={Colors.WHITE} />
                                ) : (
                                    <MaterialIcons name="arrow-forward-ios" size={25} color={Colors.WHITE} />
                                )
                            }
                            onComplete={() => [setSwipeDone(true), Alert.alert('Complete')]}
                            title="Swipe to complete"
                            titleStyle={styles.swipeTitleStyle}
                            containerStyle={styles.swipeContainerStyle}
                            underlayStyle={styles.swipeUnderlayStyle}
                            height={60}
                            borderRadius={15}
                            circleBackgroundColor={Colors.PRIMARY}
                        />
                    </View>
                </View>
            </BottomSheet>
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
    },
    bottomSheetContainer: {
        display: 'flex',
        flexDirection: 'column',
    },
    profile: {
        display: 'flex',
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems: 'center',
        paddingVertical: 10,
    },
    deliveryDetailContainer: {
        paddingHorizontal: 10,
        marginHorizontal: 15,
        marginTop: 15,
    },
    deliveryDetail: {
        borderBottomWidth: 0.5,
        borderBottomColor: Colors.GREY,
    },
    orderDetailContainer: {
        paddingHorizontal: 10,
        marginHorizontal: 15,
        marginVertical: 20,
    },
    profileInfo: {
        display: 'flex',
        flexDirection: 'row',
        paddingHorizontal: 15,
        justifyContent: 'space-between',
        width: Dimensions.get('screen').width - 80,
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
    profileInfoEarn: {
        alignItems: 'flex-end',
    },
    detail: {
        display: 'flex',
        flexDirection: 'row',
        justifyContent: 'space-between',
        borderBottomWidth: 0.5,
        borderBottomColor: Colors.GREY,
    },
    quantityOrder: {
        display: 'flex',
        flexDirection: 'row',
        gap: 2,
    },
    headerText: {
        fontFamily: Fonts.bold,
        color: Colors.BLACK,
        fontSize: 18,
        marginBottom: 10,
    },
    titleText: {
        fontFamily: Fonts.semibold,
        color: Colors.GREY,
        fontSize: 16,
        marginBottom: 5,
    },
    detailText: {
        fontFamily: Fonts.regular,
        color: Colors.BLACK,
        marginVertical: 5,
    },
    swipeContainerStyle: {
        borderWidth: 0.5,
        backgroundColor: Colors.WHITE,
        borderColor: Colors.PRIMARY,
        elevation: 3,
    },
    swipeTitleStyle: {
        fontFamily: Fonts.semibold,
        fontSize: 16,
        color: Colors.PRIMARY,
    },
    swipeUnderlayStyle: {
        borderRadius: 15,
        backgroundColor: Colors.PRIMARY,
    },
});

export default DetailOrder;

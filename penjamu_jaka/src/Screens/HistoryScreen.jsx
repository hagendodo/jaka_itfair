import { View, Text, StyleSheet, TouchableOpacity, Dimensions, Image, SafeAreaView, ScrollView } from 'react-native';
import React from 'react';
import Colors from '../Constants/Colors';
import Fonts from '../Constants/Fonts';
import { AlertNotificationRoot } from 'react-native-alert-notification';
import AntDesign from 'react-native-vector-icons/AntDesign'
import Header from '../Components/Header';

const HistoryScreen = () => {
    return (
        <SafeAreaView style={styles.container}>
            <AlertNotificationRoot>
                <Header name="History" onlineSwitch={true} />
                <View style={styles.calendarContainer}>
                    <ScrollView
                        horizontal={true}
                        scrollEnabled={true}
                        showsHorizontalScrollIndicator={false}
                    >
                        {
                            Array.from({ length: 7 }, (_, i) => (
                                <TouchableOpacity
                                    key={i}
                                    style={styles.calendarButton}
                                >
                                    <Text style={styles.calendarDay}>Sat</Text>
                                    <Text style={styles.calendarDate}>{i}</Text>
                                </TouchableOpacity>
                            ))
                        }
                    </ScrollView>
                </View>
                <View style={styles.historyContainer}>
                    <ScrollView
                        showsVerticalScrollIndicator={false}
                    >
                        {
                            Array.from({ length: 20 }, (_, i) => (
                                <TouchableOpacity
                                    key={i}
                                    style={styles.historyDetailsContainer}
                                >
                                    <View style={styles.historyHeader}>
                                        <Text style={styles.historyHeaderText}>24 Jan, 22:17</Text>
                                        <Text style={styles.historyHeaderText}>Rp 90.000</Text>
                                    </View>
                                    <View style={styles.historyDetails}>
                                        <Image source={require('../assets/images/food_icons.png')} style={styles.historyIcons} />
                                        <View style={styles.historyInfo}>
                                            <Text style={styles.historyInfoTextStore}>Mie Gacoan, Bandung Cibiru</Text>
                                            <View style={styles.historyInfoStatusContainer}>
                                                <AntDesign name="checkcircle" size={12} color={Colors.GREEN} />
                                                <Text style={styles.historyInfoTextStatus}>Delivered</Text>
                                            </View>
                                            <Text style={styles.historyInfoTextOrder}>4 Mie Gacoan lv 2, 2 Mie Gacoan lv 1</Text>
                                        </View>
                                    </View>
                                </TouchableOpacity>
                            ))
                        }
                    </ScrollView>
                </View>
            </AlertNotificationRoot>
        </SafeAreaView>
    );
};

const styles = StyleSheet.create({
    container: {
        height: '100%',
        width: '100%',
    },
    calendarContainer: {
        height: 100,
        backgroundColor: Colors.WHITE,
        padding: 10,
        borderBottomWidth: 0.5,
        borderBottomColor: Colors.BLACK
    },
    calendarButton: {
        width: 60,
        borderRadius: 15,
        height: 80,
        backgroundColor: Colors.PRIMARY,
        marginHorizontal: 5,
        alignItems: 'center',
        justifyContent: 'center',
        display: 'flex',
        flexDirection: 'column',
        gap: 2,
        elevation: 1,
    },
    calendarDate: {
        fontFamily: Fonts.semibold,
        fontSize: 17,
        color: Colors.WHITE,
    },
    calendarDay: {
        fontFamily: Fonts.semibold,
        fontSize: 15,
        color: Colors.WHITE,
    },
    historyContainer: {
        alignItems: 'center',
        paddingTop: 10,
        backgroundColor: Colors.BROKENWHITE,
    },
    historyDetailsContainer: {
        height: 'auto',
        width: Dimensions.get('window').width - 30,
        backgroundColor: Colors.WHITE,
        marginVertical: 5,
        borderRadius: 10,
        elevation: 1,
        padding: 15,
    },
    historyIcons: {
        width: 70,
        height: 70,
    },
    historyInfo: {
        display: 'flex',
        flexDirection: 'column',
        gap: 5,
    },
    historyDetails: {
        display: 'flex',
        flexDirection: 'row',
        gap: 10,
        marginTop: 10,
    },
    historyHeader: {
        display: 'flex',
        flexDirection: 'row',
        justifyContent: 'space-between'
    },
    historyHeaderText: {
        fontFamily: Fonts.regular,
        fontSize: 14,
        color: Colors.BLACK
    },
    historyInfoTextStore: {
        fontFamily: Fonts.semibold,
        fontSize: 16,
        color: Colors.BLACK,
    },
    historyInfoTextStatus: {
        fontFamily: Fonts.semibold,
        fontSize: 14,
        color: Colors.BLACK,

    },
    historyInfoTextOrder: {
        fontFamily: Fonts.regular,
        fontSize: 12,
        color: Colors.GREYTEXT,
    },
    historyInfoStatusContainer: {
        display: 'flex',
        flexDirection: 'row',
        alignItems: 'center',
        gap: 5,
    },
});
export default HistoryScreen;

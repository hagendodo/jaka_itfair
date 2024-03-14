import React, { useState, useEffect, useRef, useCallback } from 'react';
import {
    SafeAreaView,
    TouchableOpacity,
    StyleSheet,
    Image,
    Text,
    View,
    Platform,
    Linking,
    PermissionsAndroid,
    Dimensions
} from 'react-native';
import MaterialIcons from 'react-native-vector-icons/MaterialIcons';
import FontAwesome5 from 'react-native-vector-icons/FontAwesome5';
import FontAwesome6 from 'react-native-vector-icons/FontAwesome6';
import Ionicons from 'react-native-vector-icons/Ionicons';
import Entypo from 'react-native-vector-icons/Entypo';
import BottomSheet from '@gorhom/bottom-sheet';
import Header from '../Components/Header';
import ProfileSettingsSheet from '../Components/Settings/ProfileSettingsSheet';
import DocumentBottomSheet from '../Components/Settings/DocumentBottomSheet';
import ContactUsBottomSheet from '../Components/Settings/ContactUsBottomSheet';
import TermsPrivacyBottomSheet from '../Components/Settings/TermsPrivacyBottomSheet';
import SwitchToggle from 'react-native-switch-toggle';
import { check, PERMISSIONS, request } from 'react-native-permissions';
import Colors from '../Constants/Colors';
import Fonts from '../Constants/Fonts';
import ToggleSwitch from 'toggle-switch-react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';

const Settings = () => {
    const [notificationEnabled, setNotificationEnabled] = useState(false);
    const [locationEnabled, setLocationEnabled] = useState(false);
    const [bottomSheets, setBottomSheets] = useState({
        documentManagement: false,
        profileSettings: false,
        contact: false,
        termsPrivacy: false,
    });
    const bottomSheetRef = useRef(null);
    const snapPoints = ['100%', '95%'];
    const [name, setName] = useState('');

    const updatePermissionsState = (notification, location) => {
        setNotificationEnabled(notification);
        setLocationEnabled(location);
    };

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

    const checkPermissions = useCallback(async () => {
        try {
            if (Platform.OS === 'android') {
                const notificationEnabled = await checkNotificationPermissionAndroid();
                const locationEnabled = await checkLocationPermissionAndroid();
                updatePermissionsState(notificationEnabled, locationEnabled);
            } else if (Platform.OS === 'ios') {
                const notificationEnabled = await checkNotificationPermissionIOS();
                const locationEnabled = await checkLocationPermissionIOS();
                updatePermissionsState(notificationEnabled, locationEnabled);
            }
        } catch (error) {
            console.error('Error checking permissions:', error);
        }
    }, []);

    useEffect(() => {
        checkPermissions();
    }, [checkPermissions]);


    const checkNotificationPermissionAndroid = async () => {
        try {
            const granted = await PermissionsAndroid.check(PERMISSIONS.ANDROID.POST_NOTIFICATIONS);
            return granted;
        } catch (error) {
            console.error('Error checking notification permission on Android:', error);
            return false;
        }
    };

    const checkNotificationPermissionIOS = async () => {
        try {
            const permission = await check(PERMISSIONS.IOS.NOTIFICATIONS);
            return permission === 'granted';
        } catch (error) {
            console.error('Error checking notification permission on iOS:', error);
            return false;
        }
    };

    const checkLocationPermissionAndroid = async () => {
        try {
            const granted = await PermissionsAndroid.check(PERMISSIONS.ANDROID.ACCESS_FINE_LOCATION);
            return granted;
        } catch (error) {
            console.error('Error checking location permission on Android:', error);
            return false;
        }
    };

    const checkLocationPermissionIOS = async () => {
        try {
            const permission = await check(PERMISSIONS.IOS.LOCATION_WHEN_IN_USE);
            return permission === 'granted';
        } catch (error) {
            console.error('Error checking location permission on iOS:', error);
            return false;
        }
    };

    const handleDenyPermission = async (permissionType) => {
        try {
            if (Platform.OS === 'android') {
                await Linking.openSettings();
            } else if (Platform.OS === 'ios') {
                // Handle iOS permission denial
            }
        } catch (error) {
            console.error('Error handling deny permission:', error);
        }
    };

    const handleNotificationToggle = async () => {
        try {
            if (notificationEnabled) {
                setNotificationEnabled(false);
                await handleDenyPermission('notification');
            } else {
                const permissionResult = await requestNotificationPermission();
                if (permissionResult === 'granted') {
                    setNotificationEnabled(true);
                }
            }
        } catch (error) {
            console.error('Error handling notification toggle:', error);
        }
    };

    const handleLocationToggle = async () => {
        try {
            if (locationEnabled) {
                setLocationEnabled(false);
                await handleDenyPermission('location');
            } else {
                const permissionResult = await requestLocationPermission();
                if (permissionResult === 'granted') {
                    setLocationEnabled(true);
                }
            }
        } catch (error) {
            console.error('Error handling location toggle:', error);
        }
    };

    const requestNotificationPermission = async () => {
        try {
            if (Platform.OS === 'android') {
                return PermissionsAndroid.request(PERMISSIONS.ANDROID.POST_NOTIFICATIONS);
            } else if (Platform.OS === 'ios') {
                return request(PERMISSIONS.IOS.NOTIFICATIONS);
            }
        } catch (error) {
            console.error('Error requesting notification permission:', error);
        }
    };

    const requestLocationPermission = async () => {
        try {
            if (Platform.OS === 'android') {
                return PermissionsAndroid.request(PERMISSIONS.ANDROID.ACCESS_FINE_LOCATION);
            } else if (Platform.OS === 'ios') {
                return request(PERMISSIONS.IOS.LOCATION_WHEN_IN_USE);
            }
        } catch (error) {
            console.error('Error requesting location permission:', error);
        }
    };

    const toggleBottomSheet = (sheetName) => {
        setBottomSheets(prevState => ({
            ...prevState,
            [sheetName]: !prevState[sheetName],
        }));
    };

    const closeBottomSheet = () => {
        bottomSheetRef.current?.close();
    };

    const handleSheetChanges = (index) => {
        console.log('handleSheetChanges', index);
    };

    const renderBottomSheetContent = (sheetName, closeBottomSheet) => {
        switch (sheetName) {
            case 'documentManagement':
                return (
                    <View style={styles.bottomSheetContainer}>
                        <DocumentBottomSheet onClose={closeBottomSheet} />
                    </View>
                );
            case 'profileSettings':
                return (
                    <View style={styles.bottomSheetContainer}>
                        <ProfileSettingsSheet onClose={closeBottomSheet} />
                    </View>
                );
            case 'contact':
                return (
                    <View style={styles.bottomSheetContainer}>
                        <ContactUsBottomSheet onClose={closeBottomSheet} />
                    </View>
                );
            case 'termsPrivacy':
                return (
                    <View style={styles.bottomSheetContainer}>
                        <TermsPrivacyBottomSheet onClose={closeBottomSheet} />
                    </View>
                );
            default:
                return null;
        }
    };

    return (
        <SafeAreaView style={styles.container}>
            <Header name="Settings" />
            <TouchableOpacity style={styles.profileContainer} onPress={() => toggleBottomSheet('profileSettings')}>
                <Image source={require('../assets/images/user-profile.jpg')} style={styles.profilePicture} />
                <View style={[styles.textContainer, { width: 320 }]}>
                    <Text style={styles.textStyle}>{name}</Text>
                    <MaterialIcons name="arrow-forward-ios" size={18} color={Colors.GREY} />
                </View>
            </TouchableOpacity>
            <TouchableOpacity style={styles.settingsContainer} onPress={() => toggleBottomSheet('documentManagement')}>
                <View style={[styles.iconContainer, { backgroundColor: Colors.GREENBRIGHT }]}>
                    <FontAwesome5 name="address-card" size={18} solid color={Colors.WHITE} />
                </View>
                <View style={[styles.textContainer, { width: 340 }]}>
                    <Text style={styles.settingsTextStyle}>Document Management</Text>
                    <MaterialIcons name="arrow-forward-ios" size={18} color={Colors.GREY} />
                </View>
            </TouchableOpacity>
            <View style={[styles.settingsContainer, { marginTop: 20 }]}>
                <View style={[styles.iconContainer, { backgroundColor: Colors.PRIMARY }]}>
                    <Ionicons name="notifications" size={18} solid color={Colors.WHITE} />
                </View>
                <View style={[styles.textContainer, { width: 340 }]}>
                    <Text style={styles.settingsTextStyle}>Notifications</Text>
                    <ToggleSwitch
                        isOn={notificationEnabled}
                        onColor={Colors.PRIMARY}
                        offColor={Colors.BLACK}
                        size="medium"
                        onToggle={handleNotificationToggle}
                    />
                </View>
            </View>
            <View style={styles.settingsContainer}>
                <View style={[styles.iconContainer, { backgroundColor: Colors.YELLOW }]}>
                    <Entypo name="location-pin" size={23} solid color={Colors.WHITE} />
                </View>
                <View style={[styles.textContainer, { width: 340 }]}>
                    <Text style={styles.settingsTextStyle}>Locations</Text>
                    <ToggleSwitch
                        isOn={locationEnabled}
                        onColor={Colors.PRIMARY}
                        offColor={Colors.BLACK}
                        size="medium"
                        onToggle={handleLocationToggle}
                    />
                </View>
            </View>
            <TouchableOpacity style={styles.settingsContainer} onPress={() => toggleBottomSheet('termsPrivacy')}>
                <View style={[styles.iconContainer, { backgroundColor: Colors.GREY }]}>
                    <FontAwesome6 name="crown" size={18} solid color={Colors.WHITE} />
                </View>
                <View style={[styles.textContainer, { width: 340 }]}>
                    <Text style={styles.settingsTextStyle}>Terms & Privacy</Text>
                    <MaterialIcons name="arrow-forward-ios" size={18} color={Colors.GREY} />
                </View>
            </TouchableOpacity>
            <TouchableOpacity style={styles.settingsContainer} onPress={() => toggleBottomSheet('contact')}>
                <View style={[styles.iconContainer, { backgroundColor: Colors.RED }]}>
                    <MaterialIcons name="question-answer" size={20} solid color={Colors.WHITE} />
                </View>
                <View style={[styles.textContainer, { width: 340 }]}>
                    <Text style={styles.settingsTextStyle}>Contact Us</Text>
                    <MaterialIcons name="arrow-forward-ios" size={18} color={Colors.GREY} />
                </View>
            </TouchableOpacity>
            {Object.entries(bottomSheets).map(([key, value]) => (
                value && (
                    <BottomSheet
                        key={key}
                        ref={bottomSheetRef}
                        index={0}
                        snapPoints={snapPoints}
                        onChange={handleSheetChanges}
                        animateOnMount={true}
                        enableOverDrag={true}
                        enablePanDownToClose={true}
                        onClose={() => toggleBottomSheet(key)}
                    >
                        {renderBottomSheetContent(key, closeBottomSheet)}
                    </BottomSheet>
                )
            ))}
        </SafeAreaView>
    );
};

const { width, height } = Dimensions.get('window');

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    profileContainer: {
        backgroundColor: 'white',
        paddingVertical: height * 0.01,
        paddingHorizontal: width * 0.05,
        flexDirection: 'row',
        alignItems: 'center',
        borderBottomWidth: 0.5,
        borderBottomColor: 'gray',
    },
    profilePicture: {
        borderRadius: width * 0.1,
        width: width * 0.2,
        height: width * 0.2,
    },
    textContainer: {
        flex: 1,
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        marginLeft: width * 0.05,
    },
    textStyle: {
        fontFamily: Fonts.semibold,
        color: 'black',
        fontSize: width * 0.05,
    },
    settingsContainer: {
        backgroundColor: 'white',
        paddingVertical: height * 0.012,
        paddingHorizontal: width * 0.05,
        flexDirection: 'row',
        alignItems: 'center',
        borderBottomWidth: 0.5,
        borderBottomColor: 'gray',
    },
    iconContainer: {
        width: width * 0.11,
        height: width * 0.11,
        justifyContent: 'center',
        alignItems: 'center',
        borderRadius: width * 0.04,
    },
    settingsTextStyle: {
        fontFamily: Fonts.semibold,
        color: 'black',
        fontSize: width * 0.035,
        flex: 1,
        marginLeft: width * 0.05,
    },
    bottomSheetContainer: {
        paddingHorizontal: width * 0.05,
        paddingBottom: height * 0.02,
    },
    switchContainerStyle: {
        width: width * 0.15,
        height: height * 0.05,
        borderRadius: width * 0.1,
        padding: width * 0.015,
    },
    switchCircleStyle: {
        width: width * 0.045,
        height: width * 0.045,
        borderRadius: width * 0.025,
    },
});
export default Settings;

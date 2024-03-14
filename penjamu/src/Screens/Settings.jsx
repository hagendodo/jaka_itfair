import { SafeAreaView, TouchableOpacity, StyleSheet, Image, Text, View, Platform, Linking } from 'react-native'
import React, { Component } from 'react';
import Colors from '../Constants/Colors';
import MaterialIcons from 'react-native-vector-icons/MaterialIcons';
import FontAwesome5 from 'react-native-vector-icons/FontAwesome5';
import FontAwesome6 from 'react-native-vector-icons/FontAwesome6';
import Ionicons from 'react-native-vector-icons/Ionicons';
import Entypo from 'react-native-vector-icons/Entypo';
import Fonts from '../Constants/Fonts';
import BottomSheet from '@gorhom/bottom-sheet';
import Header from '../Components/Header';
import ProfileSettingsSheet from '../Components/Settings/ProfileSettingsSheet';
import DocumentBottomSheet from '../Components/Settings/DocumentBottomSheet';
import ContactUsBottomSheet from '../Components/Settings/ContactUsBottomSheet';
import TermsPrivacyBottomSheet from '../Components/Settings/TermsPrivacyBottomSheet';
import { PermissionsAndroid } from 'react-native';
import { check, PERMISSIONS, request } from 'react-native-permissions';
import ToggleSwitch from 'toggle-switch-react-native';

export default class Settings extends Component {
    constructor(props) {
        super(props);
        this.state = {
            notificationEnabled: false,
            locationEnabled: false,
            bottomSheets: {
                documentManagement: false,
                profileSettings: false,
                contact: false,
                termsPrivacy: false,
            },
        };
        this.bottomSheetRef = React.createRef();
        this.snapPoints = ['100%', '95%'];
    }

    componentDidMount() {
        this.checkPermissions();
    }

    updatePermissionsState = (notificationEnabled, locationEnabled) => {
        this.setState({ notificationEnabled, locationEnabled });
    };

    checkPermissions = async () => {
        try {
            if (Platform.OS === 'android') {
                const notificationEnabled = await this.checkNotificationPermissionAndroid();
                const locationEnabled = await this.checkLocationPermissionAndroid();
                this.updatePermissionsState(notificationEnabled, locationEnabled);
            } else if (Platform.OS === 'ios') {
                const notificationEnabled = await this.checkNotificationPermissionIOS();
                const locationEnabled = await this.checkLocationPermissionIOS();
                this.updatePermissionsState(notificationEnabled, locationEnabled);
            }
        } catch (error) {
            console.error('Error checking permissions:', error);
        }
    };

    checkNotificationPermissionAndroid = async () => {
        try {
            const granted = await PermissionsAndroid.check(
                PermissionsAndroid.PERMISSIONS.POST_NOTIFICATIONS
            );
            return granted;
        } catch (error) {
            console.error('Error checking notification permission on Android:', error);
            return false;
        }
    };

    checkNotificationPermissionIOS = async () => {
        try {
            const notificationPermission = await check(PERMISSIONS.IOS.NOTIFICATIONS);
            return notificationPermission === 'granted';
        } catch (error) {
            console.error('Error checking notification permission on iOS:', error);
            return false;
        }
    };

    checkLocationPermissionAndroid = async () => {
        try {
            const granted = await PermissionsAndroid.check(
                PermissionsAndroid.PERMISSIONS.ACCESS_FINE_LOCATION
            );
            return granted;
        } catch (error) {
            console.error('Error checking location permission on Android:', error);
            return false;
        }
    };

    checkLocationPermissionIOS = async () => {
        try {
            const locationPermission = await check(PERMISSIONS.IOS.LOCATION_WHEN_IN_USE);
            return locationPermission === 'granted';
        } catch (error) {
            console.error('Error checking location permission on iOS:', error);
            return false;
        }
    };

    handleDenyPermission = async (permissionType) => {
        try {
            if (Platform.OS === 'android') {
                await Linking.openSettings();
            } else if (Platform.OS === 'ios') {
            }
        } catch (error) {
            console.error('Error handling deny permission:', error);
        }
    };

    handleNotificationToggle = async () => {
        try {
            const { notificationEnabled } = this.state;
            if (notificationEnabled) {
                this.setState({ notificationEnabled: false });
                await this.handleDenyPermission('notification');
            } else {
                const permissionResult = await this.requestNotificationPermission();
                if (permissionResult === 'granted') {
                    this.setState({ notificationEnabled: true });
                }
            }
        } catch (error) {
            console.error('Error handling notification toggle:', error);
        }
    };

    handleLocationToggle = async () => {
        try {
            const { locationEnabled } = this.state;
            if (locationEnabled) {
                this.setState({ locationEnabled: false });
                await this.handleDenyPermission('location');
            } else {
                const permissionResult = await this.requestLocationPermission();
                if (permissionResult === 'granted') {
                    this.setState({ locationEnabled: true });
                }
            }
        } catch (error) {
            console.error('Error handling location toggle:', error);
        }
    };

    requestNotificationPermission = async () => {
        try {
            if (Platform.OS === 'android') {
                return PermissionsAndroid.request(
                    PermissionsAndroid.PERMISSIONS.POST_NOTIFICATIONS,
                );
            } else if (Platform.OS === 'ios') {
                return request(PERMISSIONS.IOS.NOTIFICATIONS);
            }
        } catch (error) {
            console.error('Error requesting notification permission:', error);
        }
    };

    requestLocationPermission = async () => {
        try {
            if (Platform.OS === 'android') {
                return PermissionsAndroid.request(
                    PermissionsAndroid.PERMISSIONS.ACCESS_FINE_LOCATION,
                );
            } else if (Platform.OS === 'ios') {
                return request(PERMISSIONS.IOS.LOCATION_WHEN_IN_USE);
            }
        } catch (error) {
            console.error('Error requesting location permission:', error);
        }
    };

    toggleBottomSheet = (sheetName) => {
        this.setState(prevState => ({
            bottomSheets: {
                ...prevState.bottomSheets,
                [sheetName]: !prevState.bottomSheets[sheetName],
            }
        }));
    };

    closeBottomSheet = () => {
        this.bottomSheetRef.current?.close();
    };

    handleSheetChanges = (index) => {
        console.log('handleSheetChanges', index);
    };

    render() {
        const { notificationEnabled, locationEnabled, bottomSheets } = this.state;

        return (
            <SafeAreaView style={styles.container}>
                <Header name="Settings" />
                <TouchableOpacity style={styles.profileContainer} onPress={() => this.toggleBottomSheet('profileSettings')}>
                    <Image source={require('../assets/images/user-profile.jpg')} style={styles.profilePicture} />
                    <View style={[styles.textContainer, { width: 320 }]}>
                        <Text style={styles.textStyle}>Martha Banks</Text>
                        <MaterialIcons name="arrow-forward-ios" size={18} color={Colors.GREY} />
                    </View>
                </TouchableOpacity>
                <TouchableOpacity style={styles.settingsContainer} onPress={() => this.toggleBottomSheet('documentManagement')}>
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
                            onToggle={this.handleNotificationToggle}
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
                            onToggle={this.handleLocationToggle}
                        />
                    </View>
                </View>
                <TouchableOpacity style={styles.settingsContainer} onPress={() => this.toggleBottomSheet('termsPrivacy')}>
                    <View style={[styles.iconContainer, { backgroundColor: Colors.GREY }]}>
                        <FontAwesome6 name="crown" size={18} solid color={Colors.WHITE} />
                    </View>
                    <View style={[styles.textContainer, { width: 340 }]}>
                        <Text style={styles.settingsTextStyle}>Terms & Privacy</Text>
                        <MaterialIcons name="arrow-forward-ios" size={18} color={Colors.GREY} />
                    </View>
                </TouchableOpacity>
                <TouchableOpacity style={styles.settingsContainer} onPress={() => this.toggleBottomSheet('contact')}>
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
                            ref={this.bottomSheetRef}
                            index={0}
                            snapPoints={this.snapPoints}
                            onChange={this.handleSheetChanges}
                            animateOnMount={true}
                            enableOverDrag={true}
                            enablePanDownToClose={true}
                            onClose={() => this.toggleBottomSheet(key)}
                        >
                            {renderBottomSheetContent(key, this.closeBottomSheet)}
                        </BottomSheet>
                    )
                ))}
            </SafeAreaView>
        )
    }
}

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

const styles = StyleSheet.create({
    container: {
        width: '100%',
        height: '100%',
    },
    profileContainer: {
        marginVertical: 20,
        backgroundColor: Colors.WHITE,
        padding: 15,
        display: 'flex',
        flexDirection: 'row',
        alignItems: 'center',
        gap: 15,
    },
    profilePicture: {
        borderRadius: 50,
        width: 50,
        height: 50,
    },
    textContainer: {
        display: 'flex',
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
    },
    textStyle: {
        fontFamily: Fonts.semibold,
        color: Colors.BLACK,
        fontSize: 18,
    },
    settingsContainer: {
        backgroundColor: Colors.WHITE,
        paddingVertical: 10,
        paddingHorizontal: 15,
        display: 'flex',
        flexDirection: 'row',
        alignItems: 'center',
        gap: 10,
        borderBottomWidth: 0.5,
        borderBottomColor: Colors.GREY,
    },
    iconContainer: {
        width: 35,
        height: 35,
        justifyContent: 'center',
        alignItems: 'center',
        borderRadius: 10,
    },
    settingsTextStyle: {
        fontFamily: Fonts.semibold,
        color: Colors.BLACK,
        fontSize: 15,
    },
    bottomSheetContainer: {
    },
    switchContainerStyle: {
        width: 45,
        height: 25,
        borderRadius: 20,
        padding: 3,
    },
    switchCircleStyle: {
        width: 18,
        height: 18,
        borderRadius: 50,
    },
});

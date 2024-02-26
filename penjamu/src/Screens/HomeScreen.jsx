import { StyleSheet, SafeAreaView, ScrollView, RefreshControl } from 'react-native';
import React, { useEffect, useState } from 'react';
import Colors from '../Constants/Colors';
import { AlertNotificationRoot } from 'react-native-alert-notification';
import Card from '../Components/CardHistory';
import ProfileStack from '../Components/ProfileStack';
import Header from '../Components/Header';


const HomeScreen = () => {
    const [refreshing, setRefreshing] = React.useState(false);


    const onRefresh = React.useCallback(() => {
        setRefreshing(true);

        setTimeout(() => {
            setRefreshing(false);
        }, 2000);
    }, []);

    return (
        <ScrollView
            style={styles.container}
            refreshControl={
                <RefreshControl
                    refreshing={refreshing}
                    onRefresh={onRefresh}
                    colors={[Colors.PRIMARY]}
                    tintColor={Colors.PRIMARY}
                />
            }
        >
            <AlertNotificationRoot>
                <Header name="Home" onlineSwitch={true} />
                <ProfileStack />
                <Card />
            </AlertNotificationRoot>
        </ScrollView>
    );
};

const styles = StyleSheet.create({
    container: {
        backgroundColor: Colors.WHITE,
        height: '100%',
        width: '100%',
    },
});
export default HomeScreen;

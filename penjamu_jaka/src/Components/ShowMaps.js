import React, { Component } from 'react';
import { PermissionsAndroid, StyleSheet, View } from 'react-native';
import MapboxGL from '@rnmapbox/maps';

MapboxGL.setAccessToken('pk.eyJ1Ijoib2phbmFqYTAzIiwiYSI6ImNsczJmdnFmcDBpbWUya29lMXo3YjZhOW4ifQ.BNLM-X1rsyOLt_EA7xfrlw');

const styles = StyleSheet.create({
    map: {
        width: '100%',
        height: '95%',
    },
});

export default class ShowMaps extends Component {
    state = {
        userLocation: null,
        route: null,
    };

    async componentDidMount() {
        MapboxGL.setTelemetryEnabled(false);

        try {
            const granted = await PermissionsAndroid.request(
                PermissionsAndroid.PERMISSIONS.ACCESS_FINE_LOCATION
            );
            if (granted === PermissionsAndroid.RESULTS.GRANTED) {
                console.log('Location permission granted');
            } else {
                console.log('Location permission denied');
            }
        } catch (err) {
            console.warn(err);
        }
    }

    handleUserLocationUpdate = async (location) => {
        this.setState({ userLocation: location });

        console.log(location);

        const destination = [107.71827852260127, -6.931061755325668];
        const response = await fetch(`https://api.mapbox.com/directions/v5/mapbox/driving/${location.coords.longitude},${location.coords.latitude};${destination[0]},${destination[1]}?geometries=geojson&access_token=pk.eyJ1Ijoib2phbmFqYTAzIiwiYSI6ImNsczJmdnFmcDBpbWUya29lMXo3YjZhOW4ifQ.BNLM-X1rsyOLt_EA7xfrlw`);
        const data = await response.json();
        this.setState({ route: data.routes[0].geometry });
    };

    render() {
        const { userLocation, route } = this.state;

        return (
            <View>
                <MapboxGL.MapView style={styles.map} attributionEnabled={false}>
                    <MapboxGL.UserLocation
                        visible={true}
                        animated={true}
                        showsUserHeadingIndicator={true}
                        onUpdate={this.handleUserLocationUpdate}
                    />
                    {userLocation && (
                        <MapboxGL.Camera
                            minZoomLevel={15}
                            animationDuration={3000}
                            followUserLocation={true}
                            followUserMode="compass"
                            animationMode="easeTo"
                            centerCoordinate={userLocation.coords}
                        />
                    )}
                    <MapboxGL.PointAnnotation id="marker" coordinate={[107.71827852260127, -6.931061755325668]} />
                    {route && (
                        <MapboxGL.ShapeSource id="routeSource" shape={route}>
                            <MapboxGL.LineLayer id="routeLine" style={{ lineColor: '#00FF00', lineWidth: 4 }} />
                        </MapboxGL.ShapeSource>
                    )}
                </MapboxGL.MapView>
            </View>
        );
    }
}

import { View, Text, StyleSheet } from 'react-native'
import React from 'react'
import Fonts from '../../Constants/Fonts'
import Colors from '../../Constants/Colors'
import { TouchableOpacity } from '@gorhom/bottom-sheet'

const TermsPrivacyBottomSheet = ({ onClose }) => {
    return (
        <View>
            <TouchableOpacity style={styles.topButton} onPress={onClose}>
                <Text style={styles.topButtonText}>Done</Text>
            </TouchableOpacity>
        </View>
    )
}

const styles = StyleSheet.create({
    topButton: {
        alignItems: 'flex-end',
        paddingHorizontal: 15,
    },
    topButtonText: {
        fontSize: 16,
        fontFamily: Fonts.bold,
        color: Colors.PRIMARY,
    },
})
export default TermsPrivacyBottomSheet
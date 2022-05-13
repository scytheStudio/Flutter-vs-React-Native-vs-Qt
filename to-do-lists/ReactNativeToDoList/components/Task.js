import React from 'react';
import {View, Text, StyleSheet} from 'react-native';
import { TouchableOpacity } from 'react-native-web';

const Task = (props) => {

    return (
        <View style={styles.task}>
            <View style={styles.leftWrapper}>
                <View style={styles.indicator}></View>
                <Text styles={styles.text}>{props.text}</Text>
            </View>
            <View style={styles.circle}>
            </View>
        </View>
    )
}

const styles = StyleSheet.create({
    task: {
        backgroundColor: '#FFFFFF',
        padding: 15,
        borderRadius: 10,
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-between',
        marginBottom: 20,
    },
    leftWrapper: {
        flexDirection: 'row',
        alignItems: 'center',
        flexWrap: 'wrap',
    },
    indicator: {
        width: 24,
        height: 24,
        backgroundColor: '#218165',
        opacity: 0.4,
        borderRadius: 5,
        marginRight: 15,
    },
    text: {
        maxWidth: '80%',
    },
    circle: {
        width: 12,
        height: 12,
        borderColor: '#218165',
        borderWidth: 2,
        borderRadius: 5,
    },
});

export default Task;
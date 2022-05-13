import React from 'react';
import { StyleSheet, KeyboardAvoidingView, TextInput, TouchableOpacity, Platform, View, Text} from 'react-native';

const InputSection = (props) => {

    return (
        <KeyboardAvoidingView
            behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
            style={styles.inputSection}
        >
            <TextInput style={styles.inputField} placeholder={'Write a task'} value={props.text} onChangeText={props.onChangeText}/>
            <TouchableOpacity onPress={props.onAddClicked}>
                <View style={styles.addButton}>
                    <Text style={styles.addButtonText}>+</Text>
                </View>
            </TouchableOpacity>
        </KeyboardAvoidingView>
    )
}

const styles = StyleSheet.create({
    inputSection: {
        position: 'absolute',
        bottom: 30,
        width: '100%',
        flexDirection: 'row',
        justifyContent: 'space-around',
        alignItems: 'center'
    },
    inputField: {
        paddingVertical: 15,
        paddingHorizontal: 15,
        backgroundColor: '#FFFFFF',
        borderRadius: 60,
        borderColor: '#C0C0C0',
        borderWidth: 1,
        width: 250,
    },
    addButton: {
        width: 60,
        height: 60,
        backgroundColor: '#FFFFFF',
        justifyContent: 'center',
        alignItems: 'center',
        borderRadius: 60,
        borderColor: '#C0C0C0',
        borderWidth: 1,
    },
    addButtonText: {},
});

export default InputSection;
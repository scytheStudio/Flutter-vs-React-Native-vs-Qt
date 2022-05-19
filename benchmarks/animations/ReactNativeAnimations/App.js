import React from 'react';
import { StyleSheet, Image, View, FlatList, Dimensions } from 'react-native';
import * as Animatable from 'react-native-animatable';

const elements = Array(200).fill('a');
const numColumns = 10;
const tileSize = Dimensions.get('window').width / numColumns;

export default class App extends React.Component {
  renderItem = ({ item, index }) => {
    if (item.empty === true) {
      return <View style={[styles.item, styles.itemInvisible]} />;
    }
    return (
      <View style={styles.item}>

      <Animatable.View style={{ width: '100%', height: '100%' }} animation="rotate" iterationCount="infinite" duration={1000} easing='linear'>
        <Image
          resizeMode={'cover'}
          style={{ width: '100%', height: '100%' }}
          source={require('./assets/logo.png')}
        />
      </Animatable.View>
      </View>
    );
  };

  render() {
    return (
      <FlatList
        data={elements}
        style={styles.container}
        renderItem={this.renderItem}
        numColumns={numColumns}
      />
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#FFFFFF'
  },
  item: {
    // backgroundColor: '#4D243D',
    alignItems: 'center',
    justifyContent: 'center',
    flex: 1,
    // margin: 1,

    width: tileSize,
    height: tileSize
  },
  itemInvisible: {
    backgroundColor: 'transparent',
  }
});
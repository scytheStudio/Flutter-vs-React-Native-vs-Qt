import React, {useEffect, useState} from 'react';
import { StyleSheet, Text, View, Keyboard, TouchableOpacity } from 'react-native';
import InputSection from './components/InputSection';
import Task from './components/Task';


export default function App() {

  const [task, setTask] = useState();
  const [tasks, setTasks] = useState([]);

  const getTasks = async () => {
    fetch('http://62766064bc9e46be1a160ec4.mockapi.io/api/v1/tasks', {
        method: 'GET',
    })
    .then(response => { return response.status == 200 ? response.json() : []})
    .then(responseData => { return responseData })
    .then(responseData => {
      if (responseData) {
        setTasks(responseData)
      } else {
        setTasks([])
      }
    })
    .catch(err => {
        console.log("fetch error" + err);
    });
  }

  const handleAddingTask = () => {
    Keyboard.dismiss()
    if (task) {
      fetch('http://62766064bc9e46be1a160ec4.mockapi.io/api/v1/tasks', {
        method: 'POST',
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          task: task,
        })
      })
      .then(() => { getTasks()})
      setTask(null)
    }
  }

  const completeTask = (id) => {
    fetch('http://62766064bc9e46be1a160ec4.mockapi.io/api/v1/tasks/' + id, {
        method: 'DELETE'
    })
    .then(() => { getTasks()})
  }

  useEffect(() => {
    getTasks();
  }, []);

  return (
    <View style={styles.container}>

    {/* Tasks section */}
    <View style={styles.tasksSection}>
      <Text style={styles.tasksSectionTitle}>Your tasks</Text>

      <View style={styles.tasks}>
        {
         tasks.map((taskItem) => {
          return (
            <TouchableOpacity key={taskItem.id} onPress={() => {completeTask(taskItem.id)}}>
              <Task text={taskItem.task}/>
            </TouchableOpacity>
          )
         })
        }
      </View>
    </View>

    {/* Input section */}
    <InputSection
      style={styles.inputSection}
      onChangeText={text => setTask(text)}
      onAddClicked={handleAddingTask()} text={task}/>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#EBEBEB',
  },
  tasksSection: {
    paddingTop: 80,
    paddingHorizontal: 20,
  },
  tasksSectionTitle: {
    fontSize: 24,
    fontWeight: 'bold',
  }, 
  tasks: {
    marginTop: 30,
  },
});
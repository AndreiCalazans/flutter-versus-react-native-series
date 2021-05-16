import "react-native-gesture-handler";
import React, { useState, useEffect } from "react";
import {
  Text,
  SafeAreaView,
  View,
  ScrollView,
  Image,
  TextInput,
  Button,
  Pressable,
  KeyboardAvoidingView,
} from "react-native";

import { NavigationContainer, useNavigation } from "@react-navigation/native";
import {
  createStackNavigator,
  StackScreenProps,
} from "@react-navigation/stack";

const Stack = createStackNavigator();

const getRandomDogPic = () => {
  return fetch("https://dog.ceo/api/breeds/image/random")
    .then((e) => e.json())
    .then((e) => e.message);
};

const RandomDogCard = () => {
  const [dogUrl, setDogUrl] = useState("");
  const [comment, setComment] = useState("");
  const [isEditing, setEditing] = useState(false);
  const navigator = useNavigation();

  useEffect(() => {
    getRandomDogPic().then(setDogUrl);
  }, []);

  return (
    <View
      style={{ backgroundColor: "orange", width: "100%", alignItems: "center" }}
    >
      {dogUrl.length > 0 && (
        <Pressable onPress={() => navigator.navigate("Details", { dogUrl })}>
          <Image
            source={{ uri: dogUrl }}
            style={{
              width: "100%",
              aspectRatio: 1,
            }}
          />
        </Pressable>
      )}
      <Spacer />
      {isEditing ? (
        <TextInput
          style={{ color: "white", fontSize: 22 }}
          placeholder="Add Comment"
          onChangeText={setComment}
          value={comment}
        />
      ) : (
        <Text style={{ color: "white", fontSize: 22, alignSelf: "flex-start" }}>
          {comment.length === 0 ? "Add Comment" : comment}
        </Text>
      )}
      <Spacer />
      <Button
        title={isEditing ? "Save comment" : "Edit Comment"}
        onPress={() => setEditing((wasEditing) => !wasEditing)}
      />
    </View>
  );
};

const Spacer = () => <View style={{ height: 15 }} />;

const DetailsScreen: React.FC<StackScreenProps<{ dogUrl: string }>> = ({
  navigation,
  route,
}) => (
  <View style={{ padding: 15 }}>
    <Button title="Back" onPress={navigation.goBack} />
    <Text>Welcome to the details page</Text>
    <Image
      source={{ uri: route.params?.dogUrl }}
      style={{
        width: "100%",
        aspectRatio: 1,
      }}
    />
    <Text>
      Lorem ipsum stuff Lorem ipsum stuffLorem ipsum stuffLorem ipsum stuffLorem
      ipsum stuffLorem ipsum stuffLorem ipsum stuffLorem ipsum stuffLorem ipsum
      stuffLorem ipsum stuffLorem ipsum stuff
    </Text>
  </View>
);

export default function App() {
  return (
    <SafeAreaView style={{ flex: 1 }}>
      <NavigationContainer>
        <Stack.Navigator headerMode="none">
          <Stack.Screen name="Home" component={HomeScreen} />
          <Stack.Screen name="Details" component={DetailsScreen} />
        </Stack.Navigator>
      </NavigationContainer>
    </SafeAreaView>
  );
}

const HomeScreen: React.FC = () => (
  <KeyboardAvoidingView
    style={{ flex: 1, flexDirection: "column", justifyContent: "center" }}
    keyboardVerticalOffset={80}
    behavior="padding"
  >
    <ScrollView style={{ padding: 15, flex: 1 }}>
      <RandomDogCard />
      <Spacer />
      <RandomDogCard />
      <Spacer />
      <RandomDogCard />
      <Spacer />
    </ScrollView>
  </KeyboardAvoidingView>
);


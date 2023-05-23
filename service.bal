import ballerina/http;


configurable string JOKE_TYPE = "Any";

# A service representing a network-accessible API
# bound to port `9090`.
@display {
	label: "JokeService",
	id: "JokeService-5e6e8a0f-33cc-470b-a503-ffe4813ba79f"
}
service / on new http:Listener(9090) {

    # A resource for generating greetings
    # + return - string name with hello message or error
    resource function get joke() returns string|error {

        http:Client jokeClient = check new ("https://v2.jokeapi.dev/joke/");

        string joke = check jokeClient->/[JOKE_TYPE];
        // Send a response back to the caller.
        if joke is "" {
            return error("Could not fetch Joke at this time");
        }
        return joke;
    }
}

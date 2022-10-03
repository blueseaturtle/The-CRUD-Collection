# Rhyme Ping Pong

Go back and forth with rhymes instead of a ping pong ball and see if you can have the last word! The application uses inputs of previous players to come up with its rhymes as a response to yours.

This application tries to come up with a rhyme for each sentence entered and simultaneously builds up its knowledge by storing each unique sentence entered so that it can be used as a rhyme in the future.

## Technologies used

<img src="https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB" />
<img src="https://img.shields.io/badge/redis-CC0000.svg?&style=for-the-badge&logo=redis&logoColor=white" />
<img src="https://img.shields.io/badge/Express.js-000000?style=for-the-badge&logo=express&logoColor=white" />

### How the data is stored:

The data (sentences received) is stored in as a JSON data structure and a sentence is stored according to the the following schema:

- sentenceString - String
- wordEnding - String

#### Saving a new sentence

- Checking for duplicates first,

```js
const duplicate = await sentenceRepository
  .search()
  .where("sentenceString")
  .equals(req.body.string)
  .return.first();
```

- Then saving the sentence if no duplicates were found. `wordEnding` contains the word ending of the final word of that senetnce.

```js
if (duplicate === null) {
  const sentence = sentenceRepository.createEntity(req.body.string);
  sentence.sentenceString = req.body.string;
  sentence.wordEnding = req.body.wordEnding;
  const id = await sentenceRepository.save(sentence);
  res.send(id);
}
```

### How the data is accessed:

[RediSearch](https://github.com/redis/redis-om-node#-using-redisearch) was used for querying, and data was accessed in the follwong ways, where `sentenceRepository` creates the main access point for reading and writing entities on Redis.:

- Searching for a rhyming sentence
  - Sentences are checked for how well they rhyme by querying the `wordEnding` attribute
  - Then the record with a sentence identical to the user input sentence is removed if available, to avoid repeating the same sentence in the case of a user sending a sentence that is already n the database.
  - A random sentence is picked to be displayed from the retrieved list to avoid displaying the same rhyming sentence each time.

```js
const rhymes = await sentenceRepository
  .search()
  .where("wordEnding")
  .equals(req.params.word)
  .and("sentenceString")
  .not.equals(req.params.sentence)
  .return.all();
```

- Retrieving all stored sentences

```js
const allSentences = await sentenceRepository.search().returnAll();
```

## How to run it locally

### Prerequisites

- **Node** - version ">=14.17.0"

### Local installation

### Frontend

1. Open a terminal in the root of the project folder.
2. Run `cd frontend` to enter the folder.
3. Run `npm install`.
4. After package installation completes, run `npm start`.
5. Open `http://localhost:3000/` in your browser.

### Backend

1. Open a terminal in the root of the project folder.
2. Run `cd backend` to enter the folder.
3. Run `npm install`.
4. Create a free account on [Redis Cloud](https://redis.info/try-free-dev-to) and create your database.
5. Create a new user for the database.
6. In a `.env` file in the root of `/backend` folder, add the values for:

```
REDIS_DB_ENDPOINT=<Public endpoint>
REDIS_USER=<Database user's name>
REDIS_PWD=<Database user's password>
```

6. Run `npm start`.

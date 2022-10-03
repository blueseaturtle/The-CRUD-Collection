import express from "express";
import cors from "cors";
import { Client, Repository } from "redis-om";
import { sentenceSchema } from "./schema/sentence.schema.js";
import dotenv from "dotenv";

dotenv.config();
const app = express();
app.use(express.json());

app.use(
  cors({
    origin: ["http://localhost:3000"],
  })
);

const client = new Client();
await client.open(
  `redis://${process.env.REDIS_USER}:${process.env.REDIS_PWD}@${process.env.REDIS_DB_ENDPOINT}`
);

const sentenceRepository = client.fetchRepository(sentenceSchema);

await sentenceRepository.dropIndex();
await sentenceRepository.createIndex();

//SEARCH FOR A RHYME
app.get("/search-rhyme/:word/:sentence", async (req, res) => {
  if (req.params && req.params.word && req.params.sentence) {
    const rhymes = await sentenceRepository
      .search()
      .where("wordEnding")
      .equals(req.params.word)
      .and("sentenceString")
      .not.equals(req.params.sentence)
      .return.all();

    if (rhymes.length > 0) {
      res.send(rhymes);
    } else {
      res.status(404).send("No rhymes found");
    }
  }
});

//SAVE USER RESPONSE
app.post("/add-new", async (req, res) => {
  const duplicate = await sentenceRepository
    .search()
    .where("sentenceString")
    .equals(req.body.string)
    .return.first();
  if (duplicate === null) {
    const sentence = sentenceRepository.createEntity(req.body.string);
    sentence.sentenceString = req.body.string;
    sentence.wordEnding = req.body.wordEnding;
    const id = await sentenceRepository.save(sentence);
    res.send(id);
  }
});

//RETURNS ALL EXISTING SENTENCES
app.get("/return-all", async (req, res) => {
  res.send(await sentenceRepository.search().returnAll());
});

const PORT = process.env.PORT || 8000;
app.listen(PORT, () => {
  console.log("Server is up and running");
});

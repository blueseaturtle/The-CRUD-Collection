import { Entity, Schema } from "redis-om";

class Sentence extends Entity {}

export const sentenceSchema = new Schema(
  Sentence,
  {
    sentenceString: {
      type: "string",
    },
    wordEnding: {
      type: "string",
    },
  },
  {
    dataStructure: "JSON",
  }
);

const fetch = require("node-fetch");
const { google } = require("googleapis");
const { ideahub } = require("googleapis/build/src/apis/ideahub");
const NewsAPI = require("newsapi");
const newsapi = new NewsAPI(process.env.NEWS_API_KEY);
require("dotenv").config();

let YTTopics = {
  economics: "economics stocks|crypto|housing|theory|taxes|micro|macro",
  renewableEnergy: "renewable energy solar|wind|Hydropower|geothermal|biomass",
  technology: "technology Automated|AI|ML|VR|AR|Blockchain|Web3|Quantum|Cloud",
};

let newsTopics = {
  economics:
    "economics AND (stocks OR crypto OR housing OR theory OR taxes OR micro OR macro)",
  renewableenergy:
    "renewable energy AND (solar OR wind OR Hydropower OR geothermal OR biomass)",
  technology:
    "technology AND (Automated OR AI OR ML OR VR OR AR OR Blockchain OR Web3 OR Quantum OR Cloud)",
};

const service = google.youtube({
  version: "v3",
  auth: process.env.YOUTUBE_API_KEY,
});

function addVideoToDB(video, topic) {
  const mutation = JSON.stringify({
    query: `mutation {
        createArticle (createArticleInput: {
        topic: "${topic}"
        format: "video"
        title: "${video.snippet.title}"
        author: "${video.snippet.channelTitle}"
        desc: "${video.snippet.description}"
        url: "https://www.youtube.com/watch?v=${video.id.videoId}"
        imageUrl: "${video.snippet.thumbnails.default.url}"
      }){
        topic
        format
        title
        author
        url
      }
    }`,
  });
  fetch("http://localhost:5000", {
    headers: { "content-type": "application/json" },
    method: "POST",
    body: mutation,
  }).catch((err) => console.log(err));
}

function addArticleToDB(article, topic) {
  if (article.author == null) article.author = "N/A";
  if (article.desc == null) article.desc = "N/A";
  let desc = article.description.replace(/(<([^>]+)>)/gi, "");
  desc = desc.replace(/"/g, "");
  desc = desc.replace(/\n/g, "");
  article.description = desc;

  const mutation = JSON.stringify({
    query: `mutation {
        createArticle (createArticleInput: {
        topic: "${topic}"
        format: "article"
        title: "${article.title}"
        author: "${article.author}"
        desc: "${article.description}"
        url: "${article.url}"
        imageUrl: "${article.urlToImage}"
      }){
        topic
        format
        title
        author
        url
      }
    }`,
  });
  fetch("http://localhost:5000", {
    headers: { "content-type": "application/json" },
    method: "POST",
    body: mutation,
  }).catch((err) => console.log(err));
}

async function YoutubeAPISearch(topic) {
  const res = await service.search.list(
    {
      part: ["snippet, id"],
      maxResults: 20,
      q: YTTopics[topic],
    },
    (err, res) => {
      if (err) return console.log("API returned an error: " + err);
      const videos = res.data.items;
      if (videos.length) {
        videos.map((video) => addVideoToDB(video, topic));
      }
    }
  );
}

function NewsAPISearch(topic) {
  newsapi.v2
    .everything({
      q: newsTopics[topic],
      language: "en",
      pageSize: 20,
      sortBy: "relevancy",
    })
    .then((response) => {
      const articles = response.articles;
      if (articles.length) {
        articles.map((article) => addArticleToDB(article, topic));
      }
    });
}

function getYoutubeData() {
  for (let topic in YTTopics) YoutubeAPISearch(topic);
}

function getNewsData() {
  for (let topic in newsTopics) NewsAPISearch(topic);
}

function deleteArticles() {
  const mutation = JSON.stringify({
    query: `mutation {
      deleteArticles {
        topic
      }
    }`,
  });
  fetch("http://localhost:5000", {
    headers: { "content-type": "application/json" },
    method: "POST",
    body: mutation,
  }).catch((err) => console.log(err));
}

module.exports = {
  populateDataBase() {
    deleteArticles();
    getYoutubeData();
    getNewsData();
  },
};

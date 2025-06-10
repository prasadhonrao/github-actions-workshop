import express from 'express';
import axios from 'axios';
import dotenv from 'dotenv';
dotenv.config();

const app = express();

app.use(express.json());

const GITHUB_TOKEN = process.env.GITHUB_TOKEN;
const OWNER = process.env.OWNER;
const REPO = process.env.REPO;

app.post('/webhook', async (req, res) => {
  const event = req.headers['x-github-event'];

  if (event === 'star') {
    try {
      await axios.post(
        `https://api.github.com/repos/${OWNER}/${REPO}/dispatches`,
        { event_type: 'starred-repo' },
        {
          headers: {
            Authorization: `token ${GITHUB_TOKEN}`,
            Accept: 'application/vnd.github+json',
          },
        }
      );
      res.sendStatus(200);
    } catch (err) {
      console.error(err.response?.data || err);
      res.sendStatus(500);
    }
  } else {
    res.sendStatus(204);
  }
});

app.listen(3000, () => console.log('Listening on port 3000'));

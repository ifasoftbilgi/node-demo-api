const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 3000;
const HOST = '0.0.0.0';

// Basit sağlık kontrolü
app.get('/health', (req, res) => {
  res.json({ status: 'ok', time: new Date().toISOString() });
});

// Echo endpoint
app.post('/echo', (req, res) => {
  res.json({ you_sent: req.body || null });
});

// Bellekte kullanıcı listesi
let users = [];

// Kullanıcı ekleme
app.post('/user', (req, res) => {
  const { name, age } = req.body;

  if (!name || !age) {
    return res.status(400).json({ error: 'name ve age zorunlu' });
  }

  const newUser = { id: users.length + 1, name, age };
  users.push(newUser);

  res.json({
    message: `Hoş geldin, ${name}!`, 
    user: newUser,
    total_users: users.length
  });
});

// Kullanıcı listesini almaa
app.get('/user', (req, res) => {
  res.json({ users });
});

app.listen(PORT, HOST, () => {
  console.log(`Demo API listening on http://${HOST}:${PORT}`);
});
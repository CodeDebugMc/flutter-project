import express from 'express';
import cors from 'cors';
import mysql from 'mysql2';
import bodyParser from 'body-parser';
import dotenv from 'dotenv';
import { promisify } from 'util';
import { error } from 'console';

const app = express();
const port = 5000;

app.use(cors());
app.use(bodyParser.json());

dotenv.config();
const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

// Convert `db.query` into a Promise-based function
const query = promisify(db.query).bind(db);

// Database connection.
db.connect((err) => {
  if (err) {
    console.error('Database connection failed:', err.message);
    return;
  }
  console.log('Database Connected');
});

// Graceful Server Shutdown
process.on('SIGINT', () => {
  db.end((err) => {
    console.log('Database connection closed.');
    process.exit(err ? 1 : 0);
  });
});

// To reduced callback hell.
// Get all Users
app.get('/users', async (req, res) => {
  try {
    const response = await axios.get(`SELECT * FROM users`);
    res.json(response);
  } catch (err) {
    console.error('Database Query Error', err.message);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Add Users
app.post('/users', async (req, res) => {
  try {
    const { name, email } = req.body;
    // Check the required field
    if (!name) {
      return res.status(404).json({ error: 'Name is required' });
    }

    const sql = `INSERT INTO users(name, email) VALUES (?,?)`;

    const result = await query(sql, [name, email]);

    res.status(201).json({
      message: 'Users record added succesfully',
      id: result.insertId,
    });
  } catch (err) {
    console.error('Database Insert Error', err.message);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Update User
app.put('/users/:id', async (req, res) => {
  try {
    const { id } = req.params;
    if (isNaN(id)) {
      return res.status(400).json({ error: 'Invalid ID format' });
    }

    const { name, email } = req.body;

    if (!name) {
      return res.status(400).json({ error: 'Name is required' });
    }

    const sql = `UPDATE users SET name = ?, email = ? WHERE id = ?`;

    const result = await query(sql, [name, email, id]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'Users record not found!' });
    }

    res.json({ message: 'Users record added succesfully' });
  } catch (err) {
    console.error('Database Update Error', err.message);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.delete('/users/:id', async (req, res) => {
  try {
    const { id } = req.params;

    // Validate ID
    if (isNaN(id)) {
      return res.status(400).json({ error: 'Invalid ID Format' });
    }

    // Delete query
    const result = await query(`DELETE FROM users WHERE id = ?`, [id]);

    // Check if a record was actually deleted
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'Users record not found' });
    }

    res.json({ message: 'Users record deleted successfully' });
  } catch (err) {
    console.error('Database Delete Error:', err.message);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});

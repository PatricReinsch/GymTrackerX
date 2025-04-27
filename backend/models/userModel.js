const db = require('../config/db');

// Find a user by username
const findUserByUsername = async (username) => {
  const [rows] = await db.query('SELECT * FROM users WHERE username = ?', [username]);
  return rows[0]; // Returns the user or undefined if not found
};

// Create a new user
const createUser = async (username, passwordHash) => {
  await db.query('INSERT INTO users (username, password_hash) VALUES (?, ?)', [username, passwordHash]);
};

module.exports = {
  findUserByUsername,
  createUser,
};

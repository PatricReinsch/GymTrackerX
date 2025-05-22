const db = require('../config/db');

exports.createWorkoutPlan = async (req, res) => {
  const { user_id, name } = req.body;

  if (!user_id || !name) {
    return res.status(400).json({ error: 'user_id and name are required' });
  }

  try {
    const sql = 'INSERT INTO workout_plans (user_id, name) VALUES (?, ?)';
    const [result] = await db.execute(sql, [user_id, name]);

    res.status(201).json({ id: result.insertId });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Database error' });
  }
};
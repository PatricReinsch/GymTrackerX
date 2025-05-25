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

exports.getPlansWithSplitsByUser = async (req, res) => {
  const userId = req.params.userId;

  try {
    const [plans] = await db.execute(
      'SELECT wp.id AS plan_id, wp.name AS plan_name, s.id AS split_id, s.name AS split_name ' +
      'FROM workout_plans wp ' +
      'LEFT JOIN splits s ON wp.id = s.plan_id ' +
      'WHERE wp.user_id = ? ' +
      'ORDER BY wp.id, s.id',
      [userId]
    );

    // Group by workout_plan
    const result = {};
    plans.forEach(row => {
      const { plan_id, plan_name, split_id, split_name } = row;

      if (!result[plan_id]) {
        result[plan_id] = {
          id: plan_id,
          name: plan_name,
          splits: [],
        };
      }

      if (split_id && split_name) {
        result[plan_id].splits.push({ id: split_id, name: split_name });
      }
    });

    res.status(200).json(Object.values(result));
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error when loading the workout plans' });
  }
};

exports.deleteWorkoutPlan = async (req, res) => {
  const planId = req.params.id;

  try {
    await db.execute('DELETE FROM workout_plans WHERE id = ?', [planId]);
    res.status(200).json({ message: 'Workout plan deleted successfully' });
  } catch (err) {
    console.error('Error when deleting:', err.message);
    res.status(500).json({ error: 'Error when deleting the plan' });
  }
};



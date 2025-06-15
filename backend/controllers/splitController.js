const db = require('../config/db');

// Split erstellen
exports.createSplit = async (req, res) => {
  const { plan_id, name } = req.body;

  if (!plan_id || !name) {
    return res.status(400).json({ error: 'plan_id und name sind erforderlich' });
  }

  try {
    const [result] = await db.execute(
      'INSERT INTO splits (plan_id, name) VALUES (?, ?)',
      [plan_id, name]
    );

    res.status(201).json({ id: result.insertId });
  } catch (err) {
      console.error('❌ Fehler beim Split erstellen:', err.message);
      console.error('📄 Stack:', err.stack);
      res.status(500).json({ error: 'Serverfehler beim Erstellen des Splits' });
    }

};

// Exercise zum Split hinzufügen
exports.addExerciseToSplit = async (req, res) => {
  const { split_id, exercise_id, weight, sets, reps } = req.body;

  if (!split_id || !exercise_id || !sets || !reps) {
    return res.status(400).json({ error: 'Alle Felder sind erforderlich' });
  }

  try {
    await db.execute(
      'INSERT INTO split_exercises (split_id, exercise_id, weight, sets, reps) VALUES (?, ?, ?, ?, ?)',
      [split_id, exercise_id, weight, sets, reps]
    );

    res.status(201).json({ message: 'Übung zum Split hinzugefügt' });
  } catch (err) {
    console.error('Fehler beim Hinzufügen der Übung:', err.message);
    res.status(500).json({ error: 'Serverfehler beim Speichern der Übung' });
  }
};

exports.getExercisesForSplit = async (req, res) => {
  const splitId = req.params.splitId;

  try {
    const [rows] = await db.execute(
      `SELECT e.name, se.weight, se.sets, se.reps
       FROM split_exercises se
       JOIN exercises e ON se.exercise_id = e.id
       WHERE se.split_id = ?`,
      [splitId]
    );

    res.status(200).json(rows);
  } catch (err) {
    console.error('Fehler beim Laden der Übungen:', err);
    res.status(500).json({ error: 'Fehler beim Laden der Übungen' });
  }
};


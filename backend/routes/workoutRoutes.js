const express = require('express');
const router = express.Router();
const workoutController = require('../controllers/workoutController');

router.post('/', workoutController.createWorkoutPlan);
router.get('/user/:userId', workoutController.getPlansWithSplitsByUser);
router.delete('/:id', workoutController.deleteWorkoutPlan);

module.exports = router;

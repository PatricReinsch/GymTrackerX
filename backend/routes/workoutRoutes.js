const express = require('express');
const router = express.Router();
const workoutController = require('../controllers/workoutController');

router.post('/', workoutController.createWorkoutPlan);

module.exports = router;
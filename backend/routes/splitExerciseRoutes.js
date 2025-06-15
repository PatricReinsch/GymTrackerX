const express = require('express');
const router = express.Router();
const splitController = require('../controllers/splitController');

router.post('/', splitController.addExerciseToSplit);

module.exports = router;

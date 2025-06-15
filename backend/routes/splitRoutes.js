const express = require('express');
const router = express.Router();
const splitController = require('../controllers/splitController');

router.post('/', splitController.createSplit);
router.post('/exercises', splitController.addExerciseToSplit);
router.get('/:splitId/exercises', splitController.getExercisesForSplit);



module.exports = router;

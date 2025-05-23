const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const bodyParser = require('body-parser');
const authRoutes = require('./routes/authRoutes'); // Import authentication routes
const workoutRoutes = require('./routes/workoutRoutes'); // Import workout routes
const splitRoutes = require('./routes/splitRoutes');
const splitExerciseRoutes = require('./routes/splitExerciseRoutes');


// Load environment variables
dotenv.config();

// Create an Express app
const app = express();

// Middleware
app.use(cors()); // Enable CORS (Cross-Origin Resource Sharing)
app.use(bodyParser.json()); // Parse incoming JSON requests
app.use(express.json());

// Use authentication routes
app.use('/api/auth', authRoutes);
app.use('/api/workouts', workoutRoutes);
app.use('/api/splits', splitRoutes);
app.use('/api/split-exercises', splitExerciseRoutes);


// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));

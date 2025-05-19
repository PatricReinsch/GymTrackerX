const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const bodyParser = require('body-parser');
const authRoutes = require('./routes/authRoutes'); // Import authentication routes

// Load environment variables
dotenv.config();

// Create an Express app
const app = express();

// Middleware
app.use(cors()); // Enable CORS (Cross-Origin Resource Sharing)
app.use(bodyParser.json()); // Parse incoming JSON requests

// Use authentication routes
app.use('/api/auth', authRoutes);

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));

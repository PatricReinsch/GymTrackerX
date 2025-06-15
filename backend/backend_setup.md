# Backend Setup #
Folgende Schritte sind notwendig um die Datenbank
und den Backend Server zu erstellen. Dazu muss das Node.js SDS installiert sein.

1. Im Terminal: ...\GymTrackerX>: flutter pub get 
2. Installiere xampp und öffne die Anwendung xampp-control
3. Starte Apache & MySQL
4. öffne im Browser: http://localhost/phpmyadmin/
5. Führe die folgenden SQL Commands aus, um die Datenbanken lokal zu erstellen (Aufbau der Datenbank findest du in /doc/uml/UML-Klassendiagramm_Datenbank):
   ## SQL Commands:
   CREATE DATABASE gym_tracker_x;

   USE gym_tracker_x;
   CREATE TABLE users (
   id INT AUTO_INCREMENT PRIMARY KEY,
   username VARCHAR(255) NOT NULL UNIQUE,
   password_hash VARCHAR(255) NOT NULL
   );

   CREATE TABLE workout_plans (
   id INT AUTO_INCREMENT PRIMARY KEY,
   user_id INT NOT NULL,
   name VARCHAR(100) NOT NULL,
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
   );

   CREATE TABLE splits (
   id INT AUTO_INCREMENT PRIMARY KEY,
   plan_id INT NOT NULL,
   name VARCHAR(100) NOT NULL,
   FOREIGN KEY (plan_id) REFERENCES workout_plans(id) ON DELETE CASCADE
   );

   CREATE TABLE exercises (
   id INT AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(100) UNIQUE NOT NULL
   );

   CREATE TABLE split_exercises (
   id INT AUTO_INCREMENT PRIMARY KEY,
   split_id INT NOT NULL,
   exercise_id INT NOT NULL,
   weight DECIMAL(5,2),
   sets INT,
   reps INT,
   FOREIGN KEY (split_id) REFERENCES splits(id) ON DELETE CASCADE,
   FOREIGN KEY (exercise_id) REFERENCES exercises(id) ON DELETE CASCADE
   );

   INSERT INTO exercises (name) VALUES
   ('Leg Press'),
   ('Squats'),
   ('Deadlift'),
   ('Bench Press'),
   ('Shoulder Press'),
   ('Bicep Curls'),
   ('Tricep Extensions'),
   ('Lunges'),
   ('Pull-ups');

6. Im Terminal: ...\GymTrackerX\backend>: npm start
    
# Backend Setup #
Folgende Schritte sind notwendig um die Datenbank
und den Backend Server zu erstellen. Dazu muss das Node.js SDS installiert sein.
1. flutter pub get (Terminal)
2. Xampp install
3. Start apache & mysql
4. go to: http://localhost/phpmyadmin/
5. ## SQL Commands:
   CREATE DATABASE gym_tracker_x;

   USE gym_tracker_x;
   CREATE TABLE users (
   id INT AUTO_INCREMENT PRIMARY KEY,
   username VARCHAR(255) NOT NULL UNIQUE,
   password_hash VARCHAR(255) NOT NULL
   );
6. npm start (in backend dir terminal)
    
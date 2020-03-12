# Game Maker Studio 2 :: MMO (Massively Multiplayer Online) Game Engine

This is a project I started, but have stopped working on.

- Game client is written in GMS2.
- Server is written in NodeJS.
- Rest API written in PHP for account creation and login credential checking.

### What has been done
- Create account
- Login to account
- Join game server
- Walk around in server
- Multiple clients can join the server and see players move around

### Contributing
If you would like to add some features, fix some stuff up, you can fork the repo and send a PR with any code changes you make.

### Running Client/Server
1. Host the PHP Rest API web server files on an Apache or NGix server with PHP support.
2. Import the .SQL file database structure on your web server.
3. Install NodeJS on Windows or MacOS : https://nodejs.org
4. Open a command or terminal prompt, navigate to the node_server directory, do `npm install` command to get all dependencies.
5. Run the `start_server_(Windows or MacOS)` script files to start the game server.
6. Play the game. There is a test account created by default in the SQL database. username: test, password: test.

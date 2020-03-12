var net = require("net");
var PORT = 13000;
var clients = [];

var server = net.createServer();

server.on("connection", function(sock) {
	// set some default values
	sock.setTimeout(5000);
	clients.push(sock);
	sock.accID = 0;

	// set our socket events
	sock.on("error", err => {
		console.log("TCP_ERROR: Removing client ID:" + sock.accID + " " + err);
		clearInterval(kA);
		endSocket(sock);
	});

	sock.on("data", function(data) {
		//console.log('RAW DATA RCVD: ' + sock.remoteAddress + ': ' + data);
		var readData = data + "";

		if (readData[readData.length - 1] == "\0") {
			// check if end of msg (if last char is null)
			var msg = readData.split("\0"); // split data at null
			for (var i = 0, len = msg.length; i < len; i++) {
				if (msg[i].length > 0) {
					// if not dead end
					console.log("MSG RCVD: " + msg[i]);
					if (msg[i].indexOf("|") > -1)
						// command
						parseCMD(msg[i], sock);
					// normal chat msg
					else broadcast(msg[i]);
				}
			}
		} else {
			readData += readData; // append to new data and wait for null char
		}
	});

	sock.on("end", function() {
		console.log("ENDED: Removing client ID:" + sock.accID);
		clearInterval(kA);
		endSocket(sock);
	});

	sock.on("timeout", function() {
		console.log("TIMEOUT: Removing client ID:" + sock.accID);
		clearInterval(kA);
		endSocket(sock);
	});

	// show game the server is still alive
	var kA = setInterval(function() {
		broadcast("tick");
		//console.log("[DEBUG] sending tick to stay alive");
	}, 2000);
});

function endSocket(sock) {
	broadcast("disconnected," + sock.accID);
	sock.end();
	sock.destroy();
	console.log("attempting to removing acc ID: " + sock.accID);

	for (var i = clients.length - 1; i >= 0; i--) {
		if (clients[i].accID === sock.accID) {
			console.log("clients array successfully removed acc ID: " + sock.accID);
			clients.splice(i, 1);
		}
	}
	console.log("endSocket function called");
}

function broadcast(message) {
	clients.forEach(function(client) {
		//console.log("SENDING:" + message);
		if (client.writable)
			// gotta test this
			client.write(message + "\0");
	});
}

function parseCMD(cmd, sock) {
	var nCmd = cmd.split("|");
	var sCmd = nCmd[1].split(",");
	if (nCmd[0] == "lm") {
		// list members. Format: 0 = command
		var cNames = [];
		clients.forEach(function(client) {
			//cNames.push(client.name);
			sock.write("lm," + client.accID + "\0");
		});
	} else if (nCmd[0] == "move") {
		// move character
		broadcast(
			"move," + sCmd[0] + "," + sCmd[1] + "," + sCmd[2] + "," + sCmd[3]
		);
	} else if (nCmd[0] == "spawn") {
		// spawn character
		sock.accID = sCmd[0];
		broadcast("spawn," + sCmd[0] + "," + sCmd[1] + "," + sCmd[2]); // broadcast to existing players
		clients.forEach(function(client) {
			// send to new player who is here currently
			//cNames.push(client.name);
			sock.write("spawn," + client.accID + "\0");
		});
	}
}

server.listen(PORT, function() {
	console.log("Listening on port " + PORT);
});

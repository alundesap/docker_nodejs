/*eslint no-console: 0, no-unused-vars: 0, no-shadow: 0, new-cap: 0*/
"use strict";
var express = require("express");

module.exports = () => {
	var app = express.Router();

	//Hello Router
	app.get("/", (req, res) => {
		console.log("/node/mysql/");
		let client = require("mysql");

		var output = "";

		const xsenv = require("@sap/xsenv");
                let mysqlOptions = xsenv.getServices({
                        'user-provided': { name: "docker-mysqls-dbt" }                
                });

		const myconf = mysqlOptions['user-provided'];

		console.log(JSON.stringify(myconf));

		let conn = client.createConnection({
		  host     : 'localhost',
		  //user     : 'root',
		  user     : myconf.mysql_username,
		  //password : 'Nirvana8484',
		  password : myconf.mysql_password,
		  //database : 'test'
		  database : myconf.mysql_database
		});

		output += "Creating MySQL connection.\n";

		conn.connect(function(err) {
			if (err) {
				output += "Connection Error:" + err.message + "\n";
				res.send(output);
			}
			else {
				conn.query('SELECT * FROM test.test2', function (error, result, fields) {
					if (error) {
						output += "error: " + error.message + "\n";
						res.send(output);
					}
					else {
						Object.keys(result).forEach(function(key) {
							var row = result[key];
							output += "Row[" + row.id + "]: " + row.value + "\n";
						});
						output += "Closing MySQL connection.\n";
						conn.end();
						res.send(output);
					}
				});
			}
		});
	});
	return app;
};


/*eslint no-console: 0, no-unused-vars: 0, no-undef:0*/
/*eslint-env node, es6 */
"use strict";
var output = "";
var https = require("https");
var xsenv = require("@sap/xsenv");
var port = process.env.PORT || 3000;
var server = require("http").createServer();
https.globalAgent.options.ca = xsenv.loadCertificates();
global.__base = __dirname + "/";

//Initialize Express App for XSA UAA and HDBEXT Middleware
var passport = require("passport");
var xssec = require("@sap/xssec");
var xsHDBConn = require("@sap/hdbext");
var express = require("express");

//Initialize Express App for XS UAA and HDBEXT Middleware
var app = express();

passport.use("JWT", new xssec.JWTStrategy(xsenv.getServices({
	uaa: {
		tag: "xsuaa"
	}
}).uaa));

app.use(passport.initialize());
//var hanaOptions = xsenv.getServices({
//	hana: {
//		tag: "hana"
//	}
//});

//app.use(
//	passport.authenticate("JWT", {
//		session: false
//	}),
//	xsHDBConn.middleware(hanaOptions.hana)
//);

//Setup Routes
var router = require("./router")(app, server);

//Start the Server 
server.on("request", app);
server.listen(port, function() {
	console.info(`HTTP Server: ${server.address().port}`);
});


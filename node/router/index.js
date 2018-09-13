/*eslint-env node, es6 */
"use strict";

module.exports = (app, server) => {
	app.use("/node/ex1", require("./routes/ex1")());
	app.use("/node/ex2", require("./routes/ex2")());
	app.use("/node/auth", require("./routes/auth")());	
	app.use("/node/mysql", require("./routes/mysql")());
};

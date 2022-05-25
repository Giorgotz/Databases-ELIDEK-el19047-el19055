const { Client }= require('pg');

/* create connection and export it */
const client = new Client({
    host: "localhost",
    port: 5432,
    user: "panagiotis",
    password: "0000",
    database: "panagiorgis",
});

module.exports = { client };
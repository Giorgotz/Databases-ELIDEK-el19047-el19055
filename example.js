const { connect } = require('http2')
const {Client} =  require('pg')

const client = new Client({
    host: "localhost",
    user: "panagiotis",
    port: 5432,
    password: "0000",
    database: "test"
})

client.connect();

client.query("SELECT * FROM research_center", (err,res)=>{
    if(!err){
        console.log(res.rows);
    } else{
        console.log(err,message);
    }
    client.end;
})
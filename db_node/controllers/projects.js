const { client } = require('../utils/database')

/* Controller to retrieve grades from database */
exports.getProjects = (req, res, next) => {

    /* check for messages in order to show them when rendering the page */
    let messages = req.flash("messages");
    if (messages.length == 0) messages = [];

    client.connect();

    client.query("SELECT * FROM project",(err,conn) => {
        if(!err) {
            res.render('projects.ejs',{
                pageTitle: "Project page",
                project: conn.rows,
                messages: messages
            })
        }
        else{
            console.log(err,messages)
        }
        client.end;
    })

    /* create the connection, execute query, render data 
    pool.getConnection((err, conn) => {
        
        conn.promise().query('SELECT * FROM project')
        .then(([rows, fields]) => {
            res.render('projects.ejs', {
                pageTitle: "Projects Page",
                projects: rows,
                messages: messages
            })
        })
        .then(() => pool.releaseConnection(conn))
        .catch(err => console.log(err))
    })*/

}
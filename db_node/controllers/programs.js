const { client } = require('../utils/database')

/* Controller to retrieve grades from database */
exports.getPrograms = (req, res, next) => {

    /* check for messages in order to show them when rendering the page */
    let messages = req.flash("messages");
    if (messages.length == 0) messages = [];

    client.connect();

    client.query("SELECT * FROM program",(err,conn) => {
        if(!err) {
            res.render('programs.ejs',{
                pageTitle: "Programs page",
                program: conn.rows,
                messages: messages
            })
        }
        else{
            console.log(err,messages)
        }
        client.end;
    })
}

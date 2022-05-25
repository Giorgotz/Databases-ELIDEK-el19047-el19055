const { client } = require('../utils/database')

/* Controller to retrieve grades from database */
exports.getResearchers = (req, res, next) => {

    /* check for messages in order to show them when rendering the page */
    let messages = req.flash("messages");
    if (messages.length == 0) messages = [];

    client.connect();

    client.query("SELECT * FROM researcher",(err,conn) => {
        if(!err) {
            res.render('researchers.ejs',{
                pageTitle: "Researchers",
                researcher: conn.rows,
                messages: messages
            })
        }
        else{
            console.log(err,messages)
        }
        client.end;
    })
}
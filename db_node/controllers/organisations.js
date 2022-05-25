const { client } = require('../utils/database')

/* Controller to retrieve grades from database */
exports.getOrgs = (req, res, next) => {

    /* check for messages in order to show them when rendering the page */
    let messages = req.flash("messages");
    if (messages.length == 0) messages = [];

    client.connect();

    client.query("SELECT * FROM organisation",(err,conn) => {
        if(!err) {
            res.render('organisations.ejs',{
                pageTitle: "Organisations page",
                telFlag: true,
                orgs: conn.rows,
                messages: messages
            })
        }
        else{
            console.log(err,messages)
        }
        client.end;
    })
}
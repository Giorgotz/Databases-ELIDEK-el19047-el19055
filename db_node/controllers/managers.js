const db = require('../utils/database')


exports.getManagers = async (req, res) => {
    try{
        const response = await db.query("SELECT * FROM manager");
        res.render('managers.ejs',{
            pageTitle: "managers page",
            manager: response.rows,
        })
    }
    catch(error) {
        console.log(error);
        res.redirect('/home');
    }
}

/* Controller to retrieve grades from database 
exports.getManagers = (req, res, next) => {

    check for messages in order to show them when rendering the page 
    let messages = req.flash("messages");
    if (messages.length == 0) messages = [];

    client.connect();

    client.query("SELECT * FROM manager",(err,conn) => {
        if(!err) {
            res.render('managers.ejs',{
                pageTitle: "managers page",
                manager: conn.rows,
                messages: messages
            })
        }
        else{
            console.log(err,messages)
        }
    })
} */
exports.postManager = async (req, res, next) => {

    /* get necessary data sent */
    const name = req.body.name;
    const surname = req.body.surname;
    try{
        await db.query("INSERT INTO manager (manager_name , manager_surname) VALUES ($1, $2)",[name, surname]);
    }
    catch(err){
        console.error(err);
    }
    res.redirect('/managers');

}
/* Controller to update a student in the database */
exports.postUpdateManager = async (req, res, next) => {
    /* get necessary data sent */
    const id = parseInt(req.body.id);
    const name = req.body.name;
    const surname = req.body.surname;
    try{
        await db.query("UPDATE manager SET manager_name = $1 , manager_surname = $2 WHERE manager_id = $3",[name, surname, id]);
    }
    catch(err) {
        console.error(err);
    }
    res.redirect('/managers');
};
exports.deleteManager = async (req, res, next) => {
    /* get necessary data sent */
    const id = parseInt(req.body.id);
    try{
        await db.query("DELETE FROM manager WHERE manager_id = $1",[id]);
    }
    catch(err){
        console.error(err);
    }
    res.redirect('/managers');
};

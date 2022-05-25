const { client } = require('../utils/database')

/* Controller to retrieve grades from database */
exports.getManagers = (req, res, next) => {

    /* check for messages in order to show them when rendering the page */
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
}
exports.postStudent = (req, res, next) => {

    /* get necessary data sent */
    const name = req.body.name;
    const surname = req.body.surname;
    const email = req.body.email;

    /* create the connection, execute query, flash respective message and redirect to grades route */
    pool.getConnection((err, conn) => {
        var sqlQuery = `INSERT INTO students(name, surname, email) VALUES(?, ?, ?)`;

        conn.promise().query(sqlQuery, [name, surname, email])
        .then(() => {
            pool.releaseConnection(conn);
            req.flash('messages', { type: 'success', value: "Successfully added a new Student!" })
            res.redirect('/');
        })
        .catch(err => {
            req.flash('messages', { type: 'error', value: "Something went wrong, Student could not be added." })
            res.redirect('/');
        })
    })
}

/* Controller to update a student in the database */
exports.postUpdateManager = (req, res, next) => {

    /* get necessary data sent */
    const id = req.body.id;
    const name = req.body.name;
    const surname = req.body.surname;

   

    var sqlQuery = `UPDATE manager SET manager_name = ${name} , manager_surname = ${surname} WHERE manager_id = ${id} `
    
    client.query(sqlQuery)
    .catch(e => console.log(e))

    /*client.query(sqlQuery,(err,conn) => {
        if(!err) {
            req.flash('messages', { type: 'success', value: "Successfully updated student!" })
            res.redirect('/managers');
        }
        else{
            req.flash('messages', { type: 'error', value: "Something went wrong, Student could not be updated." })
            res.redirect('/managers');
        }
        client.end;
    })*/
}
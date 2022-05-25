const db = require('../utils/database')

exports.getOrgs = async (req, res) => {
    const response = await db.query("SELECT * FROM organisation");
    res.render('organisations.ejs',{
        pageTitle: "organisations page",
        orgs: response.rows,
    })
}

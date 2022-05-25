const db = require('../utils/database')

/* Controller to retrieve grades from database */
exports.getResearchers = async (req, res) => {
    const response = await db.query("SELECT * FROM researcher");
    res.render('researchers.ejs',{
        pageTitle: "researchers page",
        researchers: response.rows,
    })
}
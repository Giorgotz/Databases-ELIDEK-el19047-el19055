const db = require('../utils/database')

/* Controller to retrieve grades from database */
exports.getPrograms = async (req, res) => {
    const response = await db.query("SELECT * FROM program");
    res.render('programs.ejs',{
        pageTitle: "programs page",
        program: response.rows,
    })
}

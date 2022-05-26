const db = require('../utils/database')

/* Controller to retrieve grades from database */
exports.getProjects = async (req, res) => {
    const response = await db.query("SELECT * FROM project");
    res.render('projects.ejs',{
        pageTitle: "projects page",
        project: response.rows,
    })
}
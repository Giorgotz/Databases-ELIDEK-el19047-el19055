const express = require('express');
const path = require('path');
const session = require('express-session');
const flash = require('connect-flash');

//equire('custom-env').env('localhost');

/* ROUTES and how to import routes */
/*
const home = require('./routes/home');
const login = require('./routes/login');

const most_active_orgs = require('./routes/most_active_orgs')

const researchers_on = require('./routes/researchers_on');
const researchers_stats = require('./routes/researchers_stats');


const corrupted_managers = require('./routes/corrupted_managers');*/
const projects = require('./routes/projects');
const researchers = require('./routes/researchers');
const organisations = require('./routes/organisations');
const elidek_managers = require('./routes/elidek_managers');
const elidek_programs = require('./routes/elidek_programs');
/* end of ROUTES and how to import routes */

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(express.static(path.join(__dirname, 'public')));
app.set('view engine', 'ejs');
app.set('views', 'views');

app.use(flash());

app.use(session({
    secret: "ThisShouldBeSecret",
    resave: false,
    saveUninitialized: false
}));

/*Routes used by the project */
/*app.use('/',home);
app.use('/login', login);

app.use('/organisations/most_active', most_active_orgs);

app.use('/managers/suspicious',corrupted_managers);



app.use('/researchers/project_list',researchers_on);
app.use('/researchers/project_list/statistics',researchers_stats);*/
app.use('/projects',projects);
app.use('/researchers', researchers);
app.use('/managers', elidek_managers);
app.use('/organisations', organisations);
app.use('/programs',elidek_programs);
/* End of routes used by the project*/

// In case of an endpoint does not exist must return 404.html

app.use((req, res, next) => { res.status(404).render('404.ejs', { pageTitle: '404' }) })

module.exports = app;
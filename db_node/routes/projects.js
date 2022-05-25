const express = require('express');
const  projectsController = require('../controllers/projects');

const router = express.Router();

router.get('/', projectsController.getProjects);

module.exports = router;
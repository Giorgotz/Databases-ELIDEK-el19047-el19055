const express = require('express');
const  programsController = require('../controllers/programs');

const router = express.Router();

router.get('/', programsController.getPrograms);

module.exports = router;
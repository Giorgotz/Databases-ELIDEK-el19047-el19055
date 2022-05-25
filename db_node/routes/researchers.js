const express = require('express');
const  researchersController = require('../controllers/researchers');

const router = express.Router();

router.get('/', researchersController.getResearchers);

module.exports = router;
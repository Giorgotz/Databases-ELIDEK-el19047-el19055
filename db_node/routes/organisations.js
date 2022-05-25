const express = require('express');
const orgsController = require('../controllers/organisations');

const router = express.Router();

router.get('/', orgsController.getOrgs);

module.exports = router;
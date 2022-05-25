const express = require('express');
const  managersController = require('../controllers/managers');

const router = express.Router();

router.get('/', managersController.getManagers);
router.post('/update/:id', managersController.postUpdateManager)
router.post('/create/:id', managersController.postManager)
module.exports = router;
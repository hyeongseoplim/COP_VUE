const express = require('express');
const router = express.Router();

const controller = require('./controller');

router.get('/ka3794', controller.ka3794);

module.exports = router;
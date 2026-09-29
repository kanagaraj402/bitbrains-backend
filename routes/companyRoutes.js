const express = require("express");
const router = express.Router();
const { requireAuth } = require("../middleware/auth");
const { getCompanyInfo, updateCompanyInfo } = require("../controllers/companyController");

router.get("/", getCompanyInfo);
router.put("/", requireAuth, updateCompanyInfo);

module.exports = router;

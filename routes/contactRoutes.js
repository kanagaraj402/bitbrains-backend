const express = require("express");
const router = express.Router();
const { createContact, getAllContacts } = require("../controllers/contactController");

router.post("/", createContact);
router.get("/", getAllContacts); // consider protecting this route later

module.exports = router;

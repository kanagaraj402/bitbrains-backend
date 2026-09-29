const express = require("express");
const router = express.Router();
const { requireAuth } = require("../middleware/auth");
const {
  getAllTechnologies,
  createTechnology,
  updateTechnology,
  deleteTechnology,
} = require("../controllers/technologiesController");

// Public
router.get("/", getAllTechnologies);

// Admin-only
router.post("/", requireAuth, createTechnology);
router.put("/:id", requireAuth, updateTechnology);
router.delete("/:id", requireAuth, deleteTechnology);

module.exports = router;

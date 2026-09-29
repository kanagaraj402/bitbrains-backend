const express = require("express");
const router = express.Router();
const { requireAuth } = require("../middleware/auth");
const {
  getAllClients,
  createClient,
  updateClient,
  deleteClient,
} = require("../controllers/clientsController");

// Public
router.get("/", getAllClients);

// Admin-only
router.post("/", requireAuth, createClient);
router.put("/:id", requireAuth, updateClient);
router.delete("/:id", requireAuth, deleteClient);

module.exports = router;
const express = require("express");
const router = express.Router();
const { requireAuth } = require("../middleware/auth");
const {
  getAllServices,
  getServiceBySlug,
  createService,
  updateService,
  deleteService,
} = require("../controllers/servicesController");

// Public
router.get("/", getAllServices);
router.get("/:slug", getServiceBySlug);

// Admin-only
router.post("/", requireAuth, createService);
router.put("/:id", requireAuth, updateService);
router.delete("/:id", requireAuth, deleteService);

module.exports = router;

const express = require("express");
const router = express.Router();
const { requireAuth } = require("../middleware/auth");
const {
  getAllPortfolio,
  getPortfolioBySlug,
  createPortfolio,
  updatePortfolio,
  deletePortfolio,
} = require("../controllers/portfolioController");

// Public
router.get("/", getAllPortfolio);
router.get("/:slug", getPortfolioBySlug);

// Admin-only
router.post("/", requireAuth, createPortfolio);
router.put("/:id", requireAuth, updatePortfolio);
router.delete("/:id", requireAuth, deletePortfolio);

module.exports = router;

const express = require("express");
const router = express.Router();
const { requireAuth } = require("../middleware/auth");
const {
  getAllProducts,
  getProductBySlug,
  createProduct,
  updateProduct,
  deleteProduct,
} = require("../controllers/productsController");

// Public
router.get("/", getAllProducts);
router.get("/:slug", getProductBySlug);

// Admin-only
router.post("/", requireAuth, createProduct);
router.put("/:id", requireAuth, updateProduct);
router.delete("/:id", requireAuth, deleteProduct);

module.exports = router;

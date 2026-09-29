const pool = require("../config/db");

exports.getAllProducts = async (req, res) => {
  try {
    const result = await pool.query(
      "SELECT * FROM products ORDER BY sort_order ASC, id ASC"
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to fetch products" });
  }
};

exports.getProductBySlug = async (req, res) => {
  try {
    const { slug } = req.params;
    const result = await pool.query(
      "SELECT * FROM products WHERE slug = $1",
      [slug]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Product not found" });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to fetch product" });
  }
};

// --- Admin-only below (mounted behind requireAuth in routes) ---

exports.createProduct = async (req, res) => {
  try {
    const { name, slug, description, icon_url, sort_order } = req.body;

    if (!name || !slug) {
      return res.status(400).json({ error: "name and slug are required" });
    }

    const result = await pool.query(
      `INSERT INTO products (name, slug, description, icon_url, sort_order)
       VALUES ($1, $2, $3, $4, COALESCE($5, 0))
       RETURNING *`,
      [name, slug, description || null, icon_url || null, sort_order]
    );

    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error(err);
    if (err.code === "23505") {
      return res.status(409).json({ error: "A product with that slug already exists" });
    }
    res.status(500).json({ error: "Failed to create product" });
  }
};

exports.updateProduct = async (req, res) => {
  try {
    const { id } = req.params;
    const { name, slug, description, icon_url, sort_order } = req.body;

    const result = await pool.query(
      `UPDATE products SET
         name = COALESCE($1, name),
         slug = COALESCE($2, slug),
         description = COALESCE($3, description),
         icon_url = COALESCE($4, icon_url),
         sort_order = COALESCE($5, sort_order)
       WHERE id = $6
       RETURNING *`,
      [name, slug, description, icon_url, sort_order, id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Product not found" });
    }

    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to update product" });
  }
};

exports.deleteProduct = async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query("DELETE FROM products WHERE id = $1 RETURNING id", [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Product not found" });
    }

    res.json({ message: "Product deleted", id: result.rows[0].id });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to delete product" });
  }
};

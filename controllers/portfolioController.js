const pool = require("../config/db");

exports.getAllPortfolio = async (req, res) => {
  try {
    const result = await pool.query(
      "SELECT * FROM portfolio ORDER BY sort_order ASC, id ASC"
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to fetch portfolio items" });
  }
};

exports.getPortfolioBySlug = async (req, res) => {
  try {
    const { slug } = req.params;
    const result = await pool.query(
      "SELECT * FROM portfolio WHERE slug = $1",
      [slug]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Portfolio item not found" });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to fetch portfolio item" });
  }
};

// --- Admin-only below (mounted behind requireAuth in routes) ---

exports.createPortfolio = async (req, res) => {
  try {
    const { title, slug, client_name, description, image_url, project_url, sort_order } = req.body;

    if (!title || !slug) {
      return res.status(400).json({ error: "title and slug are required" });
    }

    const result = await pool.query(
      `INSERT INTO portfolio (title, slug, client_name, description, image_url, project_url, sort_order)
       VALUES ($1, $2, $3, $4, $5, $6, COALESCE($7, 0))
       RETURNING *`,
      [title, slug, client_name || null, description || null, image_url || null, project_url || null, sort_order]
    );

    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error(err);
    if (err.code === "23505") {
      return res.status(409).json({ error: "A portfolio item with that slug already exists" });
    }
    res.status(500).json({ error: "Failed to create portfolio item" });
  }
};

exports.updatePortfolio = async (req, res) => {
  try {
    const { id } = req.params;
    const { title, slug, client_name, description, image_url, project_url, sort_order } = req.body;

    const result = await pool.query(
      `UPDATE portfolio SET
         title = COALESCE($1, title),
         slug = COALESCE($2, slug),
         client_name = COALESCE($3, client_name),
         description = COALESCE($4, description),
         image_url = COALESCE($5, image_url),
         project_url = COALESCE($6, project_url),
         sort_order = COALESCE($7, sort_order)
       WHERE id = $8
       RETURNING *`,
      [title, slug, client_name, description, image_url, project_url, sort_order, id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Portfolio item not found" });
    }

    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to update portfolio item" });
  }
};

exports.deletePortfolio = async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query("DELETE FROM portfolio WHERE id = $1 RETURNING id", [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Portfolio item not found" });
    }

    res.json({ message: "Portfolio item deleted", id: result.rows[0].id });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to delete portfolio item" });
  }
};

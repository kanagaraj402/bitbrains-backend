const pool = require("../config/db");

exports.getAllServices = async (req, res) => {
  try {
    const result = await pool.query(
      "SELECT * FROM services ORDER BY sort_order ASC, id ASC"
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to fetch services" });
  }
};

exports.getServiceBySlug = async (req, res) => {
  try {
    const { slug } = req.params;
    const result = await pool.query(
      "SELECT * FROM services WHERE slug = $1",
      [slug]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Service not found" });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to fetch service" });
  }
};

// --- Admin-only below (mounted behind requireAuth in routes) ---

exports.createService = async (req, res) => {
  try {
    const { title, slug, summary, full_description, image_url, sort_order } = req.body;

    if (!title || !slug) {
      return res.status(400).json({ error: "title and slug are required" });
    }

    const result = await pool.query(
      `INSERT INTO services (title, slug, summary, full_description, image_url, sort_order)
       VALUES ($1, $2, $3, $4, $5, COALESCE($6, 0))
       RETURNING *`,
      [title, slug, summary || null, full_description || null, image_url || null, sort_order]
    );

    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error(err);
    if (err.code === "23505") {
      return res.status(409).json({ error: "A service with that slug already exists" });
    }
    res.status(500).json({ error: "Failed to create service" });
  }
};

exports.updateService = async (req, res) => {
  try {
    const { id } = req.params;
    const { title, slug, summary, full_description, image_url, sort_order } = req.body;

    const result = await pool.query(
      `UPDATE services SET
         title = COALESCE($1, title),
         slug = COALESCE($2, slug),
         summary = COALESCE($3, summary),
         full_description = COALESCE($4, full_description),
         image_url = COALESCE($5, image_url),
         sort_order = COALESCE($6, sort_order)
       WHERE id = $7
       RETURNING *`,
      [title, slug, summary, full_description, image_url, sort_order, id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Service not found" });
    }

    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to update service" });
  }
};

exports.deleteService = async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query("DELETE FROM services WHERE id = $1 RETURNING id", [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Service not found" });
    }

    res.json({ message: "Service deleted", id: result.rows[0].id });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to delete service" });
  }
};

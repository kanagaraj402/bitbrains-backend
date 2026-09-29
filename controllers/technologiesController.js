const pool = require("../config/db");

exports.getAllTechnologies = async (req, res) => {
  try {
    const result = await pool.query(
      "SELECT * FROM technologies ORDER BY sort_order ASC, id ASC"
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to fetch technologies" });
  }
};

// --- Admin-only below (mounted behind requireAuth in routes) ---

exports.createTechnology = async (req, res) => {
  try {
    const { name, icon_url, sort_order } = req.body;

    if (!name) {
      return res.status(400).json({ error: "name is required" });
    }

    const result = await pool.query(
      `INSERT INTO technologies (name, icon_url, sort_order)
       VALUES ($1, $2, COALESCE($3, 0))
       RETURNING *`,
      [name, icon_url || null, sort_order]
    );

    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to create technology" });
  }
};

exports.updateTechnology = async (req, res) => {
  try {
    const { id } = req.params;
    const { name, icon_url, sort_order } = req.body;

    const result = await pool.query(
      `UPDATE technologies SET
         name = COALESCE($1, name),
         icon_url = COALESCE($2, icon_url),
         sort_order = COALESCE($3, sort_order)
       WHERE id = $4
       RETURNING *`,
      [name, icon_url, sort_order, id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Technology not found" });
    }

    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to update technology" });
  }
};

exports.deleteTechnology = async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query("DELETE FROM technologies WHERE id = $1 RETURNING id", [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Technology not found" });
    }

    res.json({ message: "Technology deleted", id: result.rows[0].id });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to delete technology" });
  }
};

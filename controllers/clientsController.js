const pool = require("../config/db");

exports.getAllClients = async (req, res) => {
  try {
    const result = await pool.query(
      "SELECT * FROM clients ORDER BY sort_order ASC, id ASC"
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to fetch clients" });
  }
};

// --- Admin-only below (mounted behind requireAuth in routes) ---

exports.createClient = async (req, res) => {
  try {
    const { name, logo_url, website_url, sort_order } = req.body;

    if (!name) {
      return res.status(400).json({ error: "name is required" });
    }

    const result = await pool.query(
      `INSERT INTO clients (name, logo_url, website_url, sort_order)
       VALUES ($1, $2, $3, COALESCE($4, 0))
       RETURNING *`,
      [name, logo_url || null, website_url || null, sort_order]
    );

    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to create client" });
  }
};

exports.updateClient = async (req, res) => {
  try {
    const { id } = req.params;
    const { name, logo_url, website_url, sort_order } = req.body;

    const result = await pool.query(
      `UPDATE clients SET
         name = COALESCE($1, name),
         logo_url = COALESCE($2, logo_url),
         website_url = COALESCE($3, website_url),
         sort_order = COALESCE($4, sort_order)
       WHERE id = $5
       RETURNING *`,
      [name, logo_url, website_url, sort_order, id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Client not found" });
    }

    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to update client" });
  }
};

exports.deleteClient = async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query("DELETE FROM clients WHERE id = $1 RETURNING id", [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Client not found" });
    }

    res.json({ message: "Client deleted", id: result.rows[0].id });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to delete client" });
  }
};
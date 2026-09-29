const pool = require("../config/db");

exports.createContact = async (req, res) => {
  try {
    const { name, email, phone, subject, message } = req.body;

    if (!name || !email || !message) {
      return res
        .status(400)
        .json({ error: "name, email and message are required" });
    }

    const result = await pool.query(
      `INSERT INTO contacts (name, email, phone, subject, message)
       VALUES ($1, $2, $3, $4, $5)
       RETURNING id, created_at`,
      [name, email, phone || null, subject || null, message]
    );

    res.status(201).json({
      message: "Thanks! Your message has been received.",
      id: result.rows[0].id,
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to submit contact form" });
  }
};

// Admin-facing: list submissions (add auth middleware before using in prod)
exports.getAllContacts = async (req, res) => {
  try {
    const result = await pool.query(
      "SELECT * FROM contacts ORDER BY created_at DESC"
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to fetch contacts" });
  }
};

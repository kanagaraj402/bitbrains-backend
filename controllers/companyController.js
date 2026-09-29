const pool = require("../config/db");

exports.getCompanyInfo = async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM company_info WHERE id = 1");
    res.json(result.rows[0] || {});
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to fetch company info" });
  }
};

exports.updateCompanyInfo = async (req, res) => {
  try {
    const {
      company_name, tagline, phone, whatsapp, email, skype, address, about_text,
    } = req.body;

    const result = await pool.query(
      `UPDATE company_info SET
         company_name = COALESCE($1, company_name),
         tagline = COALESCE($2, tagline),
         phone = COALESCE($3, phone),
         whatsapp = COALESCE($4, whatsapp),
         email = COALESCE($5, email),
         skype = COALESCE($6, skype),
         address = COALESCE($7, address),
         about_text = COALESCE($8, about_text),
         updated_at = NOW()
       WHERE id = 1
       RETURNING *`,
      [company_name, tagline, phone, whatsapp, email, skype, address, about_text]
    );

    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to update company info" });
  }
};

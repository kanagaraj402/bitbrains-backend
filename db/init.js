// Creates all tables from schema.sql against the database in .env
// Usage: npm run db:init
const fs = require("fs");
const path = require("path");
const pool = require("../config/db");

async function init() {
  const schemaPath = path.join(__dirname, "schema.sql");
  const sql = fs.readFileSync(schemaPath, "utf8");

  try {
    await pool.query(sql);
    console.log("✅ Database schema created / verified successfully.");
  } catch (err) {
    console.error("❌ Failed to initialize database:", err.message);
    process.exitCode = 1;
  } finally {
    await pool.end();
  }
}

init();

// Creates (or updates the password of) the admin account defined in .env.
// Usage: npm run db:seed-admin
const bcrypt = require("bcryptjs");
const pool = require("../config/db");

async function seed() {
  const name = process.env.ADMIN_NAME || "BitBrains Admin";
  const email = process.env.ADMIN_EMAIL;
  const password = process.env.ADMIN_PASSWORD;

  if (!email || !password) {
    console.error("❌ Set ADMIN_EMAIL and ADMIN_PASSWORD in .env before running this.");
    process.exit(1);
  }

  try {
    const hash = await bcrypt.hash(password, 10);

    await pool.query(
      `INSERT INTO admins (name, email, password_hash)
       VALUES ($1, $2, $3)
       ON CONFLICT (email)
       DO UPDATE SET password_hash = EXCLUDED.password_hash, name = EXCLUDED.name`,
      [name, email, hash]
    );

    console.log(`✅ Admin ready. Log in with:\n   email: ${email}\n   password: (the one set in .env)`);
  } catch (err) {
    console.error("❌ Failed to seed admin:", err.message);
    process.exitCode = 1;
  } finally {
    await pool.end();
  }
}

seed();

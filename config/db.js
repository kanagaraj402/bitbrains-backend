const { Pool } = require("pg");
require("dotenv").config();

// Pool reads PGHOST/PGPORT/PGUSER/PGPASSWORD/PGDATABASE from process.env
// automatically, but we pass them explicitly for clarity.
const pool = new Pool({
  host: process.env.PGHOST,
  port: process.env.PGPORT,
  user: process.env.PGUSER,
  password: process.env.PGPASSWORD,
  database: process.env.PGDATABASE,
});

pool.on("connect", () => {
  console.log("PostgreSQL pool: new client connected");
});

pool.on("error", (err) => {
  console.error("Unexpected PostgreSQL error on idle client", err);
  process.exit(-1);
});

module.exports = pool;

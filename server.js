require("dotenv").config();
const express = require("express");
const cors = require("cors");

const authRoutes = require("./routes/authRoutes");
const servicesRoutes = require("./routes/servicesRoutes");
const productsRoutes = require("./routes/productsRoutes");
const portfolioRoutes = require("./routes/portfolioRoutes");
const technologiesRoutes = require("./routes/technologiesRoutes");
const contactRoutes = require("./routes/contactRoutes");
const companyRoutes = require("./routes/companyRoutes");
const clientsRoutes = require("./routes/clientsRoutes");
const { notFound, errorHandler } = require("./middleware/errorHandler");

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(
  cors({
    origin: process.env.CLIENT_ORIGIN || "http://localhost:5173",
  })
);
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Health check
app.get("/api/health", (req, res) => {
  res.json({ status: "ok", uptime: process.uptime() });
});

// Routes
app.use("/api/auth", authRoutes);
app.use("/api/services", servicesRoutes);
app.use("/api/products", productsRoutes);
app.use("/api/portfolio", portfolioRoutes);
app.use("/api/technologies", technologiesRoutes);
app.use("/api/contact", contactRoutes);
app.use("/api/company", companyRoutes);
app.use("/api/clients", clientsRoutes);

// 404 + error handling (keep last)
app.use(notFound);
app.use(errorHandler);

app.listen(PORT, () => {
  console.log(`🚀 BitBrains API running on http://localhost:${PORT}`);
});

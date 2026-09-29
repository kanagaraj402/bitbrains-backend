function notFound(req, res, next) {
  res.status(404).json({ error: `Route ${req.originalUrl} not found` });
}

function errorHandler(err, req, res, next) {
  console.error(err.stack);
  res.status(err.status || 500).json({
    error: err.message || "Internal server error",
  });
}

module.exports = { notFound, errorHandler };

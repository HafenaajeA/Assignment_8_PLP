/**
 * Library Management System API
 * This file implements a RESTful API for managing library books using Express and MySQL
 */

require("dotenv").config();
const express = require("express");
const mysql = require("mysql2");
const app = express();

// Middleware to parse JSON bodies
app.use(express.json());

// Database connection configuration
const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE,
});

/**
 * Create a new book
 * POST /books
 * Request body: { title, author_id, category_id, isbn }
 * Response: { id: number } or { error: string }
 */
app.post("/books", (req, res) => {
  const { title, author_id, category_id, isbn } = req.body;
  db.query(
    "INSERT INTO books (title, author_id, category_id, isbn) VALUES (?, ?, ?, ?)",
    [title, author_id, category_id, isbn],
    (err, result) => {
      if (err) res.status(500).json({ error: err.message });
      else res.status(201).json({ id: result.insertId });
    }
  );
});

/**
 * Retrieve all books
 * GET /books
 * Response: Array of books or { error: string }
 */
app.get("/books", (req, res) => {
  db.query("SELECT * FROM books", (err, results) => {
    if (err) res.status(500).json({ error: err.message });
    else res.json(results);
  });
});

/**
 * Update an existing book
 * PUT /books/:id
 * Request body: { title, author_id, category_id, isbn }
 * Response: { message: string } or { error: string }
 */
app.put("/books/:id", (req, res) => {
  const { title, author_id, category_id, isbn } = req.body;
  db.query(
    "UPDATE books SET title=?, author_id=?, category_id=?, isbn=? WHERE book_id=?",
    [title, author_id, category_id, isbn, req.params.id],
    (err) => {
      if (err) res.status(500).json({ error: err.message });
      else res.json({ message: "Updated successfully" });
    }
  );
});

/**
 * Delete a book
 * DELETE /books/:id
 * Response: { message: string } or { error: string }
 */
app.delete("/books/:id", (req, res) => {
  db.query("DELETE FROM books WHERE book_id=?", [req.params.id], (err) => {
    if (err) res.status(500).json({ error: err.message });
    else res.json({ message: "Deleted successfully" });
  });
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));

# Library Management System

A full-featured Library Management System with MySQL database and Node.js REST API.

## Description

This project implements a complete Library Management System with:

- MySQL Database for data storage
- RESTful API using Node.js and Express
- CRUD operations for books management
- Relational database design with tables for:
  - Books
  - Authors
  - Categories
  - Members
  - Loans

## Setup Instructions

### 1. Database Setup

1. Make sure you have MySQL installed
2. Open MySQL command line or workbench
3. Run the SQL script:

```sql
source path/to/library_schema.sql
```

### 2. API Setup

1. Navigate to the project directory:

```bash
cd database_api
```

2. Install dependencies:

```bash
npm install
```

3. Update database connection in `app.js`:

```javascript
const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "your_password",
  database: "library_management",
});
```

4. Start the server:

```bash
node app.js
```

The server will start on port 3000.

## API Endpoints

- **POST /books** - Create a new book
- **GET /books** - Get all books
- **PUT /books/:id** - Update a book
- **DELETE /books/:id** - Delete a book

## Example Request

Create a new book:

```bash
curl -X POST http://localhost:3000/books \
-H "Content-Type: application/json" \
-d '{
    "title": "New Book",
    "author_id": 1,
    "category_id": 1,
    "isbn": "1234567890123"
}'
```

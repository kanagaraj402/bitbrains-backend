# BitBrains Backend (Express + PostgreSQL + Admin Auth)

Complete setup, start to finish.

## 1. Install dependencies

```bash
cd bitbrains-backend
npm install
```

This installs `express`, `cors`, `dotenv`, `pg`, `bcryptjs`, `jsonwebtoken`.
For auto-restart on file changes during development:
```bash
npm install --save-dev nodemon
```

## 2. Set up PostgreSQL

Make sure PostgreSQL is installed and running locally (or use a hosted instance like Supabase, Render, or Neon).

```bash
createdb bitbrains
```

## 3. Configure environment variables

```bash
cp .env.example .env
```

Open `.env` and set:
- Your real Postgres credentials (`PGUSER`, `PGPASSWORD`, etc.)
- `JWT_SECRET` — any long random string (e.g. run `openssl rand -hex 32` and paste the output)
- `ADMIN_EMAIL` / `ADMIN_PASSWORD` — the login you want for the admin panel. **Change the password to something real before seeding.**

## 4. Create the tables

```bash
npm run db:init
```
Creates `admins`, `services`, `products`, `portfolio`, `contacts`, `company_info`, and seeds a few starter services/products/portfolio rows plus the default company info row.

## 5. Create the admin login

```bash
npm run db:seed-admin
```
Creates (or resets the password of) the admin account using `ADMIN_EMAIL` / `ADMIN_PASSWORD` from `.env`. This is the **only** account that can add/edit/delete services, products, portfolio items, and company info — there is no public signup.

You can re-run this command any time to reset the admin password: just change `ADMIN_PASSWORD` in `.env` first.

## 6. Run the server

```bash
npm run dev     # with nodemon (auto-restart)
# or
npm start
```

Server runs at `http://localhost:5000`.

## 7. Log in

From the frontend, go to `/admin/login` and sign in with the email/password from `.env`. This returns a JWT that the frontend stores and sends as `Authorization: Bearer <token>` on every admin request.

---

## API Reference

### Public (no login required)
| Method | Endpoint | Description |
|--------|-----------|-------------|
| GET | /api/health | Health check |
| GET | /api/services | List all services |
| GET | /api/services/:slug | Get one service |
| GET | /api/products | List all products |
| GET | /api/products/:slug | Get one product |
| GET | /api/portfolio | List all portfolio items |
| GET | /api/portfolio/:slug | Get one portfolio item |
| POST | /api/contact | Submit contact form |
| GET | /api/company | Get company info (phone, address, tagline, etc.) |

### Auth
| Method | Endpoint | Description |
|--------|-----------|-------------|
| POST | /api/auth/login | `{ email, password }` → `{ token, admin }` |
| GET | /api/auth/me | Verify a token is still valid (send `Authorization: Bearer <token>`) |

### Admin-only (requires `Authorization: Bearer <token>`)
| Method | Endpoint | Body |
|--------|-----------|------|
| POST | /api/services | `{ title, slug, summary, full_description, image_url, sort_order }` |
| PUT | /api/services/:id | any of the above fields |
| DELETE | /api/services/:id | — |
| POST | /api/products | `{ name, slug, description, icon_url, sort_order }` |
| PUT | /api/products/:id | any of the above fields |
| DELETE | /api/products/:id | — |
| POST | /api/portfolio | `{ title, slug, client_name, description, image_url, project_url, sort_order }` |
| PUT | /api/portfolio/:id | any of the above fields |
| DELETE | /api/portfolio/:id | — |
| PUT | /api/company | `{ company_name, tagline, phone, whatsapp, email, skype, address, about_text }` |
| GET | /api/contact | List contact form submissions |

## Folder structure
```
bitbrains-backend/
├── config/db.js              # PostgreSQL connection pool
├── controllers/               # Route logic (auth, services, products, portfolio, company, contact)
├── routes/                    # Express routers (public + admin-protected)
├── middleware/
│   ├── auth.js                 # requireAuth — verifies JWT
│   └── errorHandler.js
├── db/
│   ├── schema.sql              # Table definitions + seed data
│   ├── init.js                 # Runs schema.sql
│   └── seedAdmin.js            # Creates/resets the admin login
├── .env.example
└── server.js
```

## Frontend connection
In your React project's `.env`:
```
VITE_API_URL=http://localhost:5000/api
```

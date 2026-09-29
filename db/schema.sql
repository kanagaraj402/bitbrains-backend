-- Run this once against your bitbrains database
-- psql -U postgres -d bitbrains -f db/schema.sql

CREATE TABLE IF NOT EXISTS admins (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS services (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(150) UNIQUE NOT NULL,
    summary TEXT,                    -- short blurb shown on the card
    full_description TEXT,           -- longer copy shown on the detail page
    image_url VARCHAR(255),
    sort_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    slug VARCHAR(150) UNIQUE NOT NULL,
    description TEXT,
    icon_url VARCHAR(255),
    sort_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS portfolio (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(150) UNIQUE NOT NULL,
    client_name VARCHAR(150),
    description TEXT,
    image_url VARCHAR(255),
    project_url VARCHAR(255),
    sort_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS technologies (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    icon_url VARCHAR(255),
    sort_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS contacts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone VARCHAR(30),
    subject VARCHAR(200),
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Single-row table holding site-wide info (phone, address, tagline, etc.)
-- so it can be edited from the admin panel instead of hardcoded in React.
CREATE TABLE IF NOT EXISTS company_info (
    id INT PRIMARY KEY DEFAULT 1,
    company_name VARCHAR(150) DEFAULT 'BitBrains Technology',
    tagline VARCHAR(255) DEFAULT 'We engineer IT to perfection.',
    phone VARCHAR(30) DEFAULT '+91 90030 87970',
    whatsapp VARCHAR(30) DEFAULT '+91 90030 87970',
    email VARCHAR(150) DEFAULT 'admin@bitbrainstech.com',
    skype VARCHAR(100) DEFAULT 'bitbrainstech',
    address TEXT DEFAULT 'BitBrains Technology, Block 2, Rathinam Tech Zone, Eachanari, Coimbatore, Tamil Nadu, India 641021.',
    about_text TEXT DEFAULT 'We are a leading professional team of skilled developers and architects with a common vision to achieve customer satisfaction.',
    updated_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT single_row CHECK (id = 1)
);

INSERT INTO company_info (id) VALUES (1) ON CONFLICT (id) DO NOTHING;

-- Starter data so the site isn't empty on first run.
-- Edit or delete these from the admin panel once it's running.
INSERT INTO services (title, slug, summary, full_description, image_url, sort_order) VALUES
 ('Mobile Apps Development', 'mobile-apps', 'We build native and hybrid mobile apps for iOS, Android and Windows platforms.', 'We build native and hybrid mobile apps for iOS, Android and Windows platforms, using the latest tools and standards to deliver a unique user experience.', '/images/services/mobile-apps.jpg', 1),
 ('Web Applications Development', 'web-applications', 'From simple websites to complex, multi-functional e-commerce and web portals.', 'Professional design and development for everything from simple websites to complex, multi-functional e-commerce and web portals, built with current technologies.', '/images/services/web-applications.jpg', 2),
 ('ERP Development', 'erp-development', 'End-to-end ERP solutions for any sector.', 'We develop ERP business applications that give organizations an optimized, end-to-end solution for any sector, from design through implementation. We specialize in Odoo.', '/images/services/erp-development.jpg', 3),
 ('Corporate Trainings', 'corporate-trainings', 'Technology training programs for corporates and institutions.', 'Exhaustive technology training programs for corporates and educational institutions, led by experienced industry experts across development, deployment, and troubleshooting.', NULL, 4)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO products (name, slug, description, icon_url, sort_order) VALUES
 ('Customer Relationship Management', 'crm', 'Track leads, follow-ups, deals, and customer history in one place.', '/images/products/crm.png', 1),
 ('Ecommerce Portal', 'ecommerce', 'A full online storefront with catalog, cart, checkout, and payments.', '/images/products/ecommerce.png', 2),
 ('Education Management', 'education', 'Admissions, student records, fee tracking, and academic scheduling.', '/images/products/education.png', 3),
 ('Employee Attendance Application', 'attendance', 'Biometric, geo-tagged, or QR-based attendance tracking.', '/images/products/attendance.png', 4),
 ('HR Management', 'hr', 'Employee records, leave management, and performance tracking.', '/images/products/hr.png', 5),
 ('Sales, Purchase & Inventory Management', 'erp', 'An Odoo-based ERP covering sales, purchase, and inventory.', '/images/products/erp.png', 6),
 ('Vehicles / Fleet Management', 'vehicles', 'Track vehicle usage, maintenance, fuel logs, and drivers.', '/images/products/vehicles.png', 7)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO portfolio (title, slug, client_name, description, image_url, sort_order) VALUES
 ('Cottage Accommodation Portal', 'cottage-accommodation-portal', 'Isha Foundation', 'An end-to-end solution managing over 300 rooms across 10 blocks.', '/images/portfolio/cottage-accommodation-portal.jpg', 1),
 ('College Management System', 'college-management-system', 'Rathinam Institutions', 'A highly efficient CMS to streamline enquiries and admissions.', '/images/portfolio/college-management-system.jpg', 2),
 ('Data Aggregate Automation', 'data-aggregate-automation', 'VNP Solutions, Canada', 'Aggregated payments data cluttered across multiple platforms.', '/images/portfolio/data-aggregate-automation.jpg', 3)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO technologies (name, icon_url, sort_order) VALUES
 ('Angular', '/images/technologies/angular.png', 1),
 ('MySQL', '/images/technologies/mysql.png', 2),
 ('Node.js', '/images/technologies/nodejs.png', 3),
 ('Odoo', '/images/technologies/odoo.png', 4),
 ('PostgreSQL', '/images/technologies/postgres.png', 5),
 ('Python', '/images/technologies/python.png', 6),
 ('React', '/images/technologies/react.png', 7)
ON CONFLICT DO NOTHING;

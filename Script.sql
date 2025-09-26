-- Таблица ролей
CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

-- Таблица пользователей
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    full_name TEXT NOT NULL,
    role_id INT NOT NULL REFERENCES roles(id) ON DELETE RESTRICT,
    is_active BOOLEAN DEFAULT TRUE
);

-- Таблица магазинов
CREATE TABLE stores (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    tax_id TEXT NOT NULL UNIQUE,
    manager_id INT NOT NULL UNIQUE REFERENCES users(id) ON DELETE RESTRICT
);

-- Таблица счетов магазинов (1:1 со store)
CREATE TABLE store_accounts (
    id SERIAL PRIMARY KEY,
    balance DECIMAL(15,2) DEFAULT 0.0 CHECK (balance >= 0),
    store_id INT NOT NULL UNIQUE REFERENCES stores(id) ON DELETE CASCADE
);

-- Таблица категорий товаров
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

-- Таблица товаров
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    price DECIMAL(12,2) NOT NULL CHECK (price >= 0),
    quantity_in_stock INT DEFAULT 0 CHECK (quantity_in_stock >= 0),
    category_id INT NOT NULL REFERENCES categories(id) ON DELETE RESTRICT
);

-- Таблица заказов
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    store_id INT NOT NULL REFERENCES stores(id) ON DELETE CASCADE,
    total_amount DECIMAL(12,2) NOT NULL CHECK (total_amount >= 0),
    created_at TIMESTAMP DEFAULT now()
);

-- Таблица позиций заказа
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id INT NOT NULL REFERENCES products(id) ON DELETE RESTRICT,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(12,2) NOT NULL CHECK (unit_price >= 0)
);

-- Таблица счета компании
CREATE TABLE company_accounts (
    id SERIAL PRIMARY KEY,
    balance DECIMAL(15,2) DEFAULT 0.0 CHECK (balance >= 0)
);

-- Таблица транзакций
CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    store_account_id INT NOT NULL REFERENCES store_accounts(id) ON DELETE CASCADE,
    company_account_id INT NOT NULL REFERENCES company_accounts(id) ON DELETE CASCADE,
    amount DECIMAL(15,2) NOT NULL CHECK (amount <> 0)
);

-- Таблица журнала аудита
CREATE TABLE audit_log (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE SET NULL,
    details TEXT,
    performed_at TIMESTAMP DEFAULT now()
);

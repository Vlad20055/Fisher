-- 1. РАБОТА С ПОЛЬЗОВАТЕЛЯМИ
-- ===========================================
-- Проверка логина и пароля
SELECT id, username, full_name, role_id, is_active 
FROM users 
WHERE username = 'stas2006' 
AND password_hash = crypt('stas2006', password_hash);

-- Получение роли пользователя
SELECT u.username, u.full_name, r.name as role_name
FROM users u
JOIN roles r ON u.role_id = r.id
WHERE u.username = 'stas2006';

-- Деактивировать пользователя
UPDATE users SET is_active = false WHERE username = 'stas2006';

-- Активировать пользователя
UPDATE users SET is_active = true WHERE username = 'stas2006';


-- 2. РАБОТА С ТОВАРАМИ
-- ===========================================
-- Получить все товары с категориями
SELECT p.id, p.name, p.description, p.price, p.quantity_in_stock, c.name as category
FROM products p
JOIN categories c ON p.category_id = c.id
ORDER BY p.price DESC;

-- Товары определенной категории
SELECT p.name, p.price, p.quantity_in_stock
FROM products p
JOIN categories c ON p.category_id = c.id
WHERE c.name = 'Спиннинги';

-- Поиск товаров по названию
SELECT name, price, quantity_in_stock
FROM products 
WHERE name ILIKE '%shimano%';

--Товары с низким запасом (меньше 500)
select name, quantity_in_stock
from products
where quantity_in_stock < 500
order by quantity_in_stock asc

-- Обновить количество товара
UPDATE products SET quantity_in_stock = quantity_in_stock - 5 WHERE id = 1;


-- 3. ЗАКАЗЫ И ПРОДАЖИ
-- ===========================================
-- Все заказы магазина
SELECT o.id, o.total_amount, o.created_at, s.name as store_name
FROM orders o
JOIN stores s ON o.store_id = s.id
WHERE s.name = 'Крючок и пуля';

-- Детали заказа с товарами
SELECT o.id as order_id, p.name as product_name, oi.quantity, oi.unit_price
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE o.id = 1;

-- Сумма заказов по всем магазинам
SELECT s.name as store_name, COUNT(o.id) as order_count, SUM(o.total_amount) as total_sales
FROM stores s
LEFT JOIN orders o ON s.id = o.store_id
GROUP BY s.id, s.name
ORDER BY total_sales DESC;


-- 4. РАБОТА С ФИНАНСАМИ
-- ===========================================
-- Балансы всех счетов
SELECT s.name as store_name, sa.balance as store_balance, ca.balance as company_balance
FROM stores s
JOIN store_accounts sa ON s.id = sa.store_id
CROSS JOIN company_accounts ca;

-- Все транзакции
SELECT t.id, s.name as store, t.amount, t.store_account_id
FROM transactions t
JOIN store_accounts sa ON t.store_account_id = sa.id
JOIN stores s ON sa.store_id = s.id
ORDER BY t.id DESC;


-- 5. ОТЧЕТЫ И АНАЛИТИКА
-- ===========================================
-- Самые популярные товары (в смысле те, которых заказали больше всего штук по всем заказам)
SELECT p.name, SUM(oi.quantity) as total_sold, SUM(oi.quantity * oi.unit_price) as total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.id
GROUP BY p.id, p.name
ORDER BY total_sold DESC
LIMIT 10;

-- Продажи по месяцам
SELECT 
    DATE_TRUNC('month', o.created_at) as month,
    COUNT(o.id) as orders_count,
    SUM(o.total_amount) as total_amount
FROM orders o
GROUP BY DATE_TRUNC('month', o.created_at)
ORDER BY month DESC;


-- 6. АУДИТ И ЛОГИ
-- ===========================================
-- Последние действия пользователей
SELECT u.username, al.details, al.performed_at
FROM audit_log al
LEFT JOIN users u ON al.user_id = u.id
ORDER BY al.performed_at DESC
LIMIT 20;

-- Действия конкретного пользователя
SELECT details, performed_at
FROM audit_log
WHERE user_id = (SELECT id FROM users WHERE username = 'stas2006')
ORDER BY performed_at DESC;


-- 7. УПРАВЛЕНИЕ МАГАЗИНАМИ
-- ===========================================
-- Информация о магазине и его менеджере
SELECT s.name as store_name, s.address, s.tax_id, u.full_name as manager_name
FROM stores s
JOIN users u ON s.manager_id = u.id;

-- Магазины с их балансами
SELECT s.name, sa.balance, u.username as manager
FROM stores s
JOIN store_accounts sa ON s.id = sa.store_id
JOIN users u ON s.manager_id = u.id;



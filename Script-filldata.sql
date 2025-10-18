-- roles
INSERT INTO roles (name) VALUES 
('admin'),              -- Администратор компании
('company_manager'),    -- Менеджер компании  
('store_manager');      -- Менеджер магазина

CREATE EXTENSION IF NOT EXISTS pgcrypto;

INSERT INTO users (username, password_hash, full_name, role_id, is_active) VALUES 
('vlad20055', crypt('vlad20055', gen_salt('bf')), 'Владислав', 1, true),
('demjan2006', crypt('demjan2006', gen_salt('bf')), 'Демьян', 2, true),
('stas2006', crypt('stas2006', gen_salt('bf')), 'Станислав', 3, true);

INSERT INTO users (username, password_hash, full_name, role_id, is_active) VALUES 
('anton2005', crypt('anton2006', gen_salt('bf')), 'Антон', 2, true),
('andrew2005', crypt('andrew2006', gen_salt('bf')), 'Андрей', 2, true),
('denis2005', crypt('denis2006', gen_salt('bf')), 'Денис', 2, true),
('dima2005', crypt('dima2005', gen_salt('bf')), 'Дмитрий', 3, true),
('kirill2005', crypt('kirill2005', gen_salt('bf')), 'Кирилл', 3, true);


INSERT INTO stores (name, address, tax_id, manager_id) VALUES 
('Крючок и пуля', 'Беларусь, г. Лепель, ул. Лепельская, д. 1', '123456789012', 3),
('Блесна', 'Беларусь, г. Витебск, пр. Строителей, д. 1', '123456789013', 8),
('КлёвоТут', 'Беларусь, г. Витебск, пр. Московский, д. 1', '123456789014', 9);


-- Вставляем счета магазинов
INSERT INTO store_accounts (balance, store_id) VALUES 
(150000.00, 1),
(200000.50, 2), 
(175000.75, 3);

-- Вставляем категории рыболовных товаров
INSERT INTO categories (name) VALUES 
('Спиннинги'),
('Фидерные удилища'),
('Поплавочные удилища'),
('Катушки безынерционные'),
('Катушки мультипликаторные'),
('Лески монофильные'),
('Плетеные шнуры'),
('Крючки'),
('Грузила и дробинки'),
('Поплавки'),
('Воблеры'),
('Блесны'),
('Силиконовые приманки'),
('Эхолоты'),
('Подсачеки и садки'),
('Рыболовные ящики');


-- Вставляем товары
INSERT INTO products (name, description, price, quantity_in_stock, category_id) VALUES 
-- Спиннинги
('Shimano Catana 240', 'Спиннинг 2.4м, тест 10-30г', 1250.00, 150, 1),
('Daiwa Ninja 270', 'Спиннинг 2.7м, тест 5-25г', 1830.00, 80, 1),
('Salmo Elite 210', 'Спиннинг 2.1м, тест 7-28г', 960.00, 200, 1),

-- Фидерные удилища
('Mikado Fider 360', 'Фидер 3.6м, тест 120г', 1420.00, 102, 2),
('Flagman Hunter 390', 'Фидер 3.9м, тест 150г', 1780.00, 60, 2),

-- Поплавочные удилища
('Salmo Diamond 500', 'Мачтовое удилище 5м', 850.00, 205, 3),
('Traper Okuma 450', 'Болонское удилище 4.5м', 720.00, 180, 3),

-- Безынерционные катушки
('Shimano Nexave 4000', 'Катушка 4000, 5+1 подшипников', 1560.00, 100, 4),
('Daiwa Regal 2500', 'Катушка 2500, 3+1 подшипников', 1320.00, 150, 4),

-- Мультипликаторные катушки
('Abu Garcia Ambassadeur', 'Мультипликаторная катушка', 2450.00, 50, 5),

-- Лески монофильные
('Salmo Specialist 0.25', 'Монофильная леска 0.25мм, 100м', 85.00, 500, 6),
('Berkley Trilene 0.30', 'Монофильная леска 0.30мм, 100м', 120.00, 400, 6),

-- Плетеные шнуры
('Power Pro 0.12', 'Плетеный шнур 0.12мм, 150м', 38.00, 200, 7),
('Sufix 832 0.10', 'Плетеный шнур 0.10мм, 135м', 42.00, 150, 7),

-- Крючки
('Owner 53101 №6', 'Крючки карповые №6, 10шт', 40.00, 100, 8),
('Gamakatsu LS-2210 №8', 'Крючки с длинным цевьем №8, 10шт', 52.00, 800, 8),

-- Воблеры
('Rapala CountDown 7см', 'Воблер плавающий, 7см, 7г', 125.00, 300, 11),
('Jackall Chubby 5см', 'Воблер тонущий, 5см, 5г', 98.00, 250, 11),

-- Блесны
('Mepps Aglia Long №2', 'Вращающаяся блесна №2', 65.00, 400, 12),
('Blue Fox Vibrax №3', 'Вращающаяся блесна №3', 72.00, 350, 12),

-- Силиконовые приманки
('Bait Breath Micro 2"', 'Силиконовый твистер 2", 10шт', 89.00, 600, 13),
('Keitech Swing Impact 3"', 'Силиконовая приманка 3", 5шт', 112.00, 450, 13),

-- Эхолоты
('Lowrance Hook2 4x', 'Эхолот 4.3" GPS', 2890.00, 300, 14),
('Garmin Striker 4', 'Эхолот 4.3" с GPS', 3250.00, 200, 14);


-- Вставляем заказы
INSERT INTO orders (store_id, total_amount, created_at) VALUES 
-- Заказы от "Крючок и пуля" (Стас)
(1, 6780.00, '2024-01-15 10:30:00'),
(1, 2890.00, '2024-01-20 14:15:00'),

-- Заказы от "Блесна" (Дима)  
(2, 7130.00, '2024-01-18 11:20:00'),
(2, 1560.00, '2024-01-22 09:45:00'),

-- Заказы от "КлёвоТут" (Кирилл)
(3, 4515.00, '2024-01-16 16:30:00'),
(3, 2450.00, '2024-01-21 13:10:00');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES 
-- Заказ 1: Крючок и пуля
(1, 1, 2, 1250.00),  -- 2 спиннинга Shimano
(1, 8, 2, 1560.00),  -- 2 катушки Shimano
(1, 15, 29, 40.00);  -- 20 упаковок крючков

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES 
-- Заказ 2: Крючок и пуля (эхолот)
(2, 23, 1, 2890.00); -- 1 эхолот Lowrance

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES 
-- Заказ 3: Блесна
(3, 2, 2, 1830.00),   -- 3660.00
(3, 9, 1, 1320.00),   -- 1320.00
(3, 11, 10, 85.00),   -- 850.00
(3, 19, 20, 65.00);   -- 1300.00

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES 
-- Заказ 4: Блесна
(4, 8, 1, 1560.00);   -- 1560.00

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES 
-- Заказ 5: КлёвоТут
(5, 4, 2, 1420.00),   -- 2840.00
(5, 11, 5, 85.00),    -- 425.00
(5, 17, 10, 125.00);  -- 1250.00
-- Итого: 4515.00 

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES 
-- Заказ 6: КлёвоТут
(6, 10, 1, 2450.00);  -- 2450.00

insert into company_accounts (balance) values
(1000000.00)

-- Вставляем транзакции с новыми суммами
INSERT INTO transactions (store_account_id, company_account_id, amount) VALUES 
(1, 1, 6780.00),  -- Оплата заказа 1
(1, 1, 2890.00),  -- Оплата заказа 2
(2, 1, 7130.00),  -- Оплата заказа 3  
(2, 1, 1560.00),  -- Оплата заказа 4
(3, 1, 4515.00),  -- Оплата заказа 5
(3, 1, 2450.00);  -- Оплата заказа 6

-- Логи для создания заказов
INSERT INTO audit_log (user_id, details, performed_at) VALUES 
(3, 'Создан заказ №1 для магазина "Крючок и пуля" на сумму 6780.00 руб', '2024-01-15 10:30:00'),
(3, 'Создан заказ №2 для магазина "Крючок и пуля" на сумму 2890.00 руб', '2024-01-20 14:15:00'),
(8, 'Создан заказ №3 для магазина "Блесна" на сумму 7130.00 руб', '2024-01-18 11:20:00'),
(8, 'Создан заказ №4 для магазина "Блесна" на сумму 1560.00 руб', '2024-01-22 09:45:00'),
(9, 'Создан заказ №5 для магазина "КлёвоТут" на сумму 4515.00 руб', '2024-01-16 16:30:00'),
(9, 'Создан заказ №6 для магазина "КлёвоТут" на сумму 2450.00 руб', '2024-01-21 13:10:00');

-- Логи для финансовых операций
INSERT INTO audit_log (user_id, details, performed_at) VALUES 
(1, 'Проведена транзакция №1: магазин "Крючок и пуля" → компания, сумма 6780.00 руб', '2024-01-15 10:35:00'),
(1, 'Проведена транзакция №2: магазин "Крючок и пуля" → компания, сумма 2890.00 руб', '2024-01-20 14:20:00'),
(1, 'Проведена транзакция №3: магазин "Блесна" → компания, сумма 7130.00 руб', '2024-01-18 11:25:00'),
(1, 'Проведена транзакция №4: магазин "Блесна" → компания, сумма 1560.00 руб', '2024-01-22 09:50:00'),
(1, 'Проведена транзакция №5: магазин "КлёвоТут" → компания, сумма 4515.00 руб', '2024-01-16 16:35:00'),
(1, 'Проведена транзакция №6: магазин "КлёвоТут" → компания, сумма 2450.00 руб', '2024-01-21 13:15:00');
 

ALTER TABLE users ALTER COLUMN id SET DEFAULT uuid_generate_v4();
ALTER TABLE roles ALTER COLUMN id SET DEFAULT uuid_generate_v4();
ALTER TABLE stores ALTER COLUMN id SET DEFAULT uuid_generate_v4();
ALTER TABLE store_accounts ALTER COLUMN id SET DEFAULT uuid_generate_v4();
ALTER TABLE categories ALTER COLUMN id SET DEFAULT uuid_generate_v4();
ALTER TABLE products ALTER COLUMN id SET DEFAULT uuid_generate_v4();
ALTER TABLE orders ALTER COLUMN id SET DEFAULT uuid_generate_v4();
ALTER TABLE order_items ALTER COLUMN id SET DEFAULT uuid_generate_v4();
ALTER TABLE company_accounts ALTER COLUMN id SET DEFAULT uuid_generate_v4();
ALTER TABLE transactions ALTER COLUMN id SET DEFAULT uuid_generate_v4();
ALTER TABLE audit_log ALTER COLUMN id SET DEFAULT uuid_generate_v4();




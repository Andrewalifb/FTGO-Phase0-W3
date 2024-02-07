-- Membuat database jika belum ada dengan nama toko_super
CREATE DATABASE IF NOT EXISTS toko_super --D

-- Membuat table jika belum ada dengan nama users
CREATE TABLE IF NOT EXISTS users ( --D
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(10) NOT NULL,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50) DEFAULT 'customer' CHECK (role IN ('admin', 'customer')),
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL
);

-- Membuat table jika belum ada dengan nama products
CREATE TABLE IF NOT EXISTS products ( --D
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_code VARCHAR(100) NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    product_category VARCHAR(10) DEFAULT 'kulit' CHECK (product_category IN ('kulit', 'suede', 'satin', 'cotton')),
    size VARCHAR(10) DEFAULT 'small' CHECK (size IN ('small', 'medium', 'large')),
    price INT NOT NULL
);

-- Membuat table jika belum ada dengan nama orders
CREATE TABLE IF NOT EXISTS orders ( --D
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_number INT NOT NULL,
    customer INT NOT NULL,
    product_code INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    product_category VARCHAR(10) NOT NULL,
    size VARCHAR(10) NOT NULL,
    price INT NOT NULL,
    qty INT NOT NULL,
    sub_total INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer) REFERENCES users(id),
    FOREIGN KEY (product_code) REFERENCES products(id)
);

-- Membuat table jika belum ada dengan nama transactions
CREATE TABLE IF NOT EXISTS transactions ( --D
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_number INT NOT NULL,
    customer INT NOT NULL,
    product_code VARCHAR(10) NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    product_category VARCHAR(10) NOT NULL,
    size VARCHAR(10) NOT NULL,
    price INT NOT NULL,
    qty INT NOT NULL,
    sub_total INT NOT NULL,
    order_date DATE NOT NULL,
    approved_by INT NOT NULL,
    approved_at DATE NOT NULL,
    FOREIGN KEY (approved_by) REFERENCES users(id)
);

-- Log in user untuk validasi akses role admin dan customer
DECLARE @username NVARCHAR(50) = 'sarah01';
DECLARE @password NVARCHAR(50) = '12345';

-- validasi user
IF EXISTS (SELECT 1 FROM users WHERE username = @username AND password = @password)
BEGIN
    -- get username
    DECLARE @userId INT;
    SELECT @userId = id FROM users WHERE username = @username;

    -- get user role
    DECLARE @userRole NVARCHAR(20);
    SELECT @userRole = role FROM roles WHERE id = @userId;
    -- jika sttaus user admin
    IF @userRole = 'admin'
    BEGIN
        PRINT 'Welcome, Admin!';
        -- Insert Users
        -- Memasukkan multiple data ke tabel users
        INSERT INTO users (username, password, name, role, phone, email, address) --D
        VALUES
            ('sarah01', '12345', 'Sarah Suhendi', 'admin', '087656734353', 'sarah@gmail.com', 'Jl. Merdeka 1'),
            ('widya02', '678910', 'Widya Monika', 'customer', '0874643278904', 'widya@gmail.com', 'Jl. Angsa 8');

        -- Example: Insert a new product
        -- Memasukkan multiple data ke tabel products
       INSERT INTO products (product_code, product_name, product_category, size, price) --D
       VALUES 
        ('001', 'tas A', 'kulit', 'medium', 150000),
        ('002', 'tas B', 'suede', 'small', 130000),
        ('003', 'tas C', 'satin', 'large', 170000),
        ('004', 'tas D', 'cotton', 'medium', 200000);
        -- Example: Update product details
        UPDATE products --D
        SET price = 165000 --ganti
        WHERE id = 2; --ganti

        -- Example: Delete a product
        DELETE FROM products WHERE id = 1; --ganti

        -- APPROVE ORDER
        INSERT INTO transactions (order_number, customer, product_code, product_name, product_category, size, price, qty, sub_total, order_date, approved_by, approved_at) --D
        SELECT
            1001, -- nomor order
            customer,
            product_code,
            product_name,
            product_category,
            size,
            price,
            qty,
            sub_total,
            order_date,
            1, -- id admin approval
            CURDATE()
        FROM orders;
        -- Delete order where order_number setelah dipindahkan ke tabel transaksi / sudah approval
        DELETE FROM orders WHERE order_number = 1001; --D
    END
    -- jika status user customer
    ELSE IF @userRole = 'customer'
    BEGIN
        PRINT 'Welcome, Customer!';
        -- Customers have restricted access
        -- Example: View product details
        SELECT * FROM products -- menampikan seluruh product
        -- atau
        SELECT * --D -- menampilkan product berdasarkan kode product
        FROM products
        WHERE product_code = 'TS01'; --ganti
        -- Example: Place an order
        INSERT INTO orders (order_number, customer, product_code, product_name, product_category, size, price, qty, sub_total, order_date) --D
        SELECT
            1002, -- order number
            2,    -- customer id
            p.id AS product_code,
            p.product_name,
            p.product_category,
            p.size,
            p.price,
            1, -- qty
            1 * p.price AS sub_total,
            CURDATE()
        FROM products p
        WHERE p.product_code IN ('004'); --ganti kode produk


    END
    ELSE
    -- jika role customer ingin melakukan commandi di luar akses yang diberikan
    BEGIN
        PRINT 'Invalid role. Please contact support.';
    END
END
ELSE
-- jika user tidak tersedia / salah memasukkan username dan password
BEGIN
    PRINT 'Invalid credentials. Please try again.';
END

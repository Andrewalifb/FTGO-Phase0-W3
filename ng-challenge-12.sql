
-- Membuat database jika belum ada dengan nama tourism
CREATE DATABASE IF NOT EXISTS tourism

-- Membuat table jika belum ada dengan nama destinations
CREATE TABLE IF NOT EXISTS destinations (
    id_destination INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    description VARCHAR(500) NOT NULL,
    rating INT NOT NULL
);

-- Membuat table jika belum ada dengan nama hotels
CREATE TABLE IF NOT EXISTS hotels (
    id_hotel INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    destination INT NOT NULL,
    rating INT NOT NULL,
    address VARCHAR(500) NOT NULL,
    FOREIGN KEY (destination) REFERENCES destinations(id_destination)
);

-- Membuat table jika belum ada dengan nama bookings
CREATE TABLE IF NOT EXISTS bookings (
    id_booking INT AUTO_INCREMENT PRIMARY KEY,
    guest VARCHAR(100) NOT NULL,
    hotel INT NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    FOREIGN KEY (hotel) REFERENCES hotels(id_hotel)
);

-- Memasukkan multiple data ke tabel destinations
INSERT INTO destinations (name, country, description, rating)
VALUES ('Gili Trawangan', 'Lombok Utara', 'Biggest Gili Island', 9),
('Senggigi', 'Lombok Barat', 'Good place for holiday', 7),
('Mandalika', 'Lombok Tengah', 'International Moto GP Circuit', 9);

-- Memasukkan multiple data ke tabel address
INSERT INTO hotels (name, destination, rating, address)
VALUES ('Villa Ombak', 1, 8, 'Gili Trawangan, Lombok Utara, NTB'),
 ('Katamaran Hotel & Resort', 2, 7, 'Batu Layar, Lombok Barat, NTB'),
 ('Novotel Lombok Resort', 3, 8, 'Mandalika, Lombok Tengah, NTB');

-- Memasukkan multiple data ke tabel bookings
INSERT INTO bookings (guest, hotel, check_in, check_out)
VALUES ('Amar', 2, '2024-02-05', '2024-02-07'),
 ('Peter', 1, '2024-02-04', '2024-02-06'),
 ('Diana', 3, '2024-02-06', '2024-02-10');

-- Menampilkan seluruh data pada tabel destinations
SELECT * FROM destinations;

-- Menampilkan seluruh data pada tabel hotels
SELECT * FROM hotels;

-- Menampilkan seluruh data pada tabel bookings
SELECT * FROM bookings;

-- Mencari data pada tabel hotels dengan foreign key sebagai parameter
SELECT * FROM hotels WHERE destination = 1

-- Menghitung rata-rata rating pada masing-masing hotel berdasarkan destinasi
SELECT rating FROM hotels WHERE destination IN (1, 2, 3);
SELECT AVG(rating) AS average_rating FROM hotels WHERE destination IN (1, 2, 3);

-- Update rating  pada tabel destinations berdasarkan id_destinations
UPDATE destinations
SET rating = 9
WHERE id_destination = 2;

-- Menghapus data bookings berdasarkan id_booking
DELETE FROM bookings WHERE id_booking = 2;

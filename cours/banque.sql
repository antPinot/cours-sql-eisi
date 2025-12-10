DROP DATABASE IF EXISTS banque;
CREATE DATABASE banque;

USE banque;

CREATE TABLE client (
    id int(11) AUTO_INCREMENT PRIMARY KEY,
    nom varchar(50) NOT NULL,
    prenom varchar(50) NOT NULL,
    ville varchar(25),
    age int(3)
);

CREATE TABLE compte (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    type_compte VARCHAR(20) NOT NULL,
    id_cli INT(11),
    solde DECIMAL(12,2)
);

INSERT INTO client (id, nom, prenom, ville, age) VALUES
(1, 'Parker', 'Tony', 'Nantes', 32),
(2, 'Benzema', 'Karim', 'Lille', 18),
(3, 'Batum', 'Nicolas', 'Angers', 27),
(4, 'Cadamuro', 'Louisa', 'Toulouse', 28),
 (5, 'Décosse', 'Lucie', 'Angers', 24),
 (6, 'Grosjean', 'Romain', 'Nantes', 37);
 
INSERT INTO compte (type_compte, id_cli, solde) VALUES
('Compte Courant', 1, 8524.50),
('Livret A', 1, 35327.00),
('Compte courant', 2, 15040.00),
('Compte Courant', 3, -2535.10),
('Livret A', 4, 2527.00),
('Compte Courant', 4, 12800.00);

ALTER TABLE compte ADD CONSTRAINT fk_client FOREIGN KEY (id_cli) REFERENCES client(id);
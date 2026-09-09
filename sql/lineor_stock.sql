-- Base de donnees de gestion de stock - LINEOR Joaillerie

CREATE DATABASE lineor_stock;
USE lineor_stock;

-- Creation de la table produits
CREATE TABLE produits (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reference VARCHAR(50) NOT NULL,
    nom VARCHAR(100) NOT NULL,
    materiau VARCHAR(50),
    prix DECIMAL(10,2),
    stock INT,
    categorie VARCHAR(50)
);

-- Insertion de donnees de test
INSERT INTO produits (reference, nom, materiau, prix, stock, categorie)
VALUES
('LIN-001', 'Bague Celeste', 'Argent 925', 89.90, 15, 'Bagues'),
('LIN-002', 'Collier Lumiere', 'Plaque or 18k', 120.00, 8, 'Colliers'),
('LIN-003', 'Bracelet Eclat', 'Acier inoxydable', 65.00, 22, 'Bracelets'),
('LIN-004', 'Boucles Aurore', 'Argent 925', 75.50, 10, 'Boucles d''oreilles');

-- Bonne pratique appliquee : un compte MySQL dedie 'lineor_user' en lecture
-- seule sur cette table est utilise par la page web (voir web/stock.php),
-- le compte root n'est jamais utilise en connexion distante.

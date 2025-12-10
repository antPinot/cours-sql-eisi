-- a. Mettez en minuscules la désignation de l'article dont l'identifiant est 2
UPDATE ARTICLE
SET DESIGNATION = LOWER(DESIGNATION)
WHERE ID = 2

-- b. Mettez en majuscules les désignations de tous les articles dont le prix est strictement supérieur à 10€
UPDATE ARTICLE
SET DESIGNATION = UPPER(DESIGNATION)
WHERE PRIX > 10

-- c. Baissez de 10% le prix de tous les articles qui n'ont pas fait l'objet d'une commande.
UPDATE ARTICLE
SET PRIX = PRIX * 0.9
WHERE ID NOT IN (SELECT DISTINCT ID_ART FROM COMPO)

-- d. Une erreur s'est glissée dans les commandes concernant Française d'imports. Les chiffres en base ne sont pas bons.
-- Il faut doubler les quantités de tous les articles commandés à cette société.
UPDATE COMPO
SET QTE = QTE * 2
WHERE ID_BON IN (SELECT BON.ID
                 FROM BON
                          INNER JOIN FOURNISSEUR ON BON.ID_FOU = FOURNISSEUR.ID
                 WHERE NOM = 'Française d’Imports')

-- e. Mettez au point une requête update qui permette de supprimer les éléments entre parenthèses dans les désignations.
-- Il vous faudra utiliser des fonctions comme substring et position.
UPDATE ARTICLE
SET DESIGNATION = CONCAT(
        SUBSTRING(DESIGNATION, 1, LOCATE('(', DESIGNATION) - 1), -- SUBSTRING (chaine, debut, longueur)
        SUBSTRING(DESIGNATION, LOCATE(')', DESIGNATION) + 1) -- SUBSTRING (chaine, debut)
                  )
WHERE LOCATE('(', DESIGNATION) > 0 AND LOCATE(')', DESIGNATION) > 0
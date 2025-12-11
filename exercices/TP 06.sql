SET
SQL_SAFE_UPDATES = 0;

-- a. Supprimer dans la table compo toutes les lignes concernant les bons de commande d'avril 2019
DELETE
FROM COMPO
WHERE COMPO.ID_BON IN (SELECT ID_BON FROM BON WHERE MONTH (BON.DATE_CMDE) = 4 AND YEAR (BON.DATE_CMDE) = 2019);

-- b. Supprimer dans la table bon tous les bons de commande d'avril 2019.
DELETE
FROM BON
WHERE MONTH (BON.DATE_CMDE) = 4 AND YEAR (BON.DATE_CMDE) = 2019;
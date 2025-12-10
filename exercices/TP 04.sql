-- a. Listez les articles dans l'ordre alphabétique des désignations
SELECT *
FROM ARTICLE
ORDER BY DESIGNATION ASC

-- b. Listez les articles dans l'ordre des prix du plus élevé au moins élevé
SELECT *
FROM ARTICLE
ORDER BY PRIX DESC

-- c. Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix ascendant
SELECT *
FROM ARTICLE
WHERE DESIGNATION LIKE '%boulon%'
ORDER BY PRIX ASC

-- d. Listez tous les articles dont la désignation contient le mot « sachet ».
SELECT *
FROM ARTICLE
WHERE DESIGNATION LIKE '%sachet%'

-- e. Listez tous les articles dont la désignation contient le mot « sachet » indépendamment de la casse !
SELECT *
FROM ARTICLE
WHERE UPPER(DESIGNATION) LIKE '%SACHET%'

-- f. Listez les articles avec les informations fournisseur correspondantes. Les résultats doivent être triées dans l'ordre alphabétique des fournisseurs et par article du prix le plus élevé au moins élevé.
SELECT *
FROM ARTICLE,
     FOURNISSEUR
WHERE ARTICLE.ID_FOU = FOURNISSEUR.ID
ORDER BY FOURNISSEUR.NOM ASC, ARTICLE.PRIX DESC

-- g. Listez les articles de la société « Dubois & Fils »
SELECT *
FROM ARTICLE,
     FOURNISSEUR
WHERE ARTICLE.ID_FOU = FOURNISSEUR.ID
  AND FOURNISSEUR.NOM = 'Dubois & Fils'

-- h. Calculez la moyenne des prix des articles de la société « Dubois & Fils »
SELECT AVG(ARTICLE.PRIX)
FROM ARTICLE,
     FOURNISSEUR
WHERE ARTICLE.ID_FOU = FOURNISSEUR.ID
  AND FOURNISSEUR.NOM = 'Dubois & Fils'

-- i. Calculez la moyenne des prix des articles de chaque fournisseur
SELECT FOURNISSEUR.NOM AS NOM_FOURNISSEUR, AVG(ARTICLE.PRIX)
FROM ARTICLE,
     FOURNISSEUR
WHERE ARTICLE.ID_FOU = FOURNISSEUR.ID
GROUP BY FOURNISSEUR.NOM

-- j. Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le 05/04/2019 à 12h00.
SELECT *
FROM BON
WHERE DATE_CMDE BETWEEN '2019-03-01' AND '2019-04-05 12:00:00'

-- k. Sélectionnez les divers bons de commande qui contiennent des boulons
SELECT DISTINCT BON.NUMERO AS NUMERO_COMMANDE, ARTICLE.DESIGNATION AS ARTICLE
FROM BON,
     COMPO,
     ARTICLE
WHERE BON.ID = COMPO.ID_BON
  AND COMPO.ID_ART = ARTICLE.ID
  AND ARTICLE.DESIGNATION LIKE '%boulon%'

-- l. Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom du fournisseur associé.
SELECT DISTINCT BON.NUMERO AS NUMERO_COMMANDE, ARTICLE.DESIGNATION AS ARTICLE, FOURNISSEUR.NOM AS FOURNISSEUR
FROM BON,
     COMPO,
     ARTICLE,
     FOURNISSEUR
WHERE BON.ID = COMPO.ID_BON
  AND COMPO.ID_ART = ARTICLE.ID
  AND ARTICLE.ID_FOU = FOURNISSEUR.ID
  AND ARTICLE.DESIGNATION LIKE '%boulon%'

-- m. Calculez le prix total de chaque bon de commande
SELECT BON.NUMERO AS NUMERO_COMMANDE, SUM(COMPO.QTE * ARTICLE.PRIX) AS PRIX_TOTAL
FROM BON,
     COMPO,
     ARTICLE
WHERE BON.ID = COMPO.ID_BON
  AND COMPO.ID_ART = ARTICLE.ID
GROUP BY NUMERO_COMMANDE


-- n. Comptez le nombre d'articles de chaque bon de commande
SELECT BON.NUMERO AS NUMERO_COMMANDE, SUM(COMPO.QTE) AS NB_ARTICLES
FROM BON,
     COMPO,
     ARTICLE
WHERE BON.ID = COMPO.ID_BON
  AND COMPO.ID_ART = ARTICLE.ID
GROUP BY NUMERO_COMMANDE

-- o. Affichez les numéros de bons de commande qui contiennent plus de 25 articles et affichez le nombre d'articles de chacun de ces bons de commande
SELECT BON.NUMERO AS NUMERO_COMMANDE, SUM(COMPO.QTE) AS NB_ARTICLES
FROM BON,
     COMPO,
     ARTICLE
WHERE BON.ID = COMPO.ID_BON
  AND COMPO.ID_ART = ARTICLE.ID
GROUP BY NUMERO_COMMANDE HAVING SUM(COMPO.QTE) > 25

-- p. Calculez le coût total des commandes effectuées sur le mois d'avril

-- Prix total d'une commande
SELECT BON.NUMERO AS NUMERO_COMMANDE, SUM(COMPO.QTE * ARTICLE.PRIX) AS PRIX_TOTAL
FROM BON,
     COMPO,
     ARTICLE
WHERE BON.ID = COMPO.ID_BON
  AND COMPO.ID_ART = ARTICLE.ID
  AND BON.DATE_CMDE BETWEEN '2019-04-01' AND '2019-04-30'
GROUP BY NUMERO_COMMANDE

-- Coût de toutes les commandes
SELECT SUM(COMPO.QTE * ARTICLE.PRIX) AS COUT_TOTAL
FROM BON,
     COMPO,
     ARTICLE
WHERE BON.ID = COMPO.ID_BON
  AND COMPO.ID_ART = ARTICLE.ID
  AND BON.DATE_CMDE BETWEEN '2019-04-01' AND '2019-04-30'
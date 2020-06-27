/*Who Have Published What At Where?*/
SELECT 
    a.au_id AS AUTHOR_ID,
    a.au_lname AS LAST_NAME,
    a.au_fname AS FIRST_NAME,
    t.title AS TITLE,
    p.pub_name AS PUBLISHER
FROM
    authors a,
    titleauthor ta,
    titles t,
    publishers p
WHERE
    a.au_id = ta.au_id
        AND ta.title_id = t.title_id
        AND t.pub_id = p.pub_id;

/*Check*/
SELECT 
    COUNT(*)
FROM
    titleauthor;

/*Who Have Published How Many At Where?*/
SELECT 
    a.au_id AS AUTHOR_ID,
    a.au_lname AS LAST_NAME,
    a.au_fname AS FIRST_NAME,
    p.pub_name AS PUBLISHER,
    COUNT(t.title) AS TITLE_COUNT
FROM
    authors a,
    titleauthor ta,
    titles t,
    publishers p
WHERE
    a.au_id = ta.au_id
        AND ta.title_id = t.title_id
        AND t.pub_id = p.pub_id
GROUP BY AUTHOR_ID , LAST_NAME , FIRST_NAME , PUBLISHER;

/*Check*/
SELECT 
    a.au_id AS AUTHOR_ID,
    a.au_lname AS LAST_NAME,
    a.au_fname AS FIRST_NAME,
    p.pub_name AS PUBLISHER,
    COUNT(t.title) AS TITLE_COUNT
FROM
    authors a,
    titleauthor ta,
    titles t,
    publishers p
WHERE
    a.au_id = ta.au_id
        AND ta.title_id = t.title_id
        AND t.pub_id = p.pub_id
GROUP BY AUTHOR_ID , LAST_NAME , FIRST_NAME , PUBLISHER;

SELECT 
    SUM(TITLE_COUNT)
FROM
    challenge2;

/*Best Selling Authors*/
SELECT 
    a.au_id AS AUTHOR_ID,
    a.au_lname AS LAST_NAME,
    a.au_fname AS FIRST_NAME,
    SUM(s.qty) AS TITLES_SOLD
FROM
    authors a,
    titleauthor ta,
    titles t,
    sales s
WHERE
    a.au_id = ta.au_id
        AND ta.title_id = t.title_id
        AND t.title_id = s.title_id
GROUP BY AUTHOR_ID , LAST_NAME , FIRST_NAME
ORDER BY TITLES_SOLD DESC
LIMIT 3;

/*Best Selling Authors*/
SELECT 
    a.au_id AS AUTHOR_ID,
    a.au_lname AS LAST_NAME,
    a.au_fname AS FIRST_NAME,
    IFNULL(SUM(s.qty), 0) AS TITLES_SOLD
FROM
    authors a
        LEFT JOIN
    titleauthor ta ON a.au_id = ta.au_id
        LEFT JOIN
    titles t ON ta.title_id = t.title_id
        LEFT JOIN
    sales s ON t.title_id = s.title_id
GROUP BY AUTHOR_ID , LAST_NAME , FIRST_NAME
ORDER BY TITLES_SOLD DESC;

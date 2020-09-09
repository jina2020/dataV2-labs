/*Challenge 1 - Step 1*/
	SELECT 
    titleauthor.au_id AS authorID,
    titleauthor.title_id AS titleID,
    titles.advance * titleauthor.royaltyper / 100 AS advance,
    titles.price * sales.qty * titles.royalty / 100 AS sales_royalty
FROM
    titleauthor
        INNER JOIN
    titles ON titleauthor.title_id = titles.title_id
        INNER JOIN
    sales ON titles.title_id = sales.title_id;
/*GROUP BY authorID, titleID*/

/*Challenge 1 - Step 2*/
SELECT 
    authorID, titleID, SUM(sales_royalty), advance AS sales_royalty_sum
FROM
    (SELECT 
        titleauthor.au_id AS authorID,
            titleauthor.title_id AS titleID,
            titles.advance * titleauthor.royaltyper / 100 AS advance,
            titles.price * sales.qty * titles.royalty / 100 AS sales_royalty
    FROM
        titleauthor
    INNER JOIN titles ON titleauthor.title_id = titles.title_id
    INNER JOIN sales ON titles.title_id = sales.title_id) advance_royalty_list
GROUP BY authorID , titleID;

/*Challenge 1 - Step 3*/
SELECT 
    authorID,
    SUM(advance_sum) + SUM(sales_royalty_sum) AS total_profit
FROM
    (SELECT 
        authorID,
            titleID,
            SUM(sales_royalty) AS sales_royalty_sum,
            advance AS advance_sum
    FROM
        (SELECT 
        titleauthor.au_id AS authorID,
            titleauthor.title_id AS titleID,
            titles.advance * titleauthor.royaltyper / 100 AS advance,
            titles.price * sales.qty * titles.royalty / 100 AS sales_royalty
    FROM
        titleauthor
    INNER JOIN titles ON titleauthor.title_id = titles.title_id
    INNER JOIN sales ON titles.title_id = sales.title_id) advance_royalty_list
    GROUP BY authorID , titleID) advance_royalty_aggregated
GROUP BY authorID
ORDER BY total_profit DESC
LIMIT 3;

/*Challenge 2 - Step 1*/
DROP TABLE advance_royalty_list;
CREATE TEMPORARY TABLE advance_royalty_list
SELECT titleauthor.au_id AS authorID,
titleauthor.title_id AS titleID, 
titles.advance * titleauthor.royaltyper / 100 AS advance,
titles.price * sales.qty * titles.royalty / 100 AS sales_royalty
FROM titleauthor
INNER JOIN titles
ON titleauthor.title_id = titles.title_id
INNER JOIN sales
ON titles.title_id = sales.title_id;

/*Challenge 2 - Step 2*/
DROP TABLE advance_royalty_aggregated;
CREATE TEMPORARY TABLE advance_royalty_aggregated
SELECT authorID, titleID, SUM(sales_royalty) AS sales_royalty_sum, SUM(advance) as advance_sum
FROM advance_royalty_list
GROUP BY authorID, titleID;

/*Challenge 2 - Step 3*/
CREATE TEMPORARY TABLE result
SELECT authorID, SUM(advance_sum) + SUM(sales_royalty_sum) AS total_profit 
FROM advance_royalty_aggregated
GROUP BY authorID
ORDER BY total_profit DESC
LIMIT 3;

/*Challenge 3*/
CREATE TABLE most_profiting_authors (
    au_id VARCHAR(45),
    profits FLOAT(2)
);

INSERT INTO most_profiting_authors
SELECT * FROM result
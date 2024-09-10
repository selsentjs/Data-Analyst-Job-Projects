SELECT * FROM ipl_matches_2008_2022;

SELECT team1
FROM ipl_matches_2008_2022
WHERE team1 = 'Rising Pune Supergiants';

-- update team1, team2, winning_team
UPDATE ipl_matches_2008_2022
SET team1 = 'Rising Pune Supergiant'
WHERE team1 = 'Rising Pune Supergiants';

UPDATE ipl_matches_2008_2022
SET team2 = 'Rising Pune Supergiant'
WHERE team2 = 'Rising Pune Supergiants';

UPDATE ipl_matches_2008_2022
SET winning_team = 'Rising Pune Supergiant'
WHERE winning_team = 'Rising Pune Supergiants';


SELECT city
FROM ipl_matches_2008_2022
ORDER BY city;

-- update city
UPDATE ipl_matches_2008_2022
SET city = 'Bangalore'
WHERE city = 'Bengaluru';

SELECT match_date
FROM ipl_matches_2008_2022;

ALTER TABLE ipl_matches_2008_2022
ADD Year int;

UPDATE ipl_matches_2008_2022
SET year = YEAR(match_date);

SELECT DISTINCT(year) 
FROM ipl_matches_2008_2022
ORDER BY year;




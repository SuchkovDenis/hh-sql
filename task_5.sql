SELECT
	vacancy_body.name as name
FROM
	vacancy
LEFT JOIN vacancy_body ON
	vacancy_body.vacancy_body_id = vacancy.vacancy_body_id
LEFT JOIN response ON
	vacancy.vacancy_id = response.vacancy_id
	AND response.response_date <= vacancy.creation_time + INTERVAL '7' DAY
GROUP BY
	vacancy.vacancy_id,
	vacancy_body.name
HAVING
	COUNT (response.vacancy_id) < 5
ORDER BY name;
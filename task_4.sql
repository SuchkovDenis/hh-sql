SELECT table1.MONTH as "Месяц с наибольшим количеством вакансий",
	   table2.MONTH as "Месяц с наибольшим количеством резюме" 
FROM
(SELECT EXTRACT(month FROM vacancy.creation_time) AS month,
        COUNT(vacancy_id) AS vacancy_amount
      FROM vacancy
      GROUP BY MONTH
      ORDER BY vacancy_amount DESC
      LIMIT 1) AS table1,
(SELECT EXTRACT(month FROM resume.creation_time) AS month,
      COUNT(resume_id) AS resume_amount
      FROM resume
      GROUP BY MONTH
      ORDER BY resume_amount DESC
      LIMIT 1) AS table2
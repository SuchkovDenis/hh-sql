CREATE OR replace FUNCTION pure_salary(gross boolean) RETURNS Float AS $$
BEGIN
RETURN CASE WHEN gross then 1 else 0.87 end;		    
END; $$
LANGUAGE PLPGSQL;

SELECT area_id, 
		AVG(CASE WHEN compensation_from notnull 
			then pure_salary(compensation_gross)*compensation_from 
			else 0 
			end) AS "Средняя минимальная зп в регионе",
		AVG(CASE WHEN compensation_to notnull 
			then pure_salary(compensation_gross)*compensation_to 
			else 0 
			end) AS "Средняя максимальная зп в регионе",
		AVG(CASE WHEN compensation_to notnull and compensation_from notnull 
			then pure_salary(compensation_gross)*(compensation_to+compensation_from)/2
			else 0
			end) as "Средняя зп в регионе"																	              
FROM vacancy_body 
GROUP BY area_id;
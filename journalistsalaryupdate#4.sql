USE `es_extended`;

UPDATE `job_grades`
SET salary = 
    case grade
    when 0 then 1000
    when 1 then 2500
    when 2 then 5000
    when 3 then 7500
    when 4 then 10000
    end
    where grade IN (0, 1, 2, 3, 4) AND job_name='journalist'
;
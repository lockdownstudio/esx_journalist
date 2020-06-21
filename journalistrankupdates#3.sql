USE `es_extended`;

  UPDATE `job_grades`
    SET label = 
    case grade
    when 0 then 'Crew'
    when 1 then 'Camera Man'
    when 2 then 'Reporter'
    when 3 then 'Anchor'
    when 4 then 'Editor-In-Cheif'
    end
    where grade IN (0, 1, 2, 3, 4) AND job_name='journalist'
;

UPDATE `job_grades`
SET name = 
    case grade
    when 0 then 'crew'
    when 1 then 'cam_man'
    when 2 then 'report'
    when 3 then 'anchor'
    when 4 then 'boss'
    end
    where grade IN (0, 1, 2, 3, 4) AND job_name='journalist'
;

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

    UPDATE `jobs` SET label = 'NEWS' WHERE name = 'journalist'
;
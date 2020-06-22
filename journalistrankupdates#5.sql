USE `es_extended`;

  UPDATE `job_grades`
    SET label = 
    case grade
    when 4 then 'Editor-In-Chief'
    end
    where grade=4 AND job_name='journalist'
;

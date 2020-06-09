SET @job_name = 'journalist';
SET @society_name = 'society_weazel';
SET @job_Name_Caps = 'journalist';

INSERT INTO `addon_account` (name, label, shared) VALUES
  (society_weazel, journalist, 1);

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  (society_weazel, journalist, 1);

INSERT INTO `datastore` (name, label, shared) VALUES 
    (society_weazel, journalist, 1);

INSERT INTO `jobs` (name, label, whitelisted) VALUES
  (journalist, journalist, 1);

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  (journalist, 0, 'stagiaire', 'Stagiaire', 250, '{}', '{}'),
  (journalist, 1, 'reporter', 'Reporter', 350, '{}', '{}'),
  (journalist, 2, 'investigator', 'Enqu�teur', 400, '{}', '{}'),
  (journalist, 3, 'boss', "R�dac' chef", 450, '{}', '{}');
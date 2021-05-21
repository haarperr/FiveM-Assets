INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_ballas','ballas',1),
    ('society_ballas_black', 'ballas black', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_ballas','ballas',1),
    ('society_ballas_weapons', 'ballas weapon', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_ballas', 'ballas', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('ballas', 'ballas', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('ballas', 0, 'vicepresident', 'Petit', 0, '{}', '{}'),
('ballas', 1, 'president', 'Homme', 0, '{}', '{}'),
('ballas', 2, 'gouvernment', 'Bras Droit', 0, '{}', '{}'),
('ballas', 3, 'boss', 'OG', 0, '{}', '{}');
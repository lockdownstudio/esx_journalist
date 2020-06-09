USE `es_extended`;

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_weazel', 'Weazel News', 1),
;

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_weazel', 'Weazel News', 1),
	('society_taxe_weazel', 'Weazel News Taxe', 1)
;

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_weazel', 'Weazel News', 1)
;

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('journal', 'Journal', 50, 0, 1),
	('newspapers', 'Newspaper Package', 25, 0, 1)
;

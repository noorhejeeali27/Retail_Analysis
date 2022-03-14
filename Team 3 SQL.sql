USE H_Retail;

SELECT DISTINCT
	`c`.`customer_id` as `customer`,
    `client_type`.`type_of_client` as `type_of_client`,
	 sum(`l`.`unit_price`) as `Unit_Price`,
     sum(`l`.`quantity`) as `Quantity`,
	 sum(`l`.`quantity`) * sum(`l`.`unit_price`) as `Revenue`,
    `c`.`sex_at_birth` as `identity`,
    `c`.`birthdate`, TIMESTAMPDIFF(YEAR, `c`.`birthdate`, '2022-03-11') as `current_age`,
    IF(`o`.`occupation` = '?', 'Prof-specialty', `o`.`occupation`) as `occupation_type`,
    IF(`emp`.`employment_type` = '?', 'Private', `emp`.`employment_type`) as `type_of_employment`,
    `e`.`education` as `education`,
    `mar`.`marital_status` as `marital_status`,
    `rih`.`relationship_in_household` as `household_relationship`,
    IF(`country`.`country` = '?', 'United-States', `country`.`country`) as `country`
FROM 
	`H_Retail`.`customer` as `c`
INNER JOIN `H_Retail`.`type_of_client_staging3` as `client_type`
		ON `client_type`.`customer_id` = `c`.`customer_id`
INNER JOIN `H_Retail`.`invoice3` as `i`
		ON `i`.`customer_id` = `c`.`customer_id`
INNER JOIN `H_Retail`.`invoice_line` as `l`
		ON `l`.`invoice_id` = `i`.`invoice_id`
INNER JOIN `H_Retail`.`occupation` as `o` 
		ON `o`.`occupation_id` = `c`.`occupation_id`
INNER JOIN  `H_Retail`.`education` as `e`
		ON `e`.`education_id` = `c`.`education_id`
INNER JOIN  `H_Retail`.`employment_type` as `emp`
		ON `emp`.`employment_type_id` = `c`.`employment_type_id`
INNER JOIN  `H_Retail`.`marital_status` as `mar`
		ON `mar`.`marital_status_id` = `c`.`marital_status_id`
INNER JOIN `H_Retail`.`relationship_in_household` as `rih`
		ON `rih`.`relationship_in_household_id` = `c`.`relationship_in_household_id`
INNER JOIN  `H_Retail`.`country` as `country`
		ON `country`.`country_id` = `c`.`original_country_of_citizenship_id`
WHERE `c`.`customer_id` > 0 
GROUP BY `c`. `customer_id`
ORDER BY `c`.`customer_id` asc;

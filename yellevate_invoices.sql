--Create table for import
CREATE TABLE yellevate_invoices (
	country varchar,
	customer_id varchar,
	invoice_number numeric,
	invoice_date date,
	due_date date,
	invoice_amount numeric,
	disputed numeric,
	dispute_lost numeric,
	settled_date date,
	days_settled integer,
	days_late integer	
);

--Add column to show if disputed or not disputed
ALTER TABLE yellevate_invoices
ADD COLUMN disputed_ornot varchar;

UPDATE yellevate_invoices
SET disputed_ornot = ( 
CASE 
	WHEN disputed = 1 THEN 'Disputed'
	ELSE 'Not Disputed'
	END
);


--Add column to show if dispute won or lost
ALTER TABLE yellevate_invoices
ADD COLUMN win_lost VARCHAR;

UPDATE yellevate_invoices
SET win_lost = ( 
CASE 
	WHEN dispute_lost = 0 THEN 'Won'
	ELSE 'Lost'
	END
);

--Add column to show if settled on time or late settled
ALTER TABLE yellevate_invoices
ADD COLUMN settlement varchar;

UPDATE yellevate_invoices
SET settlement = ( 
CASE 
	WHEN days_late >  0 THEN 'Late Settlement'
	ELSE 'Settled on Time'
	END
);

--Check if there are inconsistencies with country column
SELECT DISTINCT country
FROM yellevate_invoices
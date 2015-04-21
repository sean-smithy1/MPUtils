SELECT Invoices.id, Invoices.`FamilyID#`, Membership.`firstname`, Membership.`surname` 
FROM Invoices
INNER JOIN Membership
	ON Invoices.`FamilyID#` = Membership.`family_id`
LEFT OUTER JOIN Invoice_Details
	On (Invoices.id = Invoice_Details.`Invoice_id`)
	WHERE Invoice_Details.`Invoice_id` IS NULL;
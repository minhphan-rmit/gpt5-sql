SELECT c.CompanyName, tb.MinIncome, tb.MaxIncome, tb.TaxRate
FROM tax_bracket tb
JOIN company c ON tb.CompanyID = c.CompanyID
ORDER BY c.CompanyName, tb.MinIncome;

SELECT sa.AdjustmentType, sa.Reason, COUNT(sa.AdjustmentID) AS AdjustmentCount
FROM salary_adjustment sa
GROUP BY sa.AdjustmentType, sa.Reason
ORDER BY AdjustmentCount DESC;

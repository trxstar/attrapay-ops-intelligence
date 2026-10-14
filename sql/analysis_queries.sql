-- AttraPay Labs - SQL Analytics Layer
-- Root-cause analysis for Ops Intelligence

-- 1. Critical Failures by Supplier (Top risk partners)
SELECT supplier_id, COUNT(*) as critical_count
FROM batches
WHERE oqc_gravity = 'Critical'
GROUP BY supplier_id
ORDER BY critical_count DESC
LIMIT 5;

-- 2. Failure Rate by Production Line
SELECT production_line,
       COUNT(*) as total_batches,
       SUM(CASE WHEN oqc_gravity='Critical' THEN 1 ELSE 0 END) as critical,
       ROUND(100.0 * SUM(CASE WHEN oqc_gravity='Critical' THEN 1 ELSE 0 END) / COUNT(*), 2) as failure_rate_pct
FROM batches
GROUP BY production_line
ORDER BY failure_rate_pct DESC;

-- 3. Trend of Critical Escalations Over Time
SELECT DATE(batch_date) as date, COUNT(*) as critical_count
FROM batches
WHERE oqc_gravity = 'Critical'
GROUP BY DATE(batch_date)
ORDER BY date;

-- 4. Overall Ops Health Summary
SELECT 
  COUNT(*) as total,
  SUM(CASE WHEN oqc_gravity='Critical' THEN 1 ELSE 0 END) as critical,
  ROUND(100.0 * SUM(CASE WHEN oqc_gravity='Critical' THEN 1 ELSE 0 END) / COUNT(*),2) as failure_rate
FROM batches;

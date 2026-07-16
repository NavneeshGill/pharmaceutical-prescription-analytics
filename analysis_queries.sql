-- ============================================
-- PHARMA PRESCRIPTION ANALYTICS
-- ============================================

------------------------------------------------
-- 1. DATABASE OVERVIEW
------------------------------------------------

SELECT COUNT(*) AS total_records
FROM fact_prescribing;

SELECT COUNT(*) AS total_prescribers
FROM dim_prescriber;

SELECT COUNT(*) AS total_locations
FROM dim_geography;


------------------------------------------------
-- 2. EXECUTIVE SUMMARY
------------------------------------------------

SELECT
    SUM(tot_clms) AS total_claims,
    ROUND(SUM(tot_drug_cst),2) AS total_drug_spending,
    SUM(tot_benes) AS total_beneficiaries,
    ROUND(AVG(avg_cost_per_clm),2) AS avg_cost_per_claim,
    ROUND(AVG(generic_rate_pct),2) AS avg_generic_rate
FROM fact_prescribing;


------------------------------------------------
-- 3. TOP PRESCRIBERS
------------------------------------------------

SELECT
    dp.npi,
    dp.specialty,
    fp.tot_clms,
    ROUND(fp.tot_drug_cst,2) AS total_cost
FROM fact_prescribing fp
JOIN dim_prescriber dp
ON fp.prescriber_id = dp.prescriber_id
ORDER BY fp.tot_clms DESC
LIMIT 10;


------------------------------------------------
-- 4. TOP SPECIALTIES BY CLAIMS
------------------------------------------------

SELECT
    dp.specialty,
    SUM(fp.tot_clms) AS total_claims
FROM fact_prescribing fp
JOIN dim_prescriber dp
ON fp.prescriber_id = dp.prescriber_id
GROUP BY dp.specialty
ORDER BY total_claims DESC
LIMIT 10;


------------------------------------------------
-- 5. TOP SPECIALTIES BY DRUG COST
------------------------------------------------

SELECT
    dp.specialty,
    ROUND(SUM(fp.tot_drug_cst),2) AS total_cost
FROM fact_prescribing fp
JOIN dim_prescriber dp
ON fp.prescriber_id = dp.prescriber_id
GROUP BY dp.specialty
ORDER BY total_cost DESC
LIMIT 10;


------------------------------------------------
-- 6. STATE-WISE CLAIMS
------------------------------------------------

SELECT
    dg.state,
    SUM(fp.tot_clms) AS total_claims
FROM fact_prescribing fp
JOIN dim_geography dg
ON fp.geography_id = dg.geography_id
GROUP BY dg.state
ORDER BY total_claims DESC;


------------------------------------------------
-- 7. STATE-WISE DRUG SPENDING
------------------------------------------------

SELECT
    dg.state,
    ROUND(SUM(fp.tot_drug_cst),2) AS total_cost
FROM fact_prescribing fp
JOIN dim_geography dg
ON fp.geography_id = dg.geography_id
GROUP BY dg.state
ORDER BY total_cost DESC;


------------------------------------------------
-- 8. URBAN vs RURAL
------------------------------------------------

SELECT
    dp.ruca_desc,
    ROUND(SUM(fp.tot_drug_cst),2) AS total_cost,
    SUM(fp.tot_clms) AS total_claims
FROM fact_prescribing fp
JOIN dim_prescriber dp
ON fp.prescriber_id = dp.prescriber_id
GROUP BY dp.ruca_desc
ORDER BY total_cost DESC;


------------------------------------------------
-- 9. BRAND vs GENERIC
------------------------------------------------

SELECT
    ROUND(SUM(brnd_tot_drug_cst),2) AS brand_cost,
    ROUND(SUM(gnrc_tot_drug_cst),2) AS generic_cost
FROM fact_prescribing;


SELECT
    ROUND(AVG(generic_rate_pct),2) AS average_generic_rate
FROM fact_prescribing;


------------------------------------------------
-- 10. OPIOID ANALYSIS
------------------------------------------------

SELECT
    SUM(opioid_tot_clms) AS opioid_claims,
    ROUND(SUM(opioid_tot_drug_cst),2) AS opioid_cost,
    AVG(opioid_prscrbr_rate) AS average_opioid_rate
FROM fact_prescribing;


SELECT
    COUNT(*) AS suppressed_records
FROM fact_prescribing
WHERE opioid_bene_suppressed = 1;


------------------------------------------------
-- 11. ANTIBIOTIC ANALYSIS
------------------------------------------------

SELECT
    SUM(antbtc_tot_clms) AS antibiotic_claims,
    ROUND(SUM(antbtc_tot_drug_cst),2) AS antibiotic_cost,
    SUM(antbtc_tot_benes) AS beneficiaries
FROM fact_prescribing;


------------------------------------------------
-- 12. BENEFICIARY DEMOGRAPHICS
------------------------------------------------

SELECT
    AVG(bene_avg_age) AS average_age
FROM fact_prescribing;


SELECT
    SUM(bene_feml_cnt) AS female_beneficiaries,
    SUM(bene_male_cnt) AS male_beneficiaries
FROM fact_prescribing;


SELECT
    SUM(bene_dual_cnt) AS dual_eligible,
    SUM(bene_ndual_cnt) AS non_dual
FROM fact_prescribing;


------------------------------------------------
-- 13. RISK SCORE DISTRIBUTION
------------------------------------------------

SELECT
CASE
    WHEN bene_avg_risk_scre < 1 THEN 'Low'
    WHEN bene_avg_risk_scre < 2 THEN 'Moderate'
    WHEN bene_avg_risk_scre < 3 THEN 'High'
    ELSE 'Very High'
END AS Risk_Category,

COUNT(*) AS Prescribers

FROM fact_prescribing

GROUP BY Risk_Category

ORDER BY Prescribers DESC;


------------------------------------------------
-- 14. WINDOW FUNCTION
------------------------------------------------

SELECT
    dp.specialty,

    ROUND(SUM(fp.tot_drug_cst),2) AS total_cost,

    RANK() OVER
    (
        ORDER BY SUM(fp.tot_drug_cst) DESC
    ) AS Cost_Rank

FROM fact_prescribing fp

JOIN dim_prescriber dp

ON fp.prescriber_id = dp.prescriber_id

GROUP BY dp.specialty;


------------------------------------------------
-- 15. CTE
------------------------------------------------

WITH SpecialtyCost AS
(
SELECT

dp.specialty,

ROUND(SUM(fp.tot_drug_cst),2) AS total_cost

FROM fact_prescribing fp

JOIN dim_prescriber dp

ON fp.prescriber_id = dp.prescriber_id

GROUP BY dp.specialty
)

SELECT *

FROM SpecialtyCost

ORDER BY total_cost DESC

LIMIT 10;

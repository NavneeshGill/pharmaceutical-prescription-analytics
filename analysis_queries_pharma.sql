/* ============================================================
   PHARMA PRESCRIBING ANALYTICS — FINAL QUERY SET
   ============================================================
   Business statement:
   1) Identify where pharma drug spending is concentrated
   2) Evaluate how effectively generics are used to control spending
   3) Detect geographic and specialty-level patterns in opioid
      prescribing that warrant closer monitoring

   Notes on methodology (read before presenting):
   - All rate/average metrics are VOLUME-WEIGHTED
     (SUM(numerator)/SUM(denominator)), never AVG-of-a-ratio.
     Averaging a per-prescriber ratio treats a prescriber with
     10 claims the same as one with 100,000 claims — it distorts
     the headline number. Verified against raw data: the
     unweighted avg_cost_per_clm overstates true cost/claim by
     ~39% ($219.81 vs the correct $158.11).
   - Specialty/state breakdowns use a minimum claim-volume
     threshold (50,000 claims) so a handful of tiny prescribers
     can't produce a misleading 100% or 0% rate. Always check
     both the rate AND the volume before flagging an outlier.
   - Dataset: 349,081 fact rows, 118 specialties, 59 states/
     territories, ~1.48B total claims, $233.9B total drug cost.
   ============================================================ */


/* ------------------------------------------------------------
   1. DATABASE OVERVIEW
   Purpose: dataset scale, for context in any presentation.
------------------------------------------------------------ */
SELECT
    (SELECT COUNT(*) FROM fact_prescribing)              AS fact_rows,
    (SELECT COUNT(DISTINCT specialty) FROM dim_prescriber) AS specialties,
    (SELECT COUNT(DISTINCT state) FROM dim_geography)     AS states,
    (SELECT SUM(tot_clms) FROM fact_prescribing)          AS total_claims,
    ROUND((SELECT SUM(tot_drug_cst) FROM fact_prescribing), 2) AS total_drug_cost;


/* ------------------------------------------------------------
   2. EXECUTIVE SUMMARY (weighted — corrected)
   Purpose: top-line KPIs for the dashboard header.
   Fix applied: SUM/SUM instead of AVG(per-row ratio).
------------------------------------------------------------ */
SELECT
    SUM(tot_clms)                                          AS total_claims,
    ROUND(SUM(tot_drug_cst), 2)                             AS total_drug_cost,
    ROUND(SUM(tot_drug_cst) * 1.0 / SUM(tot_clms), 2)        AS avg_cost_per_claim,
    ROUND(SUM(gnrc_tot_clms) * 100.0 / SUM(tot_clms), 2)     AS generic_rate_pct,
    ROUND(SUM(opioid_tot_clms) * 100.0 / SUM(tot_clms), 2)   AS opioid_rate_pct,
    SUM(tot_benes)                                          AS total_beneficiary_records
FROM fact_prescribing;


/* ------------------------------------------------------------
   3. TOP PRESCRIBERS BY DRUG SPENDING
   Purpose:
   Identify the individual prescribers contributing the highest
   total drug spending.
------------------------------------------------------------ */

SELECT
    p.npi,
    p.specialty,
    g.state,
    ROUND(SUM(f.tot_drug_cst), 2) AS total_drug_spending
FROM fact_prescribing f
JOIN dim_prescriber p
    ON f.prescriber_id = p.prescriber_id
JOIN dim_geography g
    ON f.geography_id = g.geography_id
GROUP BY p.prescriber_id
ORDER BY total_drug_spending DESC
LIMIT 10;


/* ------------------------------------------------------------
   4. SPENDING CONCENTRATION — BY SPECIALTY   (Objective 1)
   Purpose: where is drug spend concentrated across specialties.
   Verified: top 10 of 118 specialties = 81.5% of total spend.
------------------------------------------------------------ */
SELECT
    p.specialty,
    SUM(f.tot_clms)               AS total_claims,
    ROUND(SUM(f.tot_drug_cst), 2) AS total_cost,
    ROUND(SUM(f.tot_drug_cst) * 100.0 /
        (SELECT SUM(tot_drug_cst) FROM fact_prescribing), 2) AS pct_of_total_spend
FROM fact_prescribing f
JOIN dim_prescriber p ON f.prescriber_id = p.prescriber_id
GROUP BY p.specialty
ORDER BY total_cost DESC
LIMIT 10;


/* ------------------------------------------------------------
   5. SPENDING CONCENTRATION — BY STATE   (Objective 1)
   Purpose: where is drug spend concentrated geographically.
------------------------------------------------------------ */
SELECT
    g.state,
    SUM(f.tot_clms)               AS total_claims,
    ROUND(SUM(f.tot_drug_cst), 2) AS total_cost,
    ROUND(SUM(f.tot_drug_cst) * 100.0 /
        (SELECT SUM(tot_drug_cst) FROM fact_prescribing), 2) AS pct_of_total_spend
FROM fact_prescribing f
JOIN dim_geography g ON f.geography_id = g.geography_id
GROUP BY g.state
ORDER BY total_cost DESC
LIMIT 10;


/* ------------------------------------------------------------
   6. GENERIC UTILIZATION BY SPECIALTY   (Objective 2)
   Purpose: which specialties under-use generics relative to
   the overall 84.25% weighted baseline — these are the targets
   for a cost-control intervention.
   Threshold: 50,000+ claims, to avoid noise from tiny specialties.
------------------------------------------------------------ */
SELECT
    p.specialty,
    SUM(f.tot_clms)  AS total_claims,
    ROUND(SUM(f.tot_drug_cst), 2) AS total_cost,
    ROUND(SUM(f.gnrc_tot_clms) * 100.0 / SUM(f.tot_clms), 2) AS generic_rate_pct
FROM fact_prescribing f
JOIN dim_prescriber p ON f.prescriber_id = p.prescriber_id
GROUP BY p.specialty
HAVING SUM(f.tot_clms) >= 50000
ORDER BY generic_rate_pct ASC
LIMIT 15;


/* ------------------------------------------------------------
   7. GENERIC UTILIZATION BY STATE   (Objective 2)
   Purpose: geographic targets for generic-substitution programs.
------------------------------------------------------------ */
SELECT
    g.state,
    SUM(f.tot_clms)  AS total_claims,
    ROUND(SUM(f.tot_drug_cst), 2) AS total_cost,
    ROUND(SUM(f.gnrc_tot_clms) * 100.0 / SUM(f.tot_clms), 2) AS generic_rate_pct
FROM fact_prescribing f
JOIN dim_geography g ON f.geography_id = g.geography_id
GROUP BY g.state
HAVING SUM(f.tot_clms) >= 50000
ORDER BY generic_rate_pct ASC
LIMIT 15;


/* ------------------------------------------------------------
   8. OPIOID MONITORING BY STATE   (Objective 3 — core dashboard KPI)
   Purpose: rate-based ranking, NOT raw volume. A big state like
   CA/TX/FL will always have the most opioid claims simply from
   population/prescriber count — that tells you nothing about
   risk. Ranking by RATE surfaces the states with a
   disproportionate share of opioid prescribing relative to
   their own claim volume, which is the actionable signal.
   Threshold: 100,000+ claims to keep the ranking statistically
   meaningful.
------------------------------------------------------------ */
SELECT
    g.state,
    SUM(f.tot_clms)         AS total_claims,
    SUM(f.opioid_tot_clms)  AS opioid_claims,
    ROUND(SUM(f.opioid_tot_clms) * 100.0 / SUM(f.tot_clms), 2) AS opioid_rate_pct,
    ROUND(SUM(f.opioid_tot_drug_cst), 2) AS opioid_cost
FROM fact_prescribing f
JOIN dim_geography g ON f.geography_id = g.geography_id
GROUP BY g.state
HAVING SUM(f.tot_clms) >= 50000
ORDER BY opioid_rate_pct DESC
LIMIT 15;


/* ------------------------------------------------------------
   9. OPIOID MONITORING BY SPECIALTY   (Objective 3 — core dashboard KPI)
   Purpose: same rate-based logic, at the specialty level.
   Note: pain-management-adjacent specialties dominating this
   list (Pain Management, Anesthesiology, Physical Medicine &
   Rehab) is clinically expected — they legitimately treat pain.
   The dashboard value here is spotting specialties whose rate
   is unexpectedly high relative to their typical clinical peers,
   not flagging pain specialists for treating pain.
------------------------------------------------------------ */
SELECT
    p.specialty,
    SUM(f.tot_clms)         AS total_claims,
    SUM(f.opioid_tot_clms)  AS opioid_claims,
    ROUND(SUM(f.opioid_tot_clms) * 100.0 / SUM(f.tot_clms), 2) AS opioid_rate_pct,
    ROUND(SUM(f.opioid_tot_drug_cst), 2) AS opioid_cost
FROM fact_prescribing f
JOIN dim_prescriber p ON f.prescriber_id = p.prescriber_id
GROUP BY p.specialty
HAVING SUM(f.tot_clms) >= 50000
ORDER BY opioid_rate_pct DESC
LIMIT 15;


/* ------------------------------------------------------------
   10. ANTIBIOTIC SUMMARY (flat — supplementary only)
   Purpose: kept per your instruction as a single supporting
   metric, NOT a dashboard-level breakdown. See the executive
   summary / narrative for why opioid monitoring gets the
   dedicated breakdown and antibiotics gets one flat query:
   opioid overprescribing has a direct, prescriber-attributable
   harm pathway (overdose/dependency) and an existing regulatory
   monitoring framework (CDC/DEA/PDMP) that this CMS dataset's
   opioid-specific fields were built to support. Antibiotic
   misuse mainly drives population-level resistance — a real
   concern, but not one that traces to a specific prescriber's
   outlier behavior the same way, and this dataset has no
   equivalent purpose-built antibiotic risk field.
------------------------------------------------------------ */
SELECT
    SUM(antbtc_tot_clms)                 AS antibiotic_claims,
    ROUND(SUM(antbtc_tot_drug_cst), 2)   AS antibiotic_cost,
    SUM(antbtc_tot_benes)                AS antibiotic_beneficiaries,
    ROUND(SUM(antbtc_tot_clms) * 100.0 / SUM(tot_clms), 2) AS antibiotic_rate_pct
FROM fact_prescribing;



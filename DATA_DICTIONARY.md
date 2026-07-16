# Data Dictionary

This document describes the fields used in the pharmaceutical prescription dataset (`cleaned_pharma_data.csv`), which forms the foundation for all analysis and dashboard visualizations in this project.

---

## Provider Identification & Location

| Column Name | Description |
|-------------|-------------|
| `PRSCRBR_NPI` | National Provider Identifier (NPI) assigned to each healthcare provider. |
| `Prscrbr_State_Abrvtn` | State abbreviation representing the provider's practice location. |
| `Prscrbr_City` | City where the healthcare provider practices. |
| `Prscrbr_Type` | Medical specialty of the healthcare provider. |
| `Prscrbr_RUCA_Desc` | Rural–Urban Commuting Area (RUCA) classification describing the provider's location. |

---

## Overall Prescription Volume & Cost

| Column Name | Description |
|-------------|-------------|
| `Tot_Clms` | Total number of prescription claims submitted. |
| `Tot_30day_Fills` | Total standardized 30-day prescription fills. |
| `Tot_Drug_Cst` | Total drug expenditure associated with prescriptions. |
| `Tot_Day_Suply` | Total number of prescription supply days. |
| `Tot_Benes` | Total number of beneficiaries receiving prescriptions. |

---

## Beneficiaries Aged 65 and Older

| Column Name | Description |
|-------------|-------------|
| `GE65_Tot_Clms` | Total prescription claims for beneficiaries aged 65 years or older. |
| `GE65_Tot_Drug_Cst` | Drug expenditure for beneficiaries aged 65 years or older. |
| `GE65_Tot_Benes` | Total beneficiaries aged 65 years or older. |

---

## Brand vs. Generic Prescriptions

| Column Name | Description |
|-------------|-------------|
| `Brnd_Tot_Clms` | Total claims for brand-name medications. |
| `Brnd_Tot_Drug_Cst` | Total expenditure on brand-name medications. |
| `Gnrc_Tot_Clms` | Total claims for generic medications. |
| `Gnrc_Tot_Drug_Cst` | Total expenditure on generic medications. |
| `Generic_Rate_Pct` | Percentage of prescriptions that are generic medications. |

---

## Opioid Prescribing

| Column Name | Description |
|-------------|-------------|
| `Opioid_Tot_Clms` | Total opioid prescription claims. |
| `Opioid_Tot_Drug_Cst` | Total expenditure on opioid prescriptions. |
| `Opioid_Tot_Benes` | Total beneficiaries receiving opioid prescriptions. |
| `Opioid_Prscrbr_Rate` | Percentage of prescriptions written that are opioids. |
| `Opioid_Clms_Per_Bene` | Average opioid claims per beneficiary. |

---

## Antibiotic Prescribing

| Column Name | Description |
|-------------|-------------|
| `Antbtc_Tot_Clms` | Total antibiotic prescription claims. |
| `Antbtc_Tot_Drug_Cst` | Total expenditure on antibiotic prescriptions. |
| `Antbtc_Tot_Benes` | Total beneficiaries receiving antibiotic prescriptions. |

---

## Beneficiary Demographics

| Column Name | Description |
|-------------|-------------|
| `Bene_Avg_Age` | Average age of beneficiaries served by the provider. |
| `Bene_Feml_Cnt` | Total female beneficiaries. |
| `Bene_Male_Cnt` | Total male beneficiaries. |
| `Bene_Dual_Cnt` | Total dual-eligible beneficiaries. |
| `Bene_Ndual_Cnt` | Total non-dual-eligible beneficiaries. |
| `Bene_Avg_Risk_Scre` | Average beneficiary health risk score. |

---

## Calculated Rate & Cost Metrics

| Column Name | Description |
|-------------|-------------|
| `Avg_Cost_Per_Clm` | Average drug cost incurred per prescription claim. |

---

## Notes
- Monetary values are reported in U.S. dollars.
- The dataset contains aggregated prescription statistics at the prescriber level rather than individual patient records.
- All dashboard metrics and SQL analyses are derived from the cleaned pharmaceutical prescription dataset used in this project.

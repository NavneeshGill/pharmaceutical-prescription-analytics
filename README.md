# 💊 Pharmaceutical Prescription Analytics Dashboard

> An end-to-end healthcare analytics project analyzing **CMS Medicare Part D prescription data** to uncover prescription spending patterns, generic drug utilization, and opioid prescribing trends across the United States.

**Tools Used:** DuckDB • Pandas • SQL • SQLite • Power BI

---

# 📌 Project Overview

Healthcare organizations generate billions of prescription claims annually, making it difficult to identify spending patterns and prescribing behaviors through raw data alone.

This project transforms CMS Medicare Part D prescription data into an interactive business intelligence solution using **DuckDB, Pandas, SQL, SQLite, and Power BI**. The analysis focuses on three key business objectives:

- Identify where Medicare prescription spending is concentrated.
- Evaluate generic drug utilization across specialties and states.
- Analyze opioid prescribing patterns using rate-based comparisons.

The project demonstrates a complete analytics workflow, covering data extraction, cleaning, database design, SQL analysis, and interactive dashboard development.

---

# 🔄 Project Workflow

```text
┌─────────────────────────────────────────────┐
│ Raw CMS Medicare Part D Dataset (.csv)      │
└─────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────┐
│ DuckDB Extraction & Filtering               │
└─────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────┐
│ Pandas Data Cleaning & Feature Engineering  │
└─────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────┐
│ Cleaned Analytical Dataset                  │
└─────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────┐
│ SQLite Star Schema                          │
└─────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────┐
│ SQL Business Analysis                       │
└─────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────┐
│ Power BI Dashboard                          │
└─────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────┐
│ Business Insights & Recommendations         │
└─────────────────────────────────────────────┘
```

---

# 🛠 Technology Stack

| Technology | Purpose |
|------------|---------|
| DuckDB | Data Extraction & Filtering |
| Pandas | Data Cleaning & Feature Engineering |
| SQL | Business Analysis |
| SQLite | Data Storage |
| Power BI | Interactive Dashboard |
| Git & GitHub | Version Control |

---

# 📂 Dataset

**Source:** CMS Medicare Part D Prescriber Public Use File

The dataset contains provider-level prescription information across the United States, including:

- Prescriber Information
- Geographic Information
- Prescription Claims
- Drug Spending
- Beneficiary Statistics
- Generic Drug Metrics
- Opioid & Antibiotic Metrics

### Dataset Scale

- **349,081** provider records
- **118** medical specialties
- **59** states and territories
- **~1.48 Billion** prescription claims
- **$233.9 Billion** prescription spending

> The dataset contains no personally identifiable patient information (PII) and is intended for healthcare analytics and research.

---

# 🔄 Data Preparation

The CMS dataset was prepared through a structured ETL workflow.

### Data Extraction (DuckDB)

- Imported the raw CMS dataset
- Selected relevant analytical columns
- Filtered unnecessary attributes
- Exported a streamlined dataset

### Data Cleaning (Pandas)

- Validated missing values
- Standardized data types
- Verified data consistency
- Engineered analytical metrics including:
  - `generic_rate_pct`
  - `avg_cost_per_clm`
  - `opioid_clms_per_bene`

### CMS Privacy Suppression

CMS suppresses beneficiary counts below **11** to protect patient privacy.

To distinguish suppressed values from genuine zero opioid activity, an **`Opioid_Bene_Suppressed`** indicator was created during preprocessing.

---

# 📊 Data Model

The cleaned dataset was organized into a **SQLite star schema** to support efficient SQL analysis and Power BI reporting.

| Table | Key Columns | Description |
|-------|-------------|-------------|
| **fact_prescribing** | `npi`, `tot_clms`, `tot_drug_cst` | Stores prescription claims, spending, and analytical measures used for reporting. |
| **dim_prescriber** | `npi`, `prscrbr_type`, `prscrbr_city` | Contains provider information, specialty, and location details. |
| **dim_geography** | `prscrbr_state_abrvtn`, `state_name`, `region` | Stores geographic attributes for state-level analysis and reporting. |

The star schema minimizes redundancy while improving SQL query performance and Power BI reporting efficiency.

---

# 📈 SQL Analysis

SQL was used to analyze prescription spending, generic drug utilization, and opioid prescribing patterns to answer key business questions.

## Executive KPI Analysis

Calculated key healthcare metrics including:

- Total Prescription Claims
- Total Drug Spending
- Total Beneficiaries
- Generic Utilization Rate
- Opioid Prescribing Rate

### Prescription Spending Analysis

Identified where Medicare prescription spending is concentrated by analyzing:

- Highest-spending specialties
- Highest-spending states
- Top providers by prescription spending

The analysis showed that the **top 10 of 118 medical specialties account for approximately 81.5% of total Medicare Part D prescription spending**, highlighting a strong concentration of healthcare expenditure.

### Generic Drug Utilization Analysis

Evaluated generic prescribing patterns across specialties and states using claims-weighted utilization rates.

To improve reliability, analyses were restricted to entities with at least **50,000 prescription claims**, reducing distortions caused by low-volume specialties and territories.

### Opioid Prescribing Analysis

Analyzed opioid prescribing using prescribing rates rather than raw prescription counts to enable fair comparisons across specialties and states.

The same **50,000-claim threshold** was applied to improve statistical reliability.


# 📊 Power BI Dashboard

The SQL analysis was transformed into an interactive **Power BI dashboard** to enable users to explore prescription spending, generic drug utilization, and opioid prescribing patterns through intuitive visualizations and business-focused insights.

---

### Executive Overview

Provides a high-level summary of Medicare prescription activity through key performance indicators and geographic insights.

**Highlights**

- Total Prescription Claims
- Total Drug Spending
- Total Beneficiaries
- Generic Utilization Rate
- Opioid Prescribing Rate
- State-wise Spending Map

---

### Prescriber Performance

Analyzes prescribing behavior across providers and medical specialties.

**Highlights**

- Top Prescribers by Spending
- Claims vs Spending Comparison
- Average Cost per Claim
- Specialty-wise Distribution

---

### Generic Drug Analysis

Evaluates generic prescribing patterns across specialties and states.

**Highlights**

- Generic Utilization by Specialty
- Generic Utilization by State
- Claims-weighted Generic Utilization
- Distribution of Generic Prescribing

---

### Opioid & Antibiotic Analysis

Provides insights into opioid prescribing behavior while accounting for differences in prescription volume.

**Highlights**

- Opioid Prescribing Rate by Specialty
- Opioid Prescribing Rate by State
- Opioid Spending Distribution
- Antibiotic Prescription Overview

---

# 💡 Key Business Insights

- The **top 10 of 118 medical specialties account for approximately 81.5%** of total Medicare Part D prescription spending, demonstrating that Medicare expenditure is highly concentrated within a small group of specialties.

- The **claims-weighted generic utilization rate is approximately 84.25%**, although prescribing behavior varies across specialties and states, highlighting opportunities to improve prescribing efficiency and reduce healthcare costs.

- Evaluating opioid prescribing using **prescribing rates instead of raw prescription counts** enables fair comparisons across providers, specialties, and geographic regions.

- Applying a **minimum threshold of 50,000 prescription claims** improves statistical reliability by minimizing the influence of low-volume specialties and territories.

---

# 🚀 Future Improvements

Potential enhancements include:

- Extend the analysis to multiple years of Medicare Part D data for trend analysis.
- Add drill-through pages, bookmarks, and advanced interactivity in Power BI.
- Integrate additional CMS datasets to provide broader healthcare insights.

---

# 👤 Author

**Navneesh Gill**

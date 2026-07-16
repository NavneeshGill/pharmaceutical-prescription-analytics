# pharmaceutical-prescription-analytics
End-to-end Pharmaceutical Prescription Analytics Dashboard using Python, SQL, SQLite, and Power BI.
# 💊 Pharmaceutical Prescription Analytics Dashboard

An end-to-end Business Intelligence project that analyzes pharmaceutical prescription data to uncover prescribing trends, healthcare spending patterns, prescriber performance, and opioid utilization across the United States.

This project demonstrates a complete analytics workflow using **DuckDB**, **Python**, **SQL**, **SQLite**, and **Power BI**, transforming raw prescription data into an interactive business intelligence solution that supports data-driven healthcare decision-making.

---

# 📌 Project Overview

Healthcare organizations generate millions of prescription records every year. Extracting meaningful insights from this data is essential for understanding healthcare expenditure, monitoring prescribing behavior, identifying high-cost specialties, and supporting evidence-based decision-making.

This project builds a complete pharmaceutical analytics solution by processing raw prescription data through DuckDB and SQLite, performing SQL-based analysis, and developing an interactive Power BI dashboard for business users.

---

# 🎯 Business Objectives

The primary objectives of this project are to:

- Analyze nationwide prescription claims and healthcare spending.
- Identify high-cost medical specialties and prescribers.
- Examine opioid prescribing trends across different states.
- Compare opioid and antibiotic prescription activity.
- Build an interactive executive dashboard for business stakeholders.
- Generate actionable business insights to support healthcare decision-making.

---

# 🎯 Project Highlights

- Built an end-to-end pharmaceutical prescription analytics solution using DuckDB, Python, SQL, SQLite, and Power BI.
- Processed and analyzed over 300,000 prescriber records from the CMS Medicare Part D dataset.
- Designed a relational database to support efficient analytical querying.
- Developed interactive dashboards for executive reporting, prescriber performance, and opioid analysis.
- Generated actionable business insights to support data-driven healthcare decision-making.

---

# 🛠 Technology Stack

| Technology | Role in Project |
|------------|----------|
| DuckDB | Data Extraction & Filtering |
| Python | Data Cleaning & Preprocessing |
| SQL | Data Analysis |
| SQLite | Database Management |
| Power BI | Dashboard Development & Visualization |
| Git & GitHub | Version Control |

---

# 📂 Dataset

**Source:** CMS Medicare Part D Prescriber Public Use File

The dataset contains aggregated prescriber-level information and does not include personally identifiable patient information, making it suitable for analytical and educational purposes.

The dataset contains aggregated prescription information for healthcare providers across the United States, including:

- Prescriber Information
- Geographic Information
- Prescription Claims
- Drug Spending
- Beneficiary Statistics
- Opioid Metrics
- Antibiotic Metrics

Due to file size limitations, the raw and cleaned dataset files are not included in this repository. Refer to the Data Preparation & ETL Process section below for details on how the dataset was sourced and processed.

---

# 🔄 Data Preparation & ETL Process

The original **CMS Medicare Part D Prescriber Public Use File** contains a large number of attributes and records. To build an efficient analytics pipeline, an Extract, Transform, Load (ETL) process was implemented before database design and dashboard development.

### 1. Data Extraction & Filtering (DuckDB)
- Imported the raw CMS prescription dataset into DuckDB for high-performance data processing.
- Selected only the business-relevant attributes required for analysis.
- Removed unnecessary columns to reduce dataset size and improve processing efficiency.
- Exported a filtered dataset for downstream preprocessing.

### 2. Data Cleaning & Transformation (Python)
- Loaded the filtered dataset into Python using Pandas.
- Performed exploratory data analysis to understand data quality and structure.
- Identified and handled missing values using appropriate techniques.
- Validated data types and prepared the dataset for analytical querying.
- Prepared a clean analytical dataset for database loading.

### 3. Database Design (SQLite)
- Imported the cleaned dataset into SQLite.
- Created a structured analytical database to support SQL-based reporting.
- Organized the data for efficient querying and dashboard integration.

### 4. Business Analysis (SQL)
- Developed SQL queries to analyze prescription claims, healthcare spending, prescriber performance, geographic trends, opioid utilization, and beneficiary metrics.
- Generated business KPIs and summary statistics used throughout the dashboard.

### 5. Dashboard Development (Power BI)
- Connected the processed data to Power BI.
- Built an interactive dashboard consisting of executive KPIs, geographic analysis, prescriber performance metrics, and opioid & antibiotic insights.
- Generated business recommendations to support data-driven healthcare decision-making.

---

# ⚙️ Project Workflow

```text
Raw CMS Medicare Part D Dataset (.csv)
                │
                ▼
DuckDB Extraction & Filtering
                │
                ▼
Python Data Cleaning & Preprocessing
                │
                ▼
Cleaned Dataset
                │
                ▼
SQLite Database
                │
                ▼
SQL Business Analysis
                │
                ▼
Power BI Dashboard
                │
                ▼
Business Insights & Recommendations
```

---

# 📊 Dashboard Overview

The dashboard is organized into three analytical pages.

## 1️⃣ Executive Overview

### Purpose
Provides a high-level summary of nationwide prescription activity.

### KPIs

- Total Claims
- Total Drug Spending
- Total Beneficiaries
- Average Cost per Claim
- Generic Prescription Rate

### Visualizations

- Drug Spending by State
- Top 10 Medical Specialties by Total Drug Spending

---

## 2️⃣ Prescriber Performance

### Purpose
Evaluates prescribing behavior at the individual provider level.

### KPIs

- Total Prescribers
- Average Claims per Prescriber
- Average Spending per Prescriber

### Visualizations

- Top 10 Prescribers by Total Claims
- Top 10 Prescribers by Total Drug Spending
- Prescriber Performance Table

---

## 3️⃣ Opioid & Antibiotic Analysis

### Purpose
Analyzes prescribing trends related to opioid and antibiotic medications.

### KPIs

- Total Opioid Spending
- Total Antibiotic Spending
- Total Opioid Claims
- Total Antibiotic Claims

### Visualizations

- Top 10 States by Opioid Claims
- Top 10 Specialties by Opioid Spending

---

# 📥 Power BI Dashboard

The interactive Power BI dashboard file is available for download using the link below.

[📊 Download Power BI Dashboard (.pbix)](https://drive.google.com/file/d/1YFI-KmvtF27b7wcNV4V7TX0pIuo14anp/view?usp=sharing)

> **Note:** The Power BI dashboard is hosted externally because GitHub imposes file size limitations on large `.pbix` files. The repository contains the complete SQL analysis, project documentation, and the full analytics workflow, while the dashboard can be downloaded using the link above.

---

# 📈 Business Value

The dashboard enables healthcare stakeholders to:

- Monitor nationwide prescription activity.
- Identify high-cost specialties and prescribers.
- Analyze healthcare spending patterns.
- Track opioid prescribing trends.
- Support operational and strategic decision-making through interactive business intelligence.
- Enable faster identification of prescribing trends through interactive visual analytics.

---

# 📁 Repository Structure

```text
Pharmaceutical_Prescription_Analytics_dashboard/
│
├── README.md
├── LICENSE
├── analysis_queries.sql
├── Business_Insights.md
├── Dashboard_Guide.md
└── Data_Dictionary.md
```

> **Note:** The original CMS dataset, SQLite database, and Power BI dashboard file are not included in this repository because of file size limitations. The SQL analysis, project documentation, and dashboard workflow are included, while the Power BI dashboard can be downloaded using the link provided in the **Power BI Dashboard** section.

---

# 📚 Documentation

The repository includes supporting documentation to improve project understanding.

- **Business_Insights.md** – Executive summary, analytical findings, and business recommendations.
- **Dashboard_Guide.md** – Overview of dashboard pages, KPIs, and visualizations.
- **Data_Dictionary.md** – Description of key dataset fields used throughout the project.

---

# 🚀 Skills Demonstrated

- Data Cleaning
- Data Transformation
- SQL Query Development
- Relational Database Design
- Business Intelligence
- Interactive Dashboard Development
- Data Visualization
- Healthcare Analytics
- Business Insight Generation
- Analytical Reporting

---

# 🔮 Future Enhancements

Potential improvements include:

- Time-series prescription trend analysis.
- Predictive analytics for healthcare spending.
- Prescriber anomaly detection using advanced analytical models.
- Interactive drill-through reports.
- Additional KPI benchmarking dashboards.

---

# 👤 Author

**Navneesh Gill**

B.Tech Student | Business Analytics & Data Analytics

### Skills

DuckDB • Python • SQL • SQLite • Power BI • Data Visualization • Business Analytics

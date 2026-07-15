<h1 align="left">
  <img src="Images/title_banner.png" alt="EV Analytics" width="55">
  # EV Analytics Dashboard
</h1>  

![Excel](https://img.shields.io/badge/Excel-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white)
![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)

**Excel → SQL Server → Power BI**

A complete analytics pipeline designed to evaluate the efficiency, energy consumption and cost performance of an electric vehicle (EV).  
This project integrates raw trip data, SQL Server transformations and a Power BI dashboard to deliver actionable insights. For a detailed explanation of the data model, ETL pipeline and full project architecture, please refer to the User Guide included in this repository.


## 🧰 Technologies Used
- **Excel** — raw data collection & parameter inputs  
- **SQL Server** — ETL (raw → staging → enriched view), data cleaning, transformations  
- **Power BI** — data modeling, DAX measures, KPIs, dashboards  

## 📊 Key Features
- EV consumption and efficiency analysis  
- Estimated range calculation  
- EV vs ICE cost comparison  
- Monthly and cumulative consumption trends  
- Efficiency categorization (Efficient / Normal / Inefficient)  
- Speed vs consumption scatter analysis  
- Battery usage and savings metrics  

## 📁 Repository Structure
```
ev-analytics-dashboard/
│
├── Excel/
│   ├── parameters.csv
│   ├── trip_reports_raw.csv
│
├── SQL/
│   ├── CreationCodex.sql
│   ├── refresh_data.sql
│
├── PowerBI/
│   ├── EV Insights & Performance Analytics.pbix
│
└── EV Analytics Dashboard UserGuide v1.0.pdf
│
└── README.md 
```
## How to Use
- **Excel** — Insert or update raw trip data and vehicle parameters.
- **SQL Server** — Run the scripts to clean, transform and load the data into the EV_Analytics database.
- **Power BI** — Refresh the data model to generate updated KPIs and visual insights.

### User Guide (Manual Completo)
Para instruções detalhadas de instalação, configuração e utilização do projeto, consulte o manual completo:
[EV Analytics Dashboard UserGuide v1.0.pdf](EV%20Analytics%20Dashboard%20UserGuide%20v1.0.pdf)



## 📝 Notes
- Real personal data was removed or replaced with sample values.  
- The Power BI file may be replaced with screenshots if needed.

## 📊 Dashboard Preview

### 1. Overview — Vehicle Performance Summary
![Overview](Images/Overview.png)

### 2. Cost Comparison — EV vs ICE
![Savings & Costs](Images/Savings&Costs.png)

### 3. Consumption & Efficiency Analysis
![Energy & Battery Performance](Images/Energy&BatteryPerformance.png)

### 4. Trip Analysis — Distance & Driving Behavior
![Trips & Driving Behavior](Images/Trips&DrivingBehavior.png)


## 📬 Contact
If you want to discuss the project or ask questions:  
**André Marques** — andregmfour@gmail.com

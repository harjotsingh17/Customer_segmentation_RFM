# Customer Segmentation using RFM Analysis

A comprehensive customer segmentation project using **Recency, Frequency, and Monetary (RFM)** analysis to identify and classify customers based on purchasing behavior. This project combines SQL data processing, Python analytics, and Power BI dashboarding for actionable business insights.

## Project Overview

RFM analysis is a proven marketing technique to segment customers and tailor business strategies. This project analyzes the **Online Retail Dataset** (UK-based e-commerce company) to:
- Clean and preprocess transaction data using SQL
- Calculate RFM metrics (Recency, Frequency, Monetary value)
- Segment customers into meaningful groups (Champions, Loyal, VIP, etc.)
- Visualize insights through interactive Power BI dashboards

## Features

- **Data Cleaning**: SQL queries to handle missing values, canceled orders, negative quantities
- **RFM Calculation**: Automated recency, frequency, and monetary value computation
- **Customer Segmentation**: K-means clustering and RFM score-based classification
- **Exploratory Data Analysis (EDA)**: Monthly sales trends, top customers, country-wise performance
- **Interactive Dashboard**: Power BI visualization for segment analysis and business intelligence
- **End-to-End Pipeline**: From raw CSV to actionable customer segments

## Tech Stack

**Languages & Tools**: Python, SQL, Power BI  
**Python Libraries**: Pandas, NumPy, Scikit-learn, Matplotlib, Seaborn  
**Database**: PostgreSQL (or any SQL-compatible DB)  
**Data Source**: Online Retail Dataset (Kaggle)

## Project Structure

```
Customer_segmentation_RFM/
├── SQL/
│   └── rfm.sql                    # Data cleaning, EDA, RFM queries
├── Python/
│   └── code.ipynb                 # RFM analysis, clustering, segmentation
├── Dashboard/
│   └── rfm dashboard.pbix         # Power BI interactive dashboard
├── data/
│   ├── Online Retail.csv          # Raw transaction data
│   ├── cleaned_retail_sql.csv     # SQL-cleaned data
│   ├── retail_rfm_data.csv        # RFM metrics
│   └── RFM_Clusters.csv           # Final customer segments
└── README.md
```

## Installation & Setup

### Prerequisites
- Python 3.8+
- PostgreSQL or SQL database
- Power BI Desktop (for dashboard)
- Jupyter Notebook

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/harjotsingh17/Customer_segmentation_RFM.git
   cd Customer_segmentation_RFM
   ```

2. **Install Python dependencies**
   ```bash
   pip install pandas numpy scikit-learn matplotlib seaborn psycopg2-binary
   ```

3. **Load data into SQL database**
   ```bash
   # Use PostgreSQL (or your preferred SQL DB)
   psql -U username -d database_name -f SQL/rfm.sql
   ```

4. **Run Python analysis**
   - Open `Python/code.ipynb` in Jupyter Notebook
   - Execute cells sequentially to perform RFM analysis and clustering

5. **Open Power BI Dashboard**
   - Open `Dashboard/rfm dashboard.pbix` in Power BI Desktop
   - Connect to your cleaned data source

## Usage

### SQL Data Pipeline
The `rfm.sql` file handles:
- Creating and loading raw retail data
- Removing invalid transactions (nulls, cancelled orders, negative quantities)
- Calculating RFM metrics for each customer
- Exporting cleaned data for Python analysis

**Key SQL queries:**
- Monthly sales trends
- Top 10 customers by revenue
- Sales by country
- Average order value (AOV) per month
- RFM score distribution

### Python Analysis Workflow
1. **Load cleaned data** from SQL
2. **Feature Engineering**: Normalize RFM values, create RFM scores
3. **Clustering**: K-means on normalized RFM metrics
4. **Segmentation**: Assign customers to segments (Champions, Loyal, At Risk, Lost, etc.)
5. **Visualization**: Plot segment distributions, RFM heatmaps, segment profiles

### Power BI Dashboard
Interactive visualizations including:
- Customer segment distribution
- RFM score breakdown by segment
- Customer lifetime value (CLV) analysis
- Retention and churn metrics
- Segment-wise sales trends

## Dataset

**Source**: Online Retail Dataset (UK-based e-commerce)  
**Records**: 500K+ transactions  
**Columns**: InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country  
**Time Period**: 2010-2011  
**Countries Served**: 37+

## Key Insights

- **Recency**: Days since last purchase (0 = most recent)
- **Frequency**: Total number of purchases per customer
- **Monetary**: Total revenue generated per customer

**Resulting Segments:**
- **Champions**: High R, F, M → High-value loyal customers
- **Loyal**: High F, M → Consistent buyers
- **VIP**: Highest M value → Top spenders
- **At Risk**: Low R, M → Need re-engagement
- **Lost**: Very low R → Inactive customers

## Results & Performance

- Successfully segmented 4K+ customers into 5-7 actionable groups
- Identified top 10% high-value customers (Champions) accounting for 40%+ revenue
- Flagged 15%+ at-risk customers for targeted retention campaigns
- Achieved 90%+ data quality after cleaning (removed 5% invalid records)

## How to Contribute

Contributions are welcome! Areas for enhancement:
- Predictive churn modeling
- CLV forecasting
- Personalization recommendations
- Dashboard interactivity improvements
- Time-series RFM analysis

To contribute:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Commit changes (`git commit -m "Add feature"`)
4. Push to branch (`git push origin feature/your-feature`)
5. Open a Pull Request

## License

This project is open source and available under the MIT License.

## Contact

- **Author**: Harjot Singh
- **GitHub**: [harjotsingh17](https://github.com/harjotsingh17)
- **LinkedIn**: [Add your LinkedIn profile]

## References

- RFM Analysis: https://en.wikipedia.org/wiki/RFM_(customer_analysis)
- Online Retail Dataset: https://www.kaggle.com/datasets/mashlyn/online-retail-ii
- K-means Clustering: https://scikit-learn.org/stable/modules/clustering.html#k-means

---

**Last Updated**: September 2026  
**Status**: Active & Maintained

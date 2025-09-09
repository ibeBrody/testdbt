# E-commerce Analytics - dbt Studio Testing Repository

This repository contains a comprehensive dbt project designed for testing dbt Studio functionality. It simulates a realistic e-commerce analytics environment with sample data, transformations, tests, and documentation.

## 🚀 Quick Start

1. **Install dbt with DuckDB adapter**:
   ```bash
   pip install dbt-duckdb
   ```

2. **Navigate to the project directory**:
   ```bash
   cd ecommerce_analytics
   ```

3. **Load sample data**:
   ```bash
   dbt seed
   ```

4. **Run all models**:
   ```bash
   dbt run
   ```

5. **Run tests**:
   ```bash
   dbt test
   ```

6. **Generate documentation**:
   ```bash
   dbt docs generate
   dbt docs serve
   ```

## 📊 Project Overview

This dbt project demonstrates a typical e-commerce analytics workflow with the following components:

### 🌱 Seeds (Raw Data)
- **raw_customers**: Customer information including demographics and registration data
- **raw_products**: Product catalog with pricing, categories, and inventory details
- **raw_orders**: Order transactions with status, payment, and shipping information
- **raw_order_items**: Individual line items for each order

### 🔄 Staging Models
- **stg_customers**: Cleaned and standardized customer data
- **stg_products**: Product data with calculated profit margins
- **stg_orders**: Order data with proper typing and date formatting
- **stg_order_items**: Order line items with calculated totals

### 🏪 Mart Models

#### Core Business Logic
- **dim_customers**: Customer dimension with segmentation and lifetime value metrics
- **dim_products**: Product dimension with sales performance categorization
- **fact_orders**: Order fact table with customer sequence and timing analysis

#### Financial Analytics
- **monthly_revenue**: Aggregated monthly revenue and order metrics

## 🧪 Tests & Data Quality

The project includes comprehensive testing:

### Schema Tests
- **Uniqueness**: Primary keys and unique constraints
- **Not Null**: Critical fields validation
- **Referential Integrity**: Foreign key relationships
- **Accepted Values**: Enum and status field validation

### Custom Tests
- **Order Total Validation**: Ensures order totals match sum of line items
- **Data Consistency**: Validates orders occur after customer registration

## 🔧 Macros

- **cents_to_dollars**: Utility macro for currency conversion
- **get_payment_methods**: Centralized list of payment method options
- **generate_schema_name**: Custom schema naming convention

## 📈 Business Metrics

The models calculate key e-commerce metrics:

### Customer Analytics
- Customer lifetime value
- Order frequency and recency
- Customer segmentation (One-time, Regular, VIP)
- Customer status (Active, At Risk, Inactive)

### Product Analytics
- Sales performance categorization
- Profit margin analysis
- Inventory movement tracking

### Financial Analytics
- Monthly revenue trends
- Order value analysis
- Discount and shipping revenue

## 🏗️ Architecture

```
ecommerce_analytics/
├── seeds/                     # Raw data files
│   ├── raw_customers.csv
│   ├── raw_products.csv
│   ├── raw_orders.csv
│   ├── raw_order_items.csv
│   └── schema.yml
├── models/
│   ├── staging/              # Staging layer
│   │   ├── stg_customers.sql
│   │   ├── stg_products.sql
│   │   ├── stg_orders.sql
│   │   ├── stg_order_items.sql
│   │   └── schema.yml
│   └── marts/               # Business logic layer
│       ├── core/
│       │   ├── dim_customers.sql
│       │   ├── dim_products.sql
│       │   ├── fact_orders.sql
│       │   └── schema.yml
│       └── finance/
│           ├── monthly_revenue.sql
│           └── schema.yml
├── tests/                   # Custom tests
│   ├── assert_order_totals_match.sql
│   └── assert_orders_after_registration.sql
├── macros/                  # Reusable code
│   ├── cents_to_dollars.sql
│   ├── get_payment_methods.sql
│   └── get_custom_schema.sql
└── dbt_project.yml         # Project configuration
```

## 🎯 dbt Studio Testing Features

This repository is specifically designed to test various dbt Studio capabilities:

1. **Model Lineage**: Complex dependency relationships between staging and mart models
2. **Data Catalog**: Rich documentation and column descriptions
3. **Test Results**: Comprehensive test suite with both passing and historical failing tests
4. **Macro Usage**: Custom macros for reusable business logic
5. **Seed Management**: CSV data loading and type specification
6. **Multi-layer Architecture**: Staging → Marts pattern
7. **Documentation**: Auto-generated docs with rich metadata

## 🔍 Sample Queries

After running the models, you can explore the data:

```sql
-- Top customers by revenue
SELECT customer_id, first_name, last_name, total_revenue, customer_segment
FROM dim_customers 
ORDER BY total_revenue DESC 
LIMIT 10;

-- Monthly revenue trend
SELECT month_year, total_revenue, completed_orders, unique_customers
FROM monthly_revenue 
ORDER BY month_year;

-- Product performance
SELECT product_name, category, sales_performance, total_quantity_sold, profit_margin_percent
FROM dim_products 
ORDER BY total_revenue DESC;
```

## 💡 dbt Studio Testing Scenarios

This project supports testing various dbt Studio workflows:

- **Model Development**: Edit and run individual models
- **Testing**: Run specific tests or full test suites
- **Documentation**: Browse lineage and column details
- **Debugging**: Investigate test failures and data quality issues
- **Collaboration**: Review model changes and impact analysis

## 📝 Notes

- The project uses DuckDB for simplicity and portability
- All data is synthetic and designed for testing purposes
- Models follow dbt best practices for structure and naming
- Tests demonstrate both basic and advanced dbt testing patterns

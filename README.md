# testdbt

A test repository for exploring dbt Studio functionality with realistic business data and models.

## Overview

This repository contains a complete dbt project with sample e-commerce data, including customers, products, orders, and order items. It's designed to provide a comprehensive testing environment for dbt Studio features including data modeling, testing, documentation, and analytics.

## Project Structure

```
├── models/
│   ├── staging/          # Clean and prepare raw data
│   │   ├── stg_customers.sql
│   │   ├── stg_products.sql
│   │   ├── stg_orders.sql
│   │   ├── stg_order_items.sql
│   │   └── schema.yml
│   └── marts/            # Business logic models
│       ├── customers/
│       │   └── customer_lifetime_value.sql
│       ├── finance/
│       │   ├── order_profitability.sql
│       │   └── product_performance.sql
│       └── schema.yml
├── seeds/                # Sample CSV data
│   ├── customers.csv
│   ├── products.csv
│   ├── orders.csv
│   └── order_items.csv
├── macros/               # Reusable SQL functions
│   └── calculate_profit_margin.sql
├── tests/                # Custom data tests
├── dbt_project.yml       # Project configuration
└── profiles.yml          # Database connection
```

## Sample Data

The project includes realistic e-commerce data:

- **Customers**: 10 customers with contact information and registration dates
- **Products**: 12 products across various categories (Electronics, Footwear, Appliances, etc.)
- **Orders**: 15 orders with different statuses (delivered, shipped, processing, cancelled)
- **Order Items**: 19 line items showing product quantities and pricing

## Models

### Staging Models (Views)
- `stg_customers`: Cleaned customer data with full names and status descriptions
- `stg_products`: Product data with profit margin calculations
- `stg_orders`: Order data with enhanced status tracking
- `stg_order_items`: Order line items with price validation

### Business Logic Models (Tables)
- `customer_lifetime_value`: Customer analytics with segmentation and lifetime value
- `order_profitability`: Financial analysis of order profitability and margins
- `product_performance`: Product sales performance and profitability metrics

## Getting Started

### Prerequisites
- Python 3.7+
- pip

### Installation
1. Clone this repository
2. Install dbt with DuckDB adapter:
   ```bash
   pip install dbt-core dbt-duckdb
   ```

### Running the Project
1. Load sample data:
   ```bash
   dbt seed --profiles-dir .
   ```

2. Run all models:
   ```bash
   dbt run --profiles-dir .
   ```

3. Run tests:
   ```bash
   dbt test --profiles-dir .
   ```

4. Generate documentation:
   ```bash
   dbt docs generate --profiles-dir .
   dbt docs serve --profiles-dir .
   ```

### dbt Studio Features to Test

This repository provides data and models to test various dbt Studio capabilities:

1. **Data Modeling**: Multiple staging and mart models with different materializations
2. **Testing**: Built-in data quality tests including uniqueness, not-null, and accepted values
3. **Documentation**: Comprehensive schema.yml files with descriptions
4. **Lineage**: Clear data lineage from seeds through staging to marts
5. **Macros**: Custom SQL functions for reusable logic
6. **Analytics**: Business metrics like customer lifetime value and product performance

### Key Metrics Available

- Customer segmentation (No Orders, Single Purchase, Regular Customer, Loyal Customer)
- Customer value segments (High/Medium/Low/No Value)
- Product sales performance (No/Low/Medium/High Sales)
- Order profitability and margin analysis
- Product profit margins and cost analysis

## Database Connection

The project uses DuckDB for easy local development. The database files (`dev.duckdb`, `prod.duckdb`) are created automatically and contain all your data and models.

## Notes for dbt Studio Testing

- All seed data is realistic and interconnected
- Models include business logic relevant to e-commerce analytics
- Tests cover data quality at multiple levels
- Documentation provides context for all models and columns
- Mixed materialization strategies (views for staging, tables for marts)
- Demonstrates common dbt patterns and best practices

# dbt Studio Testing Repository

This repository contains a comprehensive dbt project designed for testing dbt Studio functionality. It includes realistic e-commerce sample data, transformations, tests, and documentation to demonstrate various dbt features.

## 🎯 Purpose

Created specifically for testing dbt Studio capabilities including:
- Model lineage visualization
- Data catalog and documentation
- Test execution and results
- Macro and seed management
- Multi-layer data architecture

## 🚀 Quick Start

```bash
# Navigate to the dbt project
cd ecommerce_analytics

# Install dependencies
pip install dbt-duckdb

# Load sample data and run models
dbt seed
dbt run
dbt test

# Generate documentation
dbt docs generate
dbt docs serve
```

## 📊 What's Included

- **Sample E-commerce Data**: Customers, products, orders, and order items
- **Staging Models**: Data cleaning and standardization
- **Mart Models**: Customer and product dimensions, order facts, revenue analytics
- **Comprehensive Tests**: Schema tests, custom tests, and data quality checks
- **Documentation**: Rich model and column descriptions
- **Macros**: Reusable business logic functions

## 🏗️ Architecture

The project follows dbt best practices with a clear staging → marts data flow, demonstrating how to structure a production dbt project for optimal dbt Studio testing.

See the [full documentation](ecommerce_analytics/README.md) for detailed information about the project structure and features.
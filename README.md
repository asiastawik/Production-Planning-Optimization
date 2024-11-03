# Production Planning Optimization for Product X

## Project Overview

This project involves the development of an optimization model using the Gurobi solver in MATLAB to determine the optimal production plan for a company manufacturing product X over the next three months. The goal is to meet forecasted demand without delays while minimizing production and inventory costs. An extended version of the model also incorporates workforce adjustments, allowing for the hiring and firing of workers with associated costs.

## Problem Description

### Forecasted Demand

The forecasted demand for product X over the next three months is as follows:

- **April**: 35,000 units
- **May**: 20,000 units
- **June**: 40,000 units

### Production and Workforce Details

- The company employs **100 workers**, each capable of producing up to **25,000 units per month** under normal working hours.
- Each unit of X requires **0.5 hours** of production time.
- Workers can engage in **extra work**, producing up to **25 additional units** per worker per month.

### Initial Inventory

- Initial stock at the start of April: **1,500 units**.

### Cost Structure

1. **Production Costs**:
   - Normal work: **4.00€ / hour**
   - Extra work: **6.50€ / hour**

2. **Inventory Costs**:
   - **0.25€ / unit** per month for storing product X.

3. **Workforce Adjustment Costs**:
   - Hiring: **500.00€ / worker**
   - Firing: **750.00€ / worker**

## Project Objectives

1. **Develop an initial production model** to determine the optimal production schedule that meets the monthly demand without delays, while minimizing the total production and inventory costs.
2. **Extend the model** to include the possibility of hiring and firing workers, considering the associated costs and their impact on the overall production plan.

## Solution Approach

### Formulation of the Model

The project involves formulating a linear programming model with the following key decision variables:

- **Production in normal working hours** for each month.
- **Production in extra working hours** for each month.
- **Units carried in inventory** at the end of each month.
- **Number of workers hired or fired** at the start of each month.

### Constraints

The model includes constraints to:

- Ensure production meets or exceeds the demand for each month.
- Limit production to the available normal and extra work capacity.
- Track inventory levels month over month.
- Maintain feasible worker adjustments according to hiring and firing limits.

### Objective Function

The objective function minimizes the total cost, including:

- Cost of production (normal and extra hours).
- Inventory holding costs.
- Workforce adjustment costs (hiring and firing).

## Implementation in MATLAB

The model is implemented using MATLAB with the Gurobi solver for high-performance optimization. Gurobi's capabilities allow for efficiently solving large-scale linear programming problems, ensuring that the production plan is optimized for cost-effectiveness.

## Outcomes

- The project outputs the **optimal production schedule** for the next three months, detailing the number of units to be produced in normal and extra hours, inventory levels, and total costs.
- The extended model provides insights into workforce management, showcasing the cost-benefit analysis of hiring and firing strategies.

## Future Enhancements

- Incorporate demand uncertainty with stochastic programming to account for variability in forecasted demand.
- Extend the model to cover longer time horizons and include seasonal variations.
- Add constraints related to machine maintenance and downtime for a more realistic production schedule.

## Conclusion

This project provides a comprehensive optimization model to support strategic production planning, balancing production, inventory, and workforce costs. It serves as a robust tool for decision-makers to optimize operations, enhance cost-efficiency, and maintain seamless supply chain management.

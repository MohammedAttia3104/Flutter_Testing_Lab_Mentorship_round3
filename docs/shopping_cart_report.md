### Shopping Cart Report

This report outlines the issues found in the current implementation of the shopping cart system,
along with the tasks required to address these issues.

## Issues Found

| ID | Issue Description                                      | Severity | Status |
|----|--------------------------------------------------------|----------|--------|
| 1  | Duplicate items create new entries instead of updating | High     | Open   |
| 2  | Incorrect discount calculations                        | High     | Open   |
| 3  | Total amount calculation is inaccurate                 | Critical | Open   |
| 4  | No unit tests for shopping cart logic                  | Medium   | Open   |

## Tasks to Address Issues

1. **Update Item Quantity Logic**: Modify the logic to update the quantity of existing items in the
   cart instead of creating new entries when duplicate items are added.
2. **Fix Discount Calculation**: Review and correct the discount calculation logic to ensure
   accurate application of discounts.
3. **Correct Total Amount Calculation**: Ensure that the total amount reflects the correct sum of
   item prices, quantities, and applied discounts.
4. **Implement Unit Tests**: Develop a suite of unit tests to cover the shopping cart functionality,
   including adding items, updating quantities, applying discounts, and calculating totals.
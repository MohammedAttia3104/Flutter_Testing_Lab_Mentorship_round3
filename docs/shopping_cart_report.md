### Shopping Cart Report

This report reviews the current implementation of the shopping cart system, identifies key issues,
and documents the solutions applied to address them.

## Issues Identified

| ID | Issue Description                                      | Severity | Status |
|----|--------------------------------------------------------|----------|--------|
| 1  | Duplicate items create new entries instead of updating | High     | Fixed  |
| 2  | Incorrect discount calculations                        | High     | Fixed  |
| 3  | Total amount calculation is inaccurate                 | Critical | Fixed  |
| 4  | No unit tests for shopping cart logic                  | Medium   | Fixed  |

## Tasks and Solutions

1. **Update Item Quantity Logic**
    - **Problem:** Adding a duplicate item resulted in multiple entries rather than increasing the
      quantity.
    - **Solution:** Modified the `addItem` method to check for existing items and increment their
      quantity instead of adding a new entry.

2. **Fix Discount Calculation**
    - **Problem:** Discounts were not applied correctly, leading to inaccurate totals.
    - **Solution:** Reviewed and corrected the discount calculation logic in the cart state to
      ensure accurate application per item and for the cart total.

3. **Correct Total Amount Calculation**
    - **Problem:** The total amount did not reflect the correct sum after discounts.
    - **Solution:** Updated the total calculation to subtract the total discount from the subtotal,
      ensuring the final amount is accurate.

4. **Implement Unit Tests**
    - **Problem:** The shopping cart logic was not covered by automated tests.
    - **Solution:** Developed comprehensive unit tests for adding items, updating quantities,
      applying discounts, removing items, and clearing the cart. All tests now pass, validating the
      logic.

## Summary of Improvements

- The cart now updates item quantities instead of duplicating entries.
- Discount and total calculations are accurate and reflect the correct values.
- The codebase is more maintainable and readable.
- Unit tests ensure ongoing reliability and support future changes.

## Conclusion

The shopping cart system is now robust, with correct handling of item quantities, discounts, and
totals. Comprehensive unit tests provide confidence in the implementation and facilitate future
enhancements. All previously identified issues have been resolved.

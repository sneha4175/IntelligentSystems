;;;======================================================
;;; FINANCIAL FACTS
;;; Author: [YOUR NAME HERE]
;;; Date: February 10, 2025
;;;======================================================

(deffacts budget-thresholds
    "Budget allocation rules and thresholds"
    (max-rent-percent 30)
    (max-fixed-expenses-percent 60)
    (fifty-thirty-twenty-needs 50)
    (fifty-thirty-twenty-wants 30)
    (fifty-thirty-twenty-savings 20)
)

(deffacts debt-thresholds
    "Debt and interest rate facts"
    (high-interest-threshold 15)
    (credit-card-avg-apr 19.99)
    (student-loan-avg-apr 7)
    (risky-credit-utilization 30)
    (dangerous-credit-utilization 50)
)

(deffacts savings-targets
    "Emergency fund and savings goals"
    (emergency-fund-minimum 1000)
    (emergency-fund-months 3)
    (tfsa-limit-2025 7000)
)

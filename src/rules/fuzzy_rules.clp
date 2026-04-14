;;;======================================================
;;; FUZZY LOGIC RULES
; --- Disha section ---
;;; File: src/rules/fuzzy_rules.clp
;;; Authors: [Disha - Rules 1-4], Sneha Khoreja - Rules 5-8
;;; Date: April 2026
;;; Course: COMP 474/6741 - Intelligent Systems
;;; Description: Rules modeling possibilistic uncertainty
;;;              using Fuzzy Logic Theory for student
;;;              financial decision support system.
;;; Theory: Zadeh, L.A. (1965). Fuzzy Sets.
;;;         Information and Control, 8(3), 338-353.
;;;======================================================


;;; D2 TODO 3 - Possibilistic Uncertainty
;;; Author: Disha (Rules 1-4)
;;;======================================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Rule 1: Low Income + High Debt = Severe Risk
;;; Author: Disha
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule low-income-high-debt-severe-risk
    "Low income combined with high debt creates severe financial risk"
    (income low)
    (debt high)
    =>
    (printout t crlf "--- Fuzzy Rule Fired ---" crlf)
    (printout t "Rule: Low Income + High Debt" crlf)
    (printout t "Conclusion: SEVERE financial risk" crlf)
    (printout t "URGENT: Seek financial counseling immediately" crlf)
    (assert (financial-risk severe))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Rule 2: Low Income + Extreme Debt = Crisis
;;; Author: Disha
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule low-income-extreme-debt-crisis
    "Low income with extreme debt indicates financial crisis"
    (income low)
    (debt extreme)
    =>
    (printout t crlf "--- Fuzzy Rule Fired ---" crlf)
    (printout t "Rule: Low Income + Extreme Debt" crlf)
    (printout t "Conclusion: FINANCIAL CRISIS" crlf)
    (printout t "CRITICAL: Contact Concordia Student Services NOW" crlf)
    (printout t "Consider: Debt consolidation, income-driven repayment" crlf)
    (assert (financial-risk crisis))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Rule 3: Medium Income + Low Debt = Low Risk
;;; Author: Disha
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule medium-income-low-debt-safe
    "Medium income with low debt indicates manageable situation"
    (income medium)
    (debt low)
    =>
    (printout t crlf "--- Fuzzy Rule Fired ---" crlf)
    (printout t "Rule: Medium Income + Low Debt" crlf)
    (printout t "Conclusion: LOW financial risk" crlf)
    (printout t "Status: Finances are manageable" crlf)
    (assert (financial-risk low))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Rule 4: High Income + Moderate Debt = Manageable
;;; Author: Disha
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule high-income-moderate-debt-manageable
    "High income can handle moderate debt"
    (income high)
    (debt moderate)
    =>
    (printout t crlf "--- Fuzzy Rule Fired ---" crlf)
    (printout t "Rule: High Income + Moderate Debt" crlf)
    (printout t "Conclusion: Debt is MANAGEABLE" crlf)
    (printout t "Recommendation: Continue current repayment plan" crlf)
    (assert (financial-risk low))

)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Rule 5: Excellent Savings + Good Credit = Strong Position
;;; Structured English:
;;;   IF student savings fall in the EXCELLENT range ($5000+)
;;;   AND credit utilization falls in the GOOD range (15-35%)
;;;   THEN student is in a STRONG financial position
;;;   AND investing surplus is recommended
;;; Predicate Logic:
;;;   For all s: fuzzy-excellent(savings(s)) AND
;;;   fuzzy-good(credit(s)) => financialHealth(s, strong)
;;; Author: Sneha Khoreja
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule excellent-savings-good-credit
    "Excellent savings combined with good credit = strong financial position"
    (student-savings ?savings)
    (student-credit-utilization ?util)
    (fuzzy-savings-excellent-start ?s-start)
    (fuzzy-credit-good-low ?c-low)
    (fuzzy-credit-good-high ?c-high)
    (test (>= ?savings ?s-start))
    (test (>= ?util ?c-low))
    (test (<= ?util ?c-high))
    =>
    (assert (financial-health strong))
    (printout t crlf "--- Fuzzy Rule 5 Fired ---" crlf)
    (printout t "Rule: Excellent Savings + Good Credit" crlf)
    (printout t "Savings: $" ?savings
        " [Fuzzy: EXCELLENT]" crlf)
    (printout t "Credit Utilization: " ?util
        "% [Fuzzy: GOOD]" crlf)
    (printout t "Conclusion: STRONG financial position" crlf)
    (printout t "RECOMMENDATION: Consider investing surplus" crlf)
    (printout t "--------------------------" crlf)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Rule 6: Minimal Savings + Poor Credit = High Risk
;;; Structured English:
;;;   IF student savings fall in the MINIMAL range ($50-$1500)
;;;   AND credit utilization falls in the POOR range (50%+)
;;;   THEN student is at HIGH financial risk
;;;   AND emergency fund must be prioritized before anything else
;;; Predicate Logic:
;;;   For all s: fuzzy-minimal(savings(s)) AND
;;;   fuzzy-poor(credit(s)) => financialRisk(s, high)
;;; Author: Sneha Khoreja
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule minimal-savings-poor-credit
    "Minimal savings with poor credit utilization = high financial risk"
    (student-savings ?savings)
    (student-credit-utilization ?util)
    (fuzzy-savings-minimal-low  ?s-low)
    (fuzzy-savings-minimal-high ?s-high)
    (fuzzy-credit-poor-start    ?c-start)
    (test (>= ?savings ?s-low))
    (test (<= ?savings ?s-high))
    (test (>= ?util ?c-start))
    =>
    (assert (financial-risk high))
    (printout t crlf "--- Fuzzy Rule 6 Fired ---" crlf)
    (printout t "Rule: Minimal Savings + Poor Credit" crlf)
    (printout t "Savings: $" ?savings
        " [Fuzzy: MINIMAL]" crlf)
    (printout t "Credit Utilization: " ?util
        "% [Fuzzy: POOR]" crlf)
    (printout t "Conclusion: HIGH financial risk" crlf)
    (printout t "Priority 1: Build emergency fund to $1000" crlf)
    (printout t "Priority 2: Reduce credit utilization below 30%" crlf)
    (printout t "--------------------------" crlf)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Rule 7: No Savings = Financially Vulnerable
;;; Structured English:
;;;   IF student savings fall in the NONE range (below $100)
;;;   THEN student is FINANCIALLY VULNERABLE
;;;   AND any unexpected expense will cause a crisis
;;; Predicate Logic:
;;;   For all s: fuzzy-none(savings(s))
;;;   => financialHealth(s, vulnerable)
;;; Author: Sneha Khoreja
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule no-savings-vulnerable
    "Near-zero savings = student is financially vulnerable"
    (student-savings ?savings)
    (fuzzy-savings-none-zero ?threshold)
    (test (< ?savings ?threshold))
    =>
    (assert (financial-health vulnerable))
    (printout t crlf "--- Fuzzy Rule 7 Fired ---" crlf)
    (printout t "Rule: No Savings" crlf)
    (printout t "Savings: $" ?savings
        " [Fuzzy: NONE]" crlf)
    (printout t "Conclusion: FINANCIALLY VULNERABLE" crlf)
    (printout t "Any unexpected expense becomes a crisis" crlf)
    (printout t "URGENT: Save $1000 minimum emergency fund first" crlf)
    (printout t "RECOMMENDATION: Cut all discretionary spending" crlf)
    (printout t "--------------------------" crlf)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Rule 8: Adequate Savings + Excellent Credit = Investment Ready
;;; Structured English:
;;;   IF student savings fall in the ADEQUATE range ($1000-$6000)
;;;   AND credit utilization falls in the EXCELLENT range (below 20%)
;;;   THEN student is READY for investing
;;;   AND TFSA contributions are recommended
;;; Predicate Logic:
;;;   For all s: fuzzy-adequate(savings(s)) AND
;;;   fuzzy-excellent(credit(s)) => investmentReady(s, yes)
;;; Author: Sneha Khoreja
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule adequate-savings-excellent-credit-invest
    "Adequate savings with excellent credit = ready to start investing"
    (student-savings ?savings)
    (student-credit-utilization ?util)
    (fuzzy-savings-adequate-low  ?s-low)
    (fuzzy-savings-adequate-high ?s-high)
    (fuzzy-credit-excellent-zero ?c-zero)
    (test (>= ?savings ?s-low))
    (test (<= ?savings ?s-high))
    (test (< ?util ?c-zero))
    =>
    (assert (investment-ready yes))
    (printout t crlf "--- Fuzzy Rule 8 Fired ---" crlf)
    (printout t "Rule: Adequate Savings + Excellent Credit" crlf)
    (printout t "Savings: $" ?savings
        " [Fuzzy: ADEQUATE]" crlf)
    (printout t "Credit Utilization: " ?util
        "% [Fuzzy: EXCELLENT]" crlf)
    (printout t "Conclusion: READY for investing" crlf)
    (printout t "RECOMMENDATION: Start TFSA contributions" crlf)
    (printout t "Consider: Low-cost index funds for long-term growth" crlf)
    (printout t "--------------------------" crlf)

; --- Sneha section ---


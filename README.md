# Student Financial Decision-Support System

A rule-based **expert system** built in CLIPS that advises students on budgeting,
debt management, credit health, and investment readiness. Written for
**COMP 474/6741 — Intelligent Systems** (Concordia University, Winter 2026).

> This repository is a fork of
> [DishaPadshala/IntelligentSystems](https://github.com/DishaPadshala/IntelligentSystems).
> It is a **group project** by **Sneha Khoreja** and **Disha Padshala**.
> See [Team & Contributions](#team--contributions) for who built what.

---

## Overview

The system takes a student's financial profile (income, rent, expenses, savings,
debt, credit utilization) as **facts** and applies a **rule base** to produce
plain-language recommendations — for example, warning that rent exceeds 30% of
income, flagging high-interest debt to pay down first, or confirming the student
is ready to open a TFSA.

It is a *symbolic, explainable* AI system: every recommendation traces back to
the specific rules and thresholds that fired, so a user can see **why** the
advice was given. There is no training data and no black box — the knowledge is
written down as human-readable rules sourced from public financial guidelines
(FCAC, Equifax Canada, CFPB) and financial-literacy research.

**Scope:** 28 facts / 44 rules (Deliverable 2), roughly 1,000 lines of CLIPS
across the fact base and rule base.

---

## The AI Paradigm

The system combines three classic knowledge-based AI techniques.

### 1. Forward-chaining production rules

The core engine is a **production system**: knowledge is encoded as
`IF conditions THEN actions` rules (`defrule`). CLIPS uses **forward chaining** —
it starts from the known facts and repeatedly fires whichever rules have their
conditions satisfied, asserting new facts, until nothing more can fire. This is
**data-driven** reasoning: we push forward from what we know toward conclusions,
rather than starting from a goal and working backward.

```
Facts (student profile)  ──►  Rule engine (match → fire → assert)  ──►  Advice
```

### 2. Certainty factors (MYCIN-style)

Financial advice is rarely black-and-white. **Certainty factors (CFs)**, from the
MYCIN medical expert system (Shortliffe, 1976), attach a *degree of belief*
between 0.0 and 1.0 to a conclusion. For example, "a 6-month emergency fund
implies investment readiness" carries **CF = 0.90** (near-certain), while a
3-month fund carries **CF = 0.70** (moderate). CFs are **not probabilities** —
they express how strongly the evidence supports a conclusion, and they let the
system say "probably" instead of forcing a hard yes/no.

### 3. Fuzzy logic

Real thresholds are fuzzy: is $1,499 in savings "minimal" and $1,501 "adequate"?
**Fuzzy logic** (Zadeh, 1965) replaces sharp boundaries with **linguistic
variables** — `savings` ∈ {none, minimal, adequate, excellent},
`credit` ∈ {excellent, good, fair, poor} — defined by overlapping membership
functions. A savings amount can belong *partially* to two categories at once,
which mirrors how a human advisor actually reasons about "roughly enough."

---

## Architecture

Facts (the *what*) are deliberately separated from rules (the *how to reason*).
This keeps domain thresholds editable in one place without touching inference
logic — a standard knowledge-engineering practice.

```
src/
├── facts/
│   ├── financial_facts.clp    # Core thresholds: budget %, debt/credit, savings targets
│   ├── certainty_facts.clp    # CF weights for stress, default risk, investment readiness
│   └── fuzzy_facts.clp        # Membership-function parameters + fuzzy templates
├── rules/
│   ├── financial_rules.clp    # D1 crisp rules: budgeting, rent, debt, credit, TFSA
│   ├── certainty_rules.clp    # CF rules: financial stress, default risk, investment readiness
│   └── fuzzy_rules.clp        # Fuzzy rules: savings × credit and income × debt combinations
├── demo.clp                   # Loads facts + rules with a full sample student profile
└── test_scenario.clp          # Standalone test student for validation

docs/
├── D1_IMPROVEMENTS.md         # Deliverable-1 feedback and how D2 addressed each item
└── IMPLEMENTATION.md          # Implementation progress notes
```

**Separation of concerns:**
- **Facts** hold tunable domain knowledge (e.g. `max-rent-percent 30`,
  `ready-cf emergency-fund-6months 0.90`, `fuzzy-savings-adequate-low 1000`).
- **Rules** hold the reasoning. A budgeting analyst can adjust a threshold in the
  fact base without ever reading the rule logic.

---

## How to Run

The crisp (D1) and certainty-factor layers run in standard **CLIPS**. The fuzzy
layer uses `deftemplate` membership functions and requires **FuzzyCLIPS**.

**Crisp + certainty-factor demo (CLIPS):**

```clips
; from the repository root
(load "src/facts/financial_facts.clp")
(load "src/rules/financial_rules.clp")
(load "src/test_scenario.clp")
(reset)
(run)
```

Or load the bundled demo profile:

```clips
(load "src/demo.clp")
(reset)
(run)
```

**Fuzzy + certainty layers (FuzzyCLIPS):**

```clips
(load "src/facts/fuzzy_facts.clp")
(load "src/facts/certainty_facts.clp")
(load "src/rules/fuzzy_rules.clp")
(load "src/rules/certainty_rules.clp")
(reset)
(run)
```

Get CLIPS/FuzzyCLIPS: https://clipsrules.net (FuzzyCLIPS is a fuzzy-logic
extension of the CLIPS shell).

---

## Example

A student earning $1,500/month with $700 rent, $100 savings, and $5,000 debt
triggers rules such as:

```
WARNING: Rent is 47% of income (threshold: 30%)
PRIORITY: Pay down high-interest debt first (18% APR)
WARNING: Credit utilization 45% — risky range (30–50%)
[Fuzzy] Minimal savings — build $1000 emergency fund before investing
```

Every line is traceable to the rule and threshold that produced it.

---

## Team & Contributions

This is a **group project**, forked from Disha Padshala's repository. Attribution
below reflects the actual commit history.

| Contributor | Role |
|---|---|
| **Disha Padshala** ([@DishaPadshala](https://github.com/DishaPadshala)) | Repository origin; crisp financial rule base; certainty rules 1–4; fuzzy rules 1–4; income/debt fuzzy templates; integrated demo |
| **Sneha Khoreja** ([@sneha4175](https://github.com/sneha4175)) | Core fact base; certainty rules 5–7 and their CF facts; fuzzy rules 5–8 and savings/credit membership parameters; Deliverable-2 merge integration |
| Siya Patel ([@Siyapatel2704](https://github.com/Siyapatel2704)) | Early edits to the financial rule file |

**Sneha Khoreja's specific contributions:**
- **`src/facts/financial_facts.clp`** — the core fact base (budget, debt/credit,
  and savings thresholds).
- **Certainty rules 5–7** in `src/rules/certainty_rules.clp` — investment-readiness
  (high/moderate confidence) and budget-success prediction — plus the matching
  CF facts in `src/facts/certainty_facts.clp`.
- **Fuzzy rules 5–8** in `src/rules/fuzzy_rules.clp` — savings × credit
  combinations — plus the **savings and credit-health membership parameters** in
  `src/facts/fuzzy_facts.clp`.
- Early crisp rules on high-interest debt and credit-utilization warnings, and
  resolving the **Deliverable-2 merge** that combined both members' work.

---

## Graded Outcome

**Deliverable 1: 117/140 (83.5%).** Feedback centered on repository structure,
system size, and demo interactivity. Deliverable 2 addressed these by
reorganizing the folder hierarchy, expanding to 28 facts / 44 rules, and adding
the certainty-factor and fuzzy-logic layers. See
[`docs/D1_IMPROVEMENTS.md`](docs/D1_IMPROVEMENTS.md) for the full feedback-to-fix
mapping.

---

## References

- Shortliffe, E. H. (1976). *Computer-Based Medical Consultations: MYCIN.* Elsevier.
- Zadeh, L. A. (1965). Fuzzy Sets. *Information and Control*, 8(3), 338–353.
- Financial Consumer Agency of Canada (FCAC) — emergency-fund and budgeting guidelines.
- Equifax Canada / CFPB — credit-utilization thresholds.

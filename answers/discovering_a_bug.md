# Prompt

Suppose we discover a bug with our algorithm and investors for two deals had incorrect
allocations. This means that some of the investors ended up investing more than they were allowed to
while others invested less than they were allowed to. One of deals happened two years ago and the
other one happened two weeks ago. Please describe, in detail, how would you go about correcting this
issue and how would you communicate this to the affected customers.

# Response

## 1. INVESTIGATE & VERIFY

### Goal: Understand the extent and root cause of the bug.
- **Reproduce the bug** in a safe environment.
- **Audit historical allocations** for the affected deals — compare actual invested amounts to what should’ve been allocated based on correct proration logic.
- Identify:
  - Which investors over-invested and by how much.
  - Which investors under-invested and by how much.
- Determine **how the bug was introduced** (e.g., bad rounding logic, misinterpretation of historical averages, faulty formula, etc.).
- Check whether **other deals** might have been affected using the same logic.
- What are the learnings
- What are the actions from the learnings

---

## 2. CORRECT THE ISSUE
### Goal: Make things right in a fair, transparent, and legal way.

### For the recent deal (2 weeks ago):
- **Under-allocated investors**: If there's still room in the startup's cap table or you can adjust post-facto, offer to increase their allocation (with their consent and coordination with the startup).
- **Over-allocated investors**: If possible, refund the overage, or offer a choice between:
  - keeping the excess as an intentional oversubscription,
  - or reallocating to another deal.

### For the old deal (2 years ago):
- Changing past allocations is tricky (might involve tax or legal complications), so:
  - Consider **compensating under-allocated investors** with fee discounts, priority allocations in upcoming deals, or direct credit.
  - For **over-allocated investors**, you likely *can’t* change the allocation retroactively, so just acknowledge the error but let them keep the stake.

---

## 3. COMMUNICATE WITH CUSTOMERS
### Goal: Be transparent, build trust, and make amends.

### Principles:
- Honest and humble tone — take full responsibility.
- Empathy — acknowledge that this impacts their financial decisions.
- Concrete — clearly explain what happened and how you're fixing it.
- Offer options — let them choose the most comfortable resolution where possible.

---

### Email Customers (Recent Deal)

**Subject:** Correction to Your Investment Allocation in [Startup Name]

> Dear [Investor Name],
>
> We’re reaching out to inform you of a recent discovery affecting your investment in [Startup Name].
>
> Due to a bug in our allocation algorithm, your investment amount was [over/under] the correct prorated amount based on your historical average investment. This occurred as part of a broader issue impacting two deals.
>
> Specifically, your request was for $X, and you were allocated $Y. The correct amount should have been $Z. We're sincerely sorry for this error.
>
> We’re offering [explanation of options — e.g., refund of the difference / option to increase allocation / compensation credit]. Please let us know how you’d like to proceed.
>
> We're taking this very seriously and have already fixed the root issue and audited all other deals to ensure this was an isolated incident.
>
> Thank you for your continued trust. If you have any questions, we're happy to hop on a call to talk through the details.
>
> Sincerely,  
> [Your Name]  
> [Your Title]  
> [Your Contact Info]

---

### Example Email (Old Deal)

**Subject:** Update Regarding Past Investment Allocation in [Startup Name]

> Dear [Investor Name],
>
> We recently discovered a past error in our allocation system that impacted your investment in [Startup Name], which closed in [Month, Year].
>
> Due to a bug, your allocation differed from what it should have been based on our standard proration logic. While it’s not possible to change the historical allocation now, we want to acknowledge the issue and make it right.
>
> As a token of our commitment to fairness, we’re offering [compensation — e.g., priority access to upcoming deals / fee credit / donation in their name].
>
> We’ve already fixed the root issue and have audited our system to ensure no other deals are affected.
>
> We appreciate your understanding and continued support. Please feel free to reach out with any questions or concerns.
>
> Sincerely,  
> [Your Name]

---

## 4. PREVENTATIVE MEASURES AND EXAMPLE ACTIONS
- Add **automated verification tests** for future proration logic.
- Implement **audit trails** on allocations.
- Review code in pair or via formal PR process for sensitive calculations.
- Consider **a human QA review** before closing future deals, especially when allocation is tight.

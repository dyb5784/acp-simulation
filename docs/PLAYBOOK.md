# 📘 Practitioner's Playbook: Kimi For Coding & Roo Code (v4.0.0)

**Core Objective:** Operationalize the **Agent-Tuned** `kimi-for-coding` model to achieve 92% task completion at minimal cost.

---

## ⚙️ Part I: The Golden Configuration

**⚠️ Update:** We now exclusively recommend the **Kimi For Coding** endpoint over the Open Platform.

### 1. Roo Code Provider Settings
| Setting | Value | Rationale |
| :--- | :--- | :--- |
| **Provider** | `OpenAI Compatible` | Standard protocol. |
| **Base URL** | `https://api.kimi.com/coding/v1` | **Critical:** Use the agent-tuned endpoint. |
| **API Key** | `sk-kimi-...` | From your Membership Dashboard. |
| **Model ID** | `kimi-for-coding` | Optimized for 18+ step loops. |
| **Max Output** | `16384` | The efficiency "sweet spot". |
| **Reasoning** | `Medium` | Maps to the standard "Thinking" profile. |

---

## 🧠 Part II: Token Efficiency Strategy

### 1. The "18-Step" Horizon
Empirical data shows reliability drops after 18 steps.
* **Tactic:** If a task requires >18 steps, the Orchestrator MUST break it into sub-tasks.

### 2. Context Bias (Top & Tail)
Kimi favors the first 25% and last 25% of context.
* **Tactic:** Load critical architecture files (`CONTEXT.md`) *first*. Keep the current error log *last*.

### 3. The "Tab-Key" Toggle
You do not need separate profiles for "Reasoning" and "Turbo."
* **High Value:** Use `Reasoning: Medium` (Default).
* **Low Value:** Toggle Reasoning to `Low` (Turbo) for rote tasks like writing tests.

---

## 💰 Part III: Cost Governance

**Pricing:** ~0.3¢ / 1k tokens ($3.00 / 1M).
**Alert Rule:** If `reasoning_tokens` > 40% of total completion, you are over-thinking. Clamp `max_tokens` or toggle to Turbo.

---

## ✅ Part IV: The "Go-Live" Checklist

1. [ ] **Endpoint:** `api.kimi.com/coding/v1` verified.
2. [ ] **Model:** `kimi-for-coding` selected.
3. [ ] **Output Clamp:** Set to `16384`.
4. [ ] **Legacy Format:** Enabled in Roo Advanced settings.
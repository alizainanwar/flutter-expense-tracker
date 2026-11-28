# Flutter Expense Tracker

A simple Flutter app to track daily expenses.
Built in 4 days — one small, clean step every day. Code is kept easy and minimal.

## Features

- [x] Home UI with total spent card and expense list (Day 1)
- [x] Add-expense form (Day 2)
- [x] Local storage + categories filter (Day 3)
- [x] Edit / delete + monthly summary + final polish (Day 4)

## 4-Day Plan

| Day | Work |
|-----|------|
| Day 1 | Project setup, Expense model, Home UI |
| Day 2 | Add-expense form (title, amount, category, date) |
| Day 3 | GetX migration + local storage + category filter |
| Day 4 | Edit / delete + monthly summary + final polish |

## Architecture

- All screens are `StatelessWidget` only — no `StatefulWidget` screens.
- State with **GetX**: `GetXController` + `Rx` values, `Obx` for UI updates,
  dependency injection with `Get.put` / `Get.find`.
- Reusable widgets live in `lib/widgets/` (`CustomTextField`, `CustomButton`,
  `TotalSpentCard`, `ExpenseTile`, `MonthlySummaryCard`) and are used
  everywhere instead of duplicated UI code.
- Editing reuses the same add-expense form (`AddExpenseScreen` +
  `AddExpenseController`) — no second form.
- Local storage with **GetStorage**: expenses are saved as JSON and loaded
  on startup, so they survive an app restart.

## Getting started

```bash
flutter pub get
flutter run
```

## Tech

- Flutter + Dart
- `get` (GetX) for state management and navigation
- `get_storage` for simple local storage
- `intl` for date formatting

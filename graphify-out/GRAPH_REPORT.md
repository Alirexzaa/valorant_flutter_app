# Graph Report - new_block  (2026-10-14)

## Corpus Check
- cluster-only mode — file stats not available

## Summary
- 75 nodes · 86 edges · 10 communities (6 shown, 4 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- main.dart
- todo_page.dart
- todo_remote_cubit_test.dart
- manifest.json
- todo_remote_cubit.dart
- todo_cubit.dart
- MainActivity.kt

## God Nodes (most connected - your core abstractions)
1. `TodoCubit` - 7 edges
2. `CounterCubit` - 5 edges
3. `_TodoPageState` - 4 edges
4. `CounterPage` - 3 edges
5. `TodoPage` - 3 edges
6. `TodoRemoteCubit` - 3 edges
7. `TodoRepository` - 3 edges
8. `MockTodoRepository` - 3 edges
9. `MainActivity` - 2 edges
10. `build` - 2 edges

## Surprising Connections (you probably didn't know these)
- `MockTodoRepository` --implements--> `TodoRepository`  [EXTRACTED]
  test/todo_remote_cubit_test.dart → lib/todo/todo_repository.dart
- `build` --references--> `CounterCubit`  [EXTRACTED]
  lib/counter/counter_page.dart → lib/counter/counter_cubit.dart
- `build` --references--> `TodoCubit`  [EXTRACTED]
  lib/todo/todo_page.dart → lib/todo/todo_cubit.dart
- `_submit` --references--> `TodoCubit`  [EXTRACTED]
  lib/todo/todo_page.dart → lib/todo/todo_cubit.dart
- `CounterPage` --references--> `CounterCubit`  [EXTRACTED]
  lib/counter/counter_page.dart → lib/counter/counter_cubit.dart

## Import Cycles
- None detected.

## Communities (10 total, 4 thin omitted)

### Community 0 - "main.dart"
Cohesion: 0.17
Nodes (8): CounterCubit, decrement, increment, build, CounterPage, build, main, MyApp

### Community 1 - "todo_page.dart"
Cohesion: 0.18
Nodes (9): TodoCubit, build, _controller, createState, dispose, _submit, TodoPage, _TodoPageState (+1 more)

### Community 2 - "todo_remote_cubit_test.dart"
Cohesion: 0.20
Nodes (3): main, main, mockRepository

### Community 3 - "manifest.json"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 4 - "todo_remote_cubit.dart"
Cohesion: 0.22
Nodes (5): loadTodos, repository, fetchTodos, TodoRepository, MockTodoRepository

### Community 5 - "todo_cubit.dart"
Cohesion: 0.29
Nodes (5): addTodo, clearAll, normalize, removeTodo, s

## Knowledge Gaps
- **18 isolated node(s):** `decrement`, `increment`, `build`, `main`, `_controller` (+13 more)
  These have ≤1 connection - possible missing edges. (Counts symbols only; 42 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **4 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `MockTodoRepository` connect `todo_remote_cubit.dart` to `todo_remote_cubit_test.dart`?**
  _High betweenness centrality (0.115) - this node is a cross-community bridge._
- **What connects `decrement`, `increment`, `build` to the rest of the system?**
  _18 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Why does `TodoCubit` connect `todo_page.dart` to `todo_cubit.dart`?**
  _High betweenness centrality (0.051) - this node is a cross-community bridge._
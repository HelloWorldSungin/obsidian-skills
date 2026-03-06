# Obsidian Bases Syntax Summary

Source: https://help.obsidian.md/bases/syntax

## Overview

Obsidian Bases are `.base` files that organize vault data through filters, formulas, and customizable views. The syntax is valid YAML with five main sections: **filters**, **formulas**, **properties**, **summaries**, and **views**.

---

## Key Features

### 1. Filters

By default, a base includes every file in the vault. Filters narrow down the dataset.

- **Two levels**: Global filters (apply to all views) and view-level filters (apply to a single view). Both are concatenated with AND during evaluation.
- **Logical operators**: `and`, `or`, `not` -- these accept lists of filter statements or nested filter objects.
- **Filter statements**: Evaluate to truthy/falsey using comparison operators or built-in functions.

Example:
```yaml
filters:
  or:
    - file.hasTag("tag")
    - and:
        - file.hasTag("book")
        - file.hasLink("Textbook")
    - not:
        - file.hasTag("book")
        - file.inFolder("Required Reading")
```

### 2. Formulas

Computed properties defined in the base file. Support arithmetic, built-in functions, and cross-referencing other formula properties (no circular references).

```yaml
formulas:
  formatted_price: 'if(price, price.toFixed(2) + " dollars")'
  ppu: "(price / age).toFixed(2)"
```

Property reference syntax:
- **Note properties**: `note.price` or just `price` (shorthand)
- **File properties**: `file.size`, `file.ext`, etc.
- **Formula properties**: `formula.formatted_price`

### 3. Properties Configuration

Stores display configuration per property (e.g., display names for table column headers).

```yaml
properties:
  status:
    displayName: Status
  formula.formatted_price:
    displayName: "Price"
```

### 4. Summaries

Custom aggregation formulas applied across all rows. The keyword `values` provides a list of all values for a property.

```yaml
summaries:
  customAverage: 'values.mean().round(3)'
```

15 built-in summary formulas:

| Name | Input Type | Description |
|------|-----------|-------------|
| Average | Number | Mathematical mean |
| Min | Number | Smallest number |
| Max | Number | Largest number |
| Sum | Number | Sum of all numbers |
| Range | Number | Difference between Max and Min |
| Median | Number | Mathematical median |
| Stddev | Number | Standard deviation |
| Earliest | Date | Earliest date |
| Latest | Date | Latest date |
| Range | Date | Difference between Latest and Earliest |
| Checked | Boolean | Count of true values |
| Unchecked | Boolean | Count of false values |
| Empty | Any | Count of empty values |
| Filled | Any | Count of non-empty values |
| Unique | Any | Count of unique values |

### 5. Views

Define how data is rendered. Multiple views per base, each with its own filters, grouping, sorting, and summaries.

```yaml
views:
  - type: table
    name: "My table"
    limit: 10
    groupBy:
      property: note.age
      direction: DESC
    filters:
      and:
        - 'status != "done"'
    order:
      - file.name
      - note.age
    summaries:
      formula.ppu: Average
```

Key view options: `type`, `name`, `limit`, `groupBy` (property + direction), `filters`, `order`, `summaries`.

---

## Property Types

### Note Properties
Stored in YAML frontmatter. Access via `note.author` or shorthand `author`.

### File Properties

| Property | Type | Description |
|----------|------|-------------|
| `file.backlinks` | List | Backlink files (performance heavy) |
| `file.ctime` | Date | Created time |
| `file.embeds` | List | All embeds in the note |
| `file.ext` | String | File extension |
| `file.file` | File | File object |
| `file.folder` | String | Folder path |
| `file.links` | List | All internal links (including frontmatter) |
| `file.mtime` | Date | Modified time |
| `file.name` | String | File name |
| `file.path` | String | File path |
| `file.properties` | Object | All properties on the file |
| `file.size` | Number | File size |
| `file.tags` | List | All tags (content + frontmatter) |

### The `this` Object
Context-dependent reference:
- **Main content area**: refers to the base file itself
- **Embedded in another file**: refers to the embedding file
- **In a sidebar**: refers to the active file in the main content area

---

## Operators

### Arithmetic
`+`, `-`, `*`, `/`, `%`, `( )`

### Comparison
`==`, `!=`, `>`, `<`, `>=`, `<=`

### Boolean
`!` (not), `&&` (and), `||` (or)

### Date Arithmetic
Add/subtract durations from dates using strings:
- Units: `y`/`year`/`years`, `M`/`month`/`months`, `d`/`day`/`days`, `w`/`week`/`weeks`, `h`/`hour`/`hours`, `m`/`minute`/`minutes`, `s`/`second`/`seconds`
- Examples: `now() + "1 day"`, `file.mtime > now() - "1 week"`, `date("2024-12-01") + "1M" + "4h"`

---

## Data Types

| Type | Notes |
|------|-------|
| String | Enclosed in single or double quotes |
| Number | Digits, optionally in parentheses |
| Boolean | `true` or `false` (unquoted) |
| Date | Construct with `date()`, modify with duration arithmetic |
| List | Create with `list()`, access with `[index]` (0-based) |
| Object | Access with dot notation or brackets |
| Link | Auto-recognized from wikilinks in frontmatter; construct with `link()` |
| File | Convert to link with `file.asLink()` |

---

## Filter Syntax Quick Reference

```yaml
# Tag filter
file.hasTag("mytag")

# Folder filter
file.inFolder("MyFolder")

# Link filter
file.hasLink("SomeNote")

# Property comparison
'status != "done"'
"price > 2.1"
"formula.ppu > 5"

# Date filter
file.mtime > now() - "1 week"

# Combine with and/or/not
filters:
  and:
    - file.hasTag("project")
    - 'status != "done"'
  or:
    - "priority == 1"
    - "priority == 2"
  not:
    - file.inFolder("Archive")
```

---

*Extracted using defuddle-cli from https://help.obsidian.md/bases/syntax on 2026-03-06.*

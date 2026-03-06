# Obsidian Bases Syntax -- Summary

Source: https://help.obsidian.md/bases/syntax

Bases are `.base` files written in YAML. They define filters, formulas, properties, summaries, and views to create database-like views over vault files.

---

## File Structure

A `.base` file has five top-level sections:

```yaml
filters:     # Global filters (apply to all views)
formulas:    # Computed/calculated properties
properties:  # Display configuration (e.g., column headers)
summaries:   # Custom aggregate functions
views:       # One or more view definitions
```

---

## Filters

By default, a base includes **every file in the vault**. Filters narrow the dataset.

### Where filters apply

- **Global level** (`filters:`) -- applies to all views.
- **View level** (`views[].filters:`) -- applies only to that view.
- When both exist, they are concatenated with AND.

### Filter structure

Filters use recursive logical operators (`and`, `or`, `not`) containing either nested filter objects or filter statements (strings that evaluate to true/false).

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

A filter statement can be:
- A **comparison** using arithmetic operators (e.g., `"price > 2.1"`).
- A **function call** (e.g., `file.hasTag("book")`).

---

## Formulas

Formula properties are calculated values defined in the base, displayed across all views.

```yaml
formulas:
  formatted_price: 'if(price, price.toFixed(2) + " dollars")'
  ppu: "(price / age).toFixed(2)"
```

### Property references in formulas

| Prefix | Type | Example |
|--------|------|---------|
| `note.` (or no prefix) | Frontmatter property | `note.price`, `price` |
| `file.` | File metadata | `file.size`, `file.ext` |
| `formula.` | Another formula | `formula.formatted_price` |

Formulas can reference other formulas (no circular references allowed). Output data type is determined by the underlying data and return value of functions used. Stored as YAML strings.

---

## Properties (Display Config)

Controls how properties are displayed (e.g., column headers in table views). Display names are **not** used in filters or formulas.

```yaml
properties:
  status:
    displayName: Status
  formula.formatted_price:
    displayName: "Price"
  file.ext:
    displayName: Extension
```

---

## Summaries

Aggregate functions that compute statistics across all rows.

### Custom summaries

```yaml
summaries:
  customAverage: 'values.mean().round(3)'
```

The `values` keyword is a list of all values for that property across every note in the result set.

### Default summary formulas

| Name | Input Type | Description |
|------|-----------|-------------|
| Average | Number | Mathematical mean |
| Min | Number | Smallest number |
| Max | Number | Largest number |
| Sum | Number | Sum of all numbers |
| Range | Number | Max minus Min |
| Median | Number | Mathematical median |
| Stddev | Number | Standard deviation |
| Earliest | Date | Earliest date |
| Latest | Date | Latest date |
| Range | Date | Latest minus Earliest |
| Checked | Boolean | Count of true values |
| Unchecked | Boolean | Count of false values |
| Empty | Any | Count of empty values |
| Filled | Any | Count of non-empty values |
| Unique | Any | Count of unique values |

---

## Views

Each entry in `views` defines a separate rendering of the same filtered data.

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
        - or:
            - "formula.ppu > 5"
            - "price > 2.1"
    order:
      - file.name
      - file.ext
      - note.age
    summaries:
      formula.ppu: Average
```

| Key | Purpose |
|-----|---------|
| `type` | View type (e.g., `table`; plugins can add more) |
| `name` | Display name; can define the default view |
| `filters` | View-specific filters (same syntax as global) |
| `groupBy` | Group rows by a property (`property` + `direction`) |
| `order` | Column/property display order |
| `limit` | Max rows to display |
| `summaries` | Map property names to named summary formulas |

---

## File Properties Reference

Available for all file types (not just Markdown).

| Property | Type | Description |
|----------|------|-------------|
| `file.backlinks` | List | Backlink files (performance heavy; prefer `file.links`) |
| `file.ctime` | Date | Created time |
| `file.embeds` | List | All embeds in the note |
| `file.ext` | String | File extension |
| `file.file` | File | File object (for use in specific functions) |
| `file.folder` | String | Path of the file folder |
| `file.links` | List | All internal links (including frontmatter) |
| `file.mtime` | Date | Modified time |
| `file.name` | String | File name |
| `file.path` | String | Full file path |
| `file.properties` | Object | All frontmatter properties |
| `file.size` | Number | File size |
| `file.tags` | List | All tags (content + frontmatter) |

---

## The `this` Object

`this` refers to different files depending on where the base is displayed:

| Context | `this` refers to |
|---------|-----------------|
| Main content area | The base file itself |
| Embedded in another note | The embedding file |
| Sidebar | The active file in the main area |

Example: `file.hasLink(this.file)` in a sidebar replicates the backlinks pane.

---

## Operators

### Arithmetic

`+`, `-`, `*`, `/`, `%`, `( )`

### Comparison

`==`, `!=`, `>`, `<`, `>=`, `<=`

Works with numbers and dates. `==` and `!=` work with any value type.

### Boolean

`!` (not), `&&` (and), `||` (or)

### Date Arithmetic

Add/subtract durations from dates using `+` and `-`:

```
date + "1M"        # Add 1 month
date - "2h"        # Subtract 2 hours
now() + "1 day"    # 24 hours from now
```

Duration units: `y`/`year`/`years`, `M`/`month`/`months`, `d`/`day`/`days`, `w`/`week`/`weeks`, `h`/`hour`/`hours`, `m`/`minute`/`minutes`, `s`/`second`/`seconds`.

Key functions: `today()` (current date), `now()` (current datetime).

Subtracting two dates returns the difference in milliseconds.

---

## Data Types

| Type | Syntax |
|------|--------|
| String | `"message"` or `'message'` |
| Number | `1`, `2.5`, `(2.5)` |
| Boolean | `true`, `false` (no quotes) |
| Date | `date("2025-01-01 12:00:00")` |
| Duration | `"1 hour"`, `"7d"`, `"1M"` |
| List | `list(element)` to wrap single values; access with `property[0]` |
| Object | Access with `property.subprop` or `property["subprop"]` |
| Link | `link("filename")`, `link("https://obsidian.md")`, `link("file", "display text")`, `link("file", icon("plus"))` |

Links are compared with `==`/`!=` based on resolved file (or link text if unresolved). Links can be compared to files (e.g., `author == this`). Use `file.asLink()` to convert a File to a Link.

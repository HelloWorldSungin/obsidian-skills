# Obsidian Bases Syntax Summary

> Source: https://help.obsidian.md/bases/syntax
> Extracted: 2026-03-06

## What Are Bases?

Bases is a core Obsidian plugin that provides database-like views of your notes. All data lives in Markdown files and their YAML frontmatter properties. Views are defined in `.base` files (valid YAML) or embedded in code blocks within Markdown documents.

**View types:** Table, List, Cards, Map.

---

## .base File Structure

A `.base` file is YAML with these top-level sections:

```yaml
filters:
  # Global filters (apply to all views)
  or:
    - file.hasTag("book")
    - and:
        - 'status == "active"'
        - file.inFolder("Projects")

formulas:
  formatted_price: 'if(price, price.toFixed(2) + " dollars")'
  ppu: "(price / age).toFixed(2)"

properties:
  status:
    displayName: Status

summaries:
  customAverage: 'values.mean().round(3)'

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
    summaries:
      formula.ppu: Average
```

---

## Property Access

There are three property namespaces:

| Namespace | Syntax | Example |
|-----------|--------|---------|
| Note properties (frontmatter) | `note.price` or just `price` | `author`, `note.status` |
| File properties (metadata) | `file.<prop>` | `file.name`, `file.ctime` |
| Formula properties (computed) | `formula.<name>` | `formula.formatted_price` |
| Context reference | `this` | Points to base file, embedding file, or active file |

### File Properties

| Property | Type | Description |
|----------|------|-------------|
| `file.name` | String | Filename |
| `file.path` | String | Full file path |
| `file.folder` | String | Folder path |
| `file.ext` | String | File extension |
| `file.size` | Number | File size in bytes |
| `file.ctime` | Date | Creation timestamp |
| `file.mtime` | Date | Modification timestamp |
| `file.tags` | List | All tags (content + frontmatter) |
| `file.links` | List | Internal links including frontmatter |
| `file.backlinks` | List | References linking to the file (performance-heavy) |
| `file.embeds` | List | All embedded content |
| `file.properties` | Object | All frontmatter properties |
| `file.file` | File | File object for specific functions |

---

## Filter Syntax

Filters narrow the dataset from all vault files. They can be **global** (affect all views) or **view-level**.

A filter is either a **string expression** or a **recursive object** using `and`, `or`, `not` keys with heterogeneous lists.

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

### File Filter Functions

| Function | Description |
|----------|-------------|
| `file.hasTag("tag")` | Check if file has a specific tag (including nested tags) |
| `file.hasLink("file")` | Check if file links to another file |
| `file.inFolder("folder")` | Check if file is in a folder or its subfolders |
| `file.hasProperty("name")` | Check if note has a specific frontmatter property |

### Comparison Operators

| Operator | Meaning |
|----------|---------|
| `==` | Equal |
| `!=` | Not equal |
| `>` | Greater than |
| `<` | Less than |
| `>=` | Greater than or equal |
| `<=` | Less than or equal |

### Boolean Operators

| Operator | Meaning |
|----------|---------|
| `!` | NOT |
| `&&` | AND |
| `\|\|` | OR |

### Arithmetic Operators

`+`, `-`, `*`, `/`, `%`, parentheses for grouping.

---

## Formulas

Custom computed properties defined in the `formulas:` section. They reference note, file, or other formula properties.

```yaml
formulas:
  formatted_price: 'if(price, price.toFixed(2) + " dollars")'
  ppu: "(price / age).toFixed(2)"
```

Rules:
- Text literals require nested quotes in YAML (single-quote wrapping around double-quoted strings).
- No circular references allowed.
- Output data type is determined by the underlying data and function returns.

---

## Data Types

| Type | Notes |
|------|-------|
| **String** | Quoted values; supports `.contains()`, `.lower()`, `.split()`, etc. |
| **Number** | Standard numeric; supports `.abs()`, `.round()`, `.toFixed()`, etc. |
| **Boolean** | `true` / `false` |
| **Date** | Created with `date("YYYY-MM-DD HH:mm:ss")`; supports arithmetic with duration strings |
| **List** | Indexed with `[0]`; supports `.map()`, `.filter()`, `.reduce()`, `.sort()`, etc. |
| **Object** | Dot notation or bracket access; supports `.keys()`, `.values()` |
| **Link** | Wikilinks auto-recognized; created with `link()`; supports `.asFile()`, `.linksTo()` |

### Date Arithmetic

Dates can be modified with `+` or `-` using duration strings:

```
now() + "1 day"
date + "1M"
file.mtime > now() - "1 week"
```

**Duration units:** `y`/`year`/`years`, `M`/`month`/`months`, `w`/`week`/`weeks`, `d`/`day`/`days`, `h`/`hour`/`hours`, `m`/`minute`/`minutes`, `s`/`second`/`seconds`

---

## Built-in Functions Reference

### Global Functions

| Function | Parameters | Returns | Description |
|----------|-----------|---------|-------------|
| `if()` | `condition, trueResult, falseResult?` | any | Conditional expression |
| `now()` | none | date | Current datetime |
| `today()` | none | date | Current date (time zeroed) |
| `date()` | `string` | date | Parse date from `YYYY-MM-DD HH:mm:ss` |
| `duration()` | `string` | duration | Parse duration for date arithmetic |
| `number()` | `any` | number | Convert value to number |
| `link()` | `path, display?` | Link | Create a link object |
| `list()` | `element` | List | Wrap element in list (or return as-is if already list) |
| `file()` | `path \| file \| url` | file | Return file object |
| `image()` | `path \| file \| url` | image | Return image object |
| `icon()` | `name` | icon | Return Lucide icon by name |
| `html()` | `string` | html | Render string as HTML |
| `escapeHTML()` | `string` | string | Escape HTML special characters |
| `min()` | `num1, num2, ...` | number | Smallest value |
| `max()` | `num1, num2, ...` | number | Largest value |

### String Functions

| Function | Description | Example |
|----------|-------------|---------|
| `.contains(str)` | Substring check | `"hello".contains("ell")` -> `true` |
| `.containsAll(...strs)` | Contains all substrings | |
| `.containsAny(...strs)` | Contains any substring | |
| `.startsWith(str)` | Prefix check | |
| `.endsWith(str)` | Suffix check | |
| `.lower()` | Lowercase | |
| `.title()` | Title case | `"hello world".title()` -> `"Hello World"` |
| `.trim()` | Strip whitespace | |
| `.replace(pattern, repl)` | Replace all occurrences | Supports string or regex pattern |
| `.split(sep, n?)` | Split into list | `"a,b,c,d".split(",", 3)` -> `["a","b","c"]` |
| `.slice(start, end?)` | Substring extraction | |
| `.repeat(n)` | Repeat string | `"123".repeat(2)` -> `"123123"` |
| `.reverse()` | Reverse string | `"hello".reverse()` -> `"olleh"` |
| `.isEmpty()` | Empty/missing check | |

### Number Functions

| Function | Description | Example |
|----------|-------------|---------|
| `.abs()` | Absolute value | `(-5).abs()` -> `5` |
| `.ceil()` | Round up | `(2.1).ceil()` -> `3` |
| `.floor()` | Round down | `(2.9).floor()` -> `2` |
| `.round(digits?)` | Round to nearest | `(2.5).round()` -> `3` |
| `.toFixed(precision)` | Fixed decimal string | `(3.14159).toFixed(2)` -> `"3.14"` |
| `.isEmpty()` | Not present check | |

### Date Functions

| Function | Description | Example |
|----------|-------------|---------|
| `.date()` | Remove time component | |
| `.time()` | Extract time string | `now().time()` -> `"23:59:59"` |
| `.format(fmt)` | Moment.js format | `date.format("YYYY-MM-DD")` -> `"2025-05-27"` |
| `.relative()` | Human-readable relative time | |
| `.isEmpty()` | Always returns false | |

### List Functions

| Function | Description | Example |
|----------|-------------|---------|
| `.contains(val)` | Element membership | `[1,2,3].contains(2)` -> `true` |
| `.containsAll(...vals)` | Contains all elements | |
| `.containsAny(...vals)` | Contains any element | |
| `.filter(condition)` | Filter with `index`/`value` vars | |
| `.map(expr)` | Transform with `index`/`value` vars | |
| `.reduce(expr, acc)` | Reduce to single value | `[1,2,3].reduce(acc + value, 0)` -> `6` |
| `.sort()` | Sort elements | `[3,1,2].sort()` -> `[1,2,3]` |
| `.reverse()` | Reverse order | `[1,2,3].reverse()` -> `[3,2,1]` |
| `.flat()` | Flatten nested lists | `[1,[2,3]].flat()` -> `[1,2,3]` |
| `.unique()` | Remove duplicates | `[1,2,2,3].unique()` -> `[1,2,3]` |
| `.join(sep)` | Join to string | `[1,2,3].join(",")` -> `"1,2,3"` |
| `.slice(start, end?)` | Sublist extraction | |
| `.isEmpty()` | Empty check | |

### Link Functions

| Function | Description |
|----------|-------------|
| `.asFile()` | Convert link to file object |
| `.linksTo(file)` | Check if linked file has a link to another file |

### Object Functions

| Function | Description | Example |
|----------|-------------|---------|
| `.keys()` | List of keys | |
| `.values()` | List of values | |
| `.isEmpty()` | No properties check | `{}.isEmpty()` -> `true` |

### Any Type Functions

| Function | Description |
|----------|-------------|
| `.isTruthy()` | Coerce to boolean |
| `.isType(type)` | Type check |
| `.toString()` | String representation |

### Regex Functions

| Function | Description | Example |
|----------|-------------|---------|
| `/pattern/.matches(str)` | Test regex match | `/abc/.matches("abcde")` -> `true` |

---

## Summaries

Summaries aggregate values across all results using the `values` keyword (a list of all property values).

**Built-in summary types:** Average, Min, Max, Sum, Range, Median, Stddev, Earliest, Latest, Checked, Unchecked, Empty, Filled, Unique.

Custom summaries can be defined:

```yaml
summaries:
  customAverage: 'values.mean().round(3)'
```

---

## View Configuration

Each view supports:

| Key | Description |
|-----|-------------|
| `type` | View layout: `table`, `list`, `cards`, `map` |
| `name` | Display name |
| `limit` | Maximum number of rows |
| `groupBy` | Group by property with `property` and `direction` (ASC/DESC) |
| `order` | List of columns to display (and their order) |
| `filters` | View-specific filters (same syntax as global) |
| `summaries` | Per-property summary aggregations |

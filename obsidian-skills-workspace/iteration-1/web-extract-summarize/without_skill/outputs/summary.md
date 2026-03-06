# Obsidian Bases Syntax Summary

Source: https://help.obsidian.md/bases/syntax (and related pages)

## What Are Bases?

Bases is a core plugin that lets you create database-like views of your notes. All data comes from local Markdown files and their frontmatter properties. Bases are saved as `.base` files using YAML syntax, or can be embedded in Markdown code blocks.

## View Types

Bases supports four view layouts:

- **Table** -- files as rows, properties as columns
- **List** -- bulleted/numbered file display
- **Cards** -- grid layout, suitable for galleries with images
- **Map** -- files plotted as interactive map pins

---

## `.base` File Structure (YAML)

A `.base` file has five top-level keys:

```yaml
filters:        # Global filters applied to all views
formulas:       # Formula property definitions
properties:     # Property configuration/display metadata
summaries:      # Custom summary formula definitions
views:          # Array of view configurations
```

---

## Filters

Filters narrow the dataset from all vault files. They can be applied **globally** (all views) or at the **view level**.

### Filter Structure

Filter objects contain one of `and`, `or`, or `not`. These can be nested recursively. Each filter statement is a string expression that evaluates to true/false.

```yaml
filters:
  and:
    - 'status != "done"'
    - or:
        - "formula.ppu > 5"
        - "price > 2.1"
```

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

### Comparison Operators

| Operator | Meaning |
|----------|---------|
| `==` | Equals |
| `!=` | Not equal |
| `>` | Greater than |
| `<` | Less than |
| `>=` | Greater than or equal |
| `<=` | Less than or equal |

### Boolean Operators

| Operator | Meaning |
|----------|---------|
| `!` | Logical NOT |
| `&&` | Logical AND |
| `||` | Logical OR |

### Arithmetic Operators (usable in filter expressions)

`+`, `-`, `*`, `/`, `%`, `()`

### Common Filter Functions

| Function | Description |
|----------|-------------|
| `file.hasTag("tag1", "tag2")` | True if file has any of the listed tags (includes nested) |
| `file.hasLink("file")` | True if file links to the specified file |
| `file.inFolder("folder")` | True if file is in the folder or its sub-folders |
| `file.hasProperty("name")` | True if the note has the given property |

---

## Property References

Properties can be referenced with three prefixes:

| Prefix | Meaning | Example |
|--------|---------|---------|
| `note.` (or no prefix) | Note frontmatter property | `note.price` or `price` |
| `file.` | File metadata property | `file.size`, `file.ext` |
| `formula.` | Computed formula property | `formula.ppu` |

### File Properties

| Property | Type | Description |
|----------|------|-------------|
| `file.name` | String | File name |
| `file.path` | String | Full file path |
| `file.folder` | String | Folder path |
| `file.ext` | String | File extension |
| `file.size` | Number | File size in bytes |
| `file.ctime` | Date | Creation time |
| `file.mtime` | Date | Modified time |
| `file.tags` | List | All tags in content and frontmatter |
| `file.links` | List | Internal links including frontmatter |
| `file.backlinks` | List | Backlink files (performance-heavy) |
| `file.embeds` | List | All embeds in the note |
| `file.properties` | Object | All file properties |
| `file.file` | File | File object (for function-specific use) |

### The `this` Object

`this` references context-dependent properties:
- **Main content area**: points to the base file itself
- **Embedded in another file**: points to the embedding file
- **Sidebar**: points to the active file in the main content area (useful for dynamic backlink queries)

---

## Formulas

Formulas are key-value pairs where the key is the property name and the value is an expression string.

```yaml
formulas:
  formatted_price: 'if(price, price.toFixed(2) + " dollars")'
  ppu: "(price / age).toFixed(2)"
```

Key rules:
- Formulas can reference other formula properties (no circular references allowed)
- Stored as strings in YAML, but output type depends on the underlying data and functions used

---

## Views

Each view is an object in the `views` array:

```yaml
views:
  - type: table
    name: "Display name"
    limit: 10
    groupBy:
      property: note.age
      direction: DESC
    filters:
      and: [...]
    order:
      - file.name
      - file.ext
    summaries:
      formula.ppu: Average
```

Sub-properties:
- `type` -- view type (table, list, cards, map, or plugin-defined)
- `name` -- display name for the view tab
- `limit` -- max rows shown
- `filters` -- view-specific filters (same syntax as global)
- `groupBy` -- property + sort direction (ASC/DESC)
- `order` -- column/property ordering
- `summaries` -- maps properties to named summary functions

---

## Summaries

### Default Summary Functions

| Name | Input Type | Purpose |
|------|-----------|---------|
| Average, Min, Max, Sum, Range, Median, Stddev | Number | Statistical calculations |
| Earliest, Latest, Range | Date | Date range operations |
| Checked, Unchecked | Boolean | Boolean counts |
| Empty, Filled, Unique | Any | General counting/presence |

### Custom Summary Formulas

```yaml
summaries:
  customAverage: 'values.mean().round(3)'
```

The `values` keyword is a list containing all values for that property across every note in the result set.

---

## Data Types

- **Strings**: quoted (`"hello"`)
- **Numbers**: standard numeric literals
- **Booleans**: `true` / `false`
- **Dates**: created with `date("YYYY-MM-DD HH:mm:ss")`, support arithmetic and comparison
- **Lists**: bracket notation `[1, 2, 3]`
- **Objects**: accessed via dot or bracket notation
- **Links**: auto-recognized from frontmatter; created via `link("[[filename]]")`

### Date Arithmetic

Dates support `+` and `-` with duration strings:

| Format | Duration |
|--------|----------|
| `y`, `year`, `years` | Year |
| `M`, `month`, `months` | Month |
| `w`, `week`, `weeks` | Week |
| `d`, `day`, `days` | Day |
| `h`, `hour`, `hours` | Hour |
| `m`, `minute`, `minutes` | Minute |
| `s`, `second`, `seconds` | Second |

Examples:
- `date + "1M"` (add 1 month)
- `now() - "1 week"` (subtract 1 week)
- `date("2024-12-01") + "1M" + "4h" + "3m"` (chain multiple durations)

---

## Built-in Functions Reference

### Global Functions

| Function | Signature | Description |
|----------|-----------|-------------|
| `date()` | `date(string): date` | Parse `YYYY-MM-DD HH:mm:ss` string to date |
| `today()` | `today(): date` | Current date (time zeroed) |
| `now()` | `now(): date` | Current date and time |
| `duration()` | `duration(string): duration` | Parse duration string (e.g., `"1d"`) |
| `if()` | `if(condition, trueResult, falseResult?): any` | Conditional evaluation |
| `min()` | `min(n1, n2, ...): number` | Smallest of provided numbers |
| `max()` | `max(n1, n2, ...): number` | Largest of provided numbers |
| `number()` | `number(any): number` | Convert to number |
| `link()` | `link(path, display?): Link` | Create a link object |
| `list()` | `list(element): List` | Wrap element in list if not already one |
| `file()` | `file(path): file` | Return file object for path |
| `image()` | `image(path): image` | Render image in view |
| `icon()` | `icon(name): icon` | Render named icon in view |
| `html()` | `html(string): html` | Convert string to renderable HTML |
| `escapeHTML()` | `escapeHTML(string): string` | Escape HTML special characters |

### String Functions

| Function | Description | Example |
|----------|-------------|---------|
| `.length` | Character count (field) | `"hello".length` returns `5` |
| `.contains(val)` | Check substring | `"hello".contains("ell")` returns `true` |
| `.containsAll(...)` | All substrings present | `"hello".containsAll("h", "e")` |
| `.containsAny(...)` | Any substring present | `"hello".containsAny("x", "e")` |
| `.startsWith(q)` | Starts with query | `"hello".startsWith("he")` |
| `.endsWith(q)` | Ends with query | `"hello".endsWith("lo")` |
| `.isEmpty()` | No characters / absent | `"".isEmpty()` returns `true` |
| `.lower()` | Lowercase | `"HELLO".lower()` |
| `.title()` | Title case | `"hello world".title()` returns `"Hello World"` |
| `.trim()` | Strip whitespace | `"  hi  ".trim()` returns `"hi"` |
| `.slice(start, end?)` | Substring | `"hello".slice(1, 4)` returns `"ell"` |
| `.split(sep, n?)` | Split to list | `"a,b,c".split(",")` returns `["a","b","c"]` |
| `.replace(pat, rep)` | Replace pattern | `"a:b".replace(":", "-")` returns `"a-b"` |
| `.repeat(n)` | Repeat string | `"ab".repeat(3)` returns `"ababab"` |
| `.reverse()` | Reverse string | `"hello".reverse()` returns `"olleh"` |

### Number Functions

| Function | Description | Example |
|----------|-------------|---------|
| `.abs()` | Absolute value | `(-5).abs()` returns `5` |
| `.ceil()` | Round up | `(2.1).ceil()` returns `3` |
| `.floor()` | Round down | `(2.9).floor()` returns `2` |
| `.round(digits?)` | Round | `(2.33).round(1)` returns `2.3` |
| `.toFixed(prec)` | Fixed-point string | `(3.14).toFixed(2)` returns `"3.14"` |
| `.isEmpty()` | True if not present | `5.isEmpty()` returns `false` |

### Date Functions

| Function | Description | Example |
|----------|-------------|---------|
| `.year`, `.month`, `.day`, `.hour`, `.minute`, `.second`, `.millisecond` | Date part fields | `now().year` |
| `.date()` | Strip time portion | `now().date()` |
| `.time()` | Time as string | `now().time()` returns `"23:59:59"` |
| `.format(fmt)` | Moment.js format | `date.format("YYYY-MM-DD")` |
| `.relative()` | Human-readable delta | `file.mtime.relative()` returns `"3 days ago"` |
| `.isEmpty()` | Always false for dates | -- |

### List Functions

| Function | Description | Example |
|----------|-------------|---------|
| `.length` | Element count (field) | `[1,2,3].length` returns `3` |
| `.contains(val)` | Check membership | `[1,2,3].contains(2)` returns `true` |
| `.containsAll(...)` | All elements present | `[1,2,3].containsAll(2,3)` |
| `.containsAny(...)` | Any element present | `[1,2,3].containsAny(3,4)` |
| `.filter(expr)` | Filter by expression | `[1,2,3,4].filter(value > 2)` returns `[3,4]` |
| `.map(expr)` | Transform elements | `[1,2,3].map(value + 1)` returns `[2,3,4]` |
| `.reduce(expr, acc)` | Reduce to single value | `[1,2,3].reduce(acc + value, 0)` returns `6` |
| `.flat()` | Flatten nested lists | `[1,[2,3]].flat()` returns `[1,2,3]` |
| `.sort()` | Sort ascending | `[3,1,2].sort()` returns `[1,2,3]` |
| `.reverse()` | Reverse order | `[1,2,3].reverse()` returns `[3,2,1]` |
| `.unique()` | Remove duplicates | `[1,2,2,3].unique()` returns `[1,2,3]` |
| `.slice(start, end?)` | Sub-list | `[1,2,3,4].slice(1,3)` returns `[2,3]` |
| `.join(sep)` | Join to string | `[1,2,3].join(",")` returns `"1,2,3"` |
| `.isEmpty()` | No elements | `[].isEmpty()` returns `true` |

### Link Functions

| Function | Description |
|----------|-------------|
| `.asFile()` | Convert link to file object |
| `.linksTo(file)` | Check if linked file links to another file |

### File Functions

| Function | Description |
|----------|-------------|
| `.asLink(display?)` | Convert file to renderable link |
| `.hasTag(...)` | True if file has any listed tag (includes nested) |
| `.hasLink(file)` | True if file links to another file |
| `.hasProperty(name)` | True if note has the property |
| `.inFolder(folder)` | True if file is in folder or sub-folders |

### Object Functions

| Function | Description |
|----------|-------------|
| `.isEmpty()` | True if no own properties |
| `.keys()` | List of keys |
| `.values()` | List of values |

### Any-Type Functions

| Function | Description |
|----------|-------------|
| `.isTruthy()` | Coerce to boolean |
| `.isType(type)` | Check type (e.g., `"string"`, `"number"`) |
| `.toString()` | String representation |

### Regular Expression

| Function | Description | Example |
|----------|-------------|---------|
| `.matches(val)` | Test regex match | `/abc/.matches("abcde")` returns `true` |

Regex can also be used with `string.replace()` (e.g., `"a:b:c".replace(/:/g, "-")`).

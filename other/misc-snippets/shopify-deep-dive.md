# Shopify Themes: How Everything Works

## The Core Architecture

Shopify is a hosted e-commerce platform. Your store's **data** lives in Shopify's database (products, variants, orders, customers). Your **theme** is a separate layer — a collection of files that tells Shopify how to render that data as HTML.

The theme is just files in a git repo:
- `templates/` — which sections appear on which page type
- `sections/` — reusable page building blocks
- `snippets/` — smaller reusable partials (called via `{% render %}`)
- `assets/` — JS, CSS, images
- `config/` — theme settings schema and saved values
- `layout/` — the outer HTML shell (header, footer)

When a visitor loads a page, Shopify's servers run the Liquid templating engine over your files, injecting live store data, and serve the resulting HTML. There is no build step, no server you control — Shopify does everything.

---

## Liquid: The Templating Language

Liquid is Shopify's templating language. It has three constructs:

```liquid
{{ variable }}          — output
{% tag %}               — logic (if, for, assign, etc.)
{%- -%}                 — same but strips whitespace
```

The key objects available in Liquid depend on context:
- On a product page: `product`, `product.variants`, `product.media`, etc.
- On the home page: only what sections explicitly load
- Globally: `shop`, `cart`, `customer`, `request`

**Sections** receive their data through `section.settings` (configured in the theme editor) and through Liquid objects that are automatically available based on page type. On the home page, there is no `product` object — that's why `home-product-showcase.liquid` requires a product setting and does `{% assign product = section.settings.product %}`.

---

## Products and Variants

A **product** is the top-level item (e.g., "Dr Kampes S3S"). A **variant** is a specific purchasable combination (e.g., "Nero / 42").

```
Product
├── options: ["Colore", "Taglia"]
├── variants:
│   ├── { id: 123, options: ["Nero", "41"], price: 12900, available: true }
│   ├── { id: 124, options: ["Nero", "42"], price: 12900, available: true }
│   └── { id: 125, options: ["Testa di Moro", "41"], price: 12900, available: false }
└── media: [image1, image2, image3, ...]
```

`product.options_with_values` gives you the option structure with `product_option_value` objects per value — these have `.swatch` if swatches are configured. The `product.variants` array is what actually drives add-to-cart: you always POST a specific `variant.id`.

---

## Metafields

Metafields are custom data attached to Shopify resources (products, variants, collections, customers, orders, pages, the shop itself). They are the primary extension mechanism.

**Structure:**
```
namespace.key → typed value
```

Examples:
- `custom.variant_gallery` on a **variant** → list of file references (images)
- `custom.technical_specs` on a **product** → rich text
- `custom.category_color` on a **collection** → color

**Types include:** single line text, multi-line text, integer, decimal, boolean, date, color, file reference, product reference, variant reference, metaobject reference, list of any of the above.

**How to access in Liquid:**
```liquid
{{ product.metafields.custom.technical_specs.value }}
{{ variant.metafields.custom.variant_gallery.value }}  {# returns array of file objects #}
```

The `.value` unwraps the typed value. Without `.value`, you get the metafield object itself (which has `.type`, `.value`, etc.).

**Defining metafields:** Admin > Settings > Custom data. You define the schema there (namespace, key, type, validations). Then individual resource records get their values set either manually in the admin editor or via the API.

---

## Metaobjects

Metaobjects are like custom database tables — you define a schema (a "metaobject definition") and then create records ("metaobject entries") that follow that schema.

**When to use metafields vs metaobjects:**

| Use metafields when... | Use metaobjects when... |
|---|---|
| Adding data to an existing resource (product, variant, collection) | Creating standalone structured content with no natural parent |
| The data is 1:1 with the resource | Multiple resources reference the same shared record |
| E.g., variant gallery images, product certifications | E.g., a "Color" definition shared by many products: `{ name, hex, rgb, display_name_it }` |

**Example:** Instead of hardcoding swatch colors in Liquid, you could create a `color_swatch` metaobject definition:
```
color_swatch:
  - handle: string (unique ID)
  - display_name: single line text
  - hex: color
  - image: file reference
```

Then attach `color_swatch` references to product option values. In Liquid:
```liquid
{% assign swatch_obj = value.metaobject %}
{{ swatch_obj.hex.value }}
```

This is how you make it robust — data lives in Shopify, code just reads it.

---

## How the Native Swatch System Works

Shopify has a first-party swatch system (added ~2024). When configured, `product_option_value.swatch.color.rgb` returns `"R,G,B"` (e.g., `"26,26,26"`), and `product_option_value.swatch.image` returns an image object.

**To configure it:**
1. Admin > Products > [product] — edit the option named "Colore"
2. Shopify shows a "Swatch" column if the theme supports it
3. Set a color or image per option value

This only works when iterating `product.options_with_values[n].values` — the values are `product_option_value` objects with a `.swatch` property. The system is entirely data-driven: adding a new color in the admin automatically gets the right swatch with no code changes.

---

## Templates and `index.json`

`templates/index.json` (for the home page) defines which sections appear and in what order:

```json
{
  "sections": {
    "hero_abc": { "type": "image-banner", "settings": { ... } },
    "home_product_showcase": { "type": "home-product-showcase", "settings": { "product": "dr-kampes-s3s-nero-copia" } }
  },
  "order": ["hero_abc", "home_product_showcase"]
}
```

**Rules Shopify enforces:**
1. Every key in `sections` must appear in `order`
2. Every string in `order` must exist in `sections`
3. Each section's `type` must match a file in `sections/`

The theme editor writes to this file when you drag sections or change settings. Manual edits without keeping it consistent cause upload errors. Rebase conflicts in this file are the most dangerous — always validate JSON and the sections/order symmetry after resolving.

---

## The Cart System

Shopify's cart works via these endpoints:

| Endpoint | What it does |
|---|---|
| `POST /cart/add.js` | Add item(s), returns the added item + optionally re-rendered sections |
| `POST /cart/update.js` | Change quantities |
| `POST /cart/change.js` | Change a single line item |
| `GET /cart.js` | Get full cart state as JSON |

The `sections` parameter on `/cart/add.js` is the Section Rendering API — you pass section IDs and Shopify re-renders those sections server-side and returns the HTML in `response.sections[sectionId]`. This is how the cart drawer updates without a full page reload.

In this theme (Horizon), the cart drawer is a web component (`cart-items-component`) that listens for the `cart:update` custom event. When fired with `event.detail.data.sections`, it calls `morphSection()` to patch the DOM in-place with the new HTML. The exact event shape matters:

```javascript
document.dispatchEvent(new CustomEvent('cart:update', {
  bubbles: true,
  detail: { data: { sections: data.sections } }  // not detail.sections — detail.data.sections
}));
```

---

## Review of What We Built

### Robust

- **Variant gallery** — We iterate `vg_files` (outer) then `product.media` (inner), preserving the user's custom order. Adding new images to a variant's gallery in the admin just works.
- **vgMap JSON** — Generated server-side at render time from live Liquid data. Not hardcoded.
- **Cart AJAX** — Section IDs are collected dynamically via `querySelectorAll('cart-items-component[data-section-id]')`. Survives theme updates that add/remove cart sections.
- **`index.json` + section pairing** — Now consistent after fixing rebase conflicts. Rule: sections object and order array must be perfectly symmetric.

### Fragile

- **Swatch colors** — Currently falls back to hardcoded `elsif` chains (`nero` → `#1a1a1a`, etc.). Adding a new color without configuring native swatches gets `#888`. Fix: configure native swatches in admin so the code path `value.swatch.color.rgb` actually resolves.
- **Color option detection** — Finds the color option by matching `option.name | downcase` against `'colore'`, `'color'`, `'colour'`. Works for this product, fragile for a multi-product store with inconsistent naming.
- **Hardcoded subtitle** — `"Antinfortunistiche S3S"` is hardcoded in the section template. Should be a `custom.subtitle` metafield on the product.
- **Hardcoded size table** — The size guide popup contains hardcoded IT sizes and measurements. Should be a structured metaobject or rich text metafield on the product.
- **Product pinned by handle** — The section setting stores `"dr-kampes-s3s-nero-copia"`. Renaming or duplicating the product requires updating the theme setting manually.

### What Would Make It Fully Robust

1. Configure native swatches in admin — then no code change is needed to add a color.
2. Add a `custom.subtitle` product metafield — hardcoded string moves to data.
3. Add a `custom.size_guide` metafield (rich text or metaobject reference) — size table becomes editable without a deploy.
4. Add a `custom.tech_docs` metafield (list of file references or a metaobject) — technical document links move out of the template.

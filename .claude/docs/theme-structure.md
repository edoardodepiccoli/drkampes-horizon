# Dr Kampes Horizon — Theme Structure Reference

_Horizon 3.2.1 by Shopify. Last mapped: 2026-05-02_

---

## Top-level directory

```
horizon/
├── assets/          118 files — CSS, JS, images
├── blocks/          96 files — reusable block components
├── config/          settings_schema.json, settings_data.json
├── layout/          theme.liquid, lp.liquid
├── locales/         53 languages + schema variants
├── other/           legacy HTML, docs, reviews snippet
├── sections/        54 sections
├── snippets/        100 helper components
├── templates/       17 templates
└── .claude/         skills, docs (not shipped to Shopify)
```

---

## Layouts

### `layout/theme.liquid`
Standard Shopify HTML structure. Loads: `meta-tags`, `stylesheets`, `fonts`, `scripts`, `theme-styles-variables`, `color-schemes`. Renders `header-group` section. Implements view transitions when enabled. Inline script calculates header height to prevent layout shift.

### `layout/lp.liquid` (custom)
Stripped landing page layout. No header/footer. Explicit CSS hides Shopify forms embed (`display: none !important`). Sets `main#MainContent { padding-top: 0 !important }`. Only renders content, quick-add modal, and cart drawer script. Use this for all landing pages.

---

## Templates

### Standard (boilerplate)
`article.json`, `blog.json`, `cart.json`, `collection.json`, `gift_card.liquid`, `index.json`, `list-collections.json`, `page.json`, `password.json`, `product.json`, `search.json`, `404.json`

### Custom
- **`page.landing.json`** — Full landing page using `lp` layout. Section order: lp-hero, lp-problem, lp-story, lp-benefits, lp-video, lp-reviews, hps-offerta (#acquista anchor), lp-guarantee, lp-final-cta, footer
- `page.contact.json` — Contact page
- `page.piertutor.json` — Piertutor ambassador page
- `page.simone.json` — Simone ambassador page

---

## Sections (54 total)

### Custom Dr Kampes sections

| File | Lines | Purpose |
|---|---|---|
| `lp-hero.liquid` | 123 | Hero: background image, gradient overlay, H1 with yellow highlight, pre-badge, subheading, yellow CTA, trust items blocks |
| `lp-problem.liquid` | ~100 | Pain-point narrative: lacci, cemento, soldi blocks + side image |
| `lp-story.liquid` | — | Brand origin story: eyebrow, H2, blockquote, narrative, Made in Italy badge |
| `lp-benefits.liquid` | 166 | Benefits grid: FASTWEAR® system, emoji-to-SVG icons, two product images, black bg |
| `lp-video.liquid` | — | Video section: MP4 + YouTube URL fallback |
| `lp-reviews.liquid` | — | Testimonial carousel: 20+ reviews pre-configured |
| `lp-guarantee.liquid` | — | 3-year warranty + comparison table (generic vs. Dr Kampes) + €351 savings callout |
| `lp-final-cta.liquid` | — | Final CTA: product image, €189/€219 compare price, payment badges (Klarna, PayPal, Apple Pay, Google Pay, Carta), installment text, SSL note |
| `hps-offerta.liquid` | 1701 | Product gallery + purchase: custom image gallery, variant-specific images (metafield `custom.variant_gallery`), T-shirt upsell, discount codes (SPEDIZIONEGRATIS, BUNDLETSHIRT), viewer toast (12-37 viewers, threshold 7 items) |

### Standard Horizon sections (do not modify)
`main-blog-post.liquid`, `main-blog.liquid`, `main-cart.liquid`, `main-collection.liquid`, `main-collection-list.liquid`, `main-page.liquid`, `main-product.liquid`, `main-search.liquid`, `featured-blog-posts.liquid`, `featured-product.liquid`, `featured-product-information.liquid`, `product-hotspots.liquid`, `product-information.liquid`, `product-list.liquid`, `product-recommendations.liquid`, `header-announcements.liquid`, `header-group.json`, `footer-group.json`, `footer-utilities.liquid`, `collection-list.liquid`, `collection-links.liquid`, `carousel.liquid`, `divider.liquid`, `hero.liquid`, `logo.liquid`, `marquee.liquid`, `media-with-content.liquid`, `password.liquid`, `slideshow.liquid`, `layered-slideshow.liquid`, `section.liquid` (wrapper), `predictive-search.liquid`, `quick-order-list.liquid`, `search-header.liquid`, `section-rendering-product-card.liquid`

---

## Snippets (100 files — key ones)

### Layout and structure
`group.liquid`, `overlay.liquid`, `border-override.liquid`, `gap-style.liquid`, `spacing-style.liquid`, `spacing-padding.liquid`, `layout-panel-style.liquid`, `size-style.liquid`, `grid-density-controls.liquid`

### Product
`product-card.liquid`, `product-grid.liquid`, `product-media-gallery-content.liquid`, `product-media.liquid`, `product-information-content.liquid`, `variant-picker.liquid`, `variant-main-picker.liquid`, `variant-swatches.liquid`, `swatch.liquid`, `price.liquid`, `quantity-selector.liquid`, `sku.liquid`, `quick-add.liquid`, `quick-add-modal.liquid`, `product-custom-property.liquid`, `product-inventory.liquid`, `add-to-cart-button.liquid`

### Cart
`cart-bubble.liquid`, `cart-products.liquid`, `cart-summary.liquid`, `gift-card-recipient-form.liquid`, `volume-pricing.liquid`, `volume-pricing-info.liquid`

### Media
`media.liquid`, `image.liquid`, `background-media.liquid`, `icon.liquid`, `icon-or-image.liquid`, `video.liquid`, `video-background.liquid`, `slideshow.liquid`, `slideshow-controls.liquid`, `slideshow-slide.liquid`, `slideshow-arrow.liquid`

### Header/Nav
`header-actions.liquid`, `header-drawer.liquid`, `header-row.liquid`, `menu-font-styles.liquid`, `mega-menu-list.liquid`, `search-modal.liquid`, `search.liquid`

### Typography/Text
`button.liquid`, `text.liquid`, `typography-style.liquid`, `format-price.liquid`, `rte-formatter.liquid`, `jumbo-text.liquid`

### Theme system
`meta-tags.liquid`, `stylesheets.liquid`, `fonts.liquid`, `scripts.liquid`, `theme-styles-variables.liquid`, `color-schemes.liquid`, `theme-editor.liquid`

### Special integrations
`air-reviews-status.liquid` — AirReviews integration, `pagefly-main-*.liquid` — PageFly page builder, `bento-grid.liquid`, `card-gallery.liquid`, `editorial-*.liquid` (3 variants)

---

## Assets — JS files (key ones)

### Core commerce
`product-card.js`, `product-form.js`, `variant-picker.js`, `quick-add.js`, `cart-drawer.js`, `cart-discount.js`, `fly-to-cart.js`

### UI interactions
`header.js`, `slideshow.js`, `comparison-slider.js`, `media-gallery.js`, `scroll-animation.js`, `dialog.js`, `accordion-custom.js`, `disclosure-custom.js`

### Utility
`utilities.js` (calculateHeaderGroupHeight etc.), `focus.js`, `events.js`, `performance.js`, `copy-to-clipboard.js`, `localization.js`

### Theme editor
`theme-editor.js`, `section-hydration.js`, `section-renderer.js`

### Animations
`morph.js`, `view-transitions.js`, `drag-zoom-wrapper.js`, `zoom-dialog.js`, `sticky-add-to-cart.js`

---

## Config

### `config/settings_data.json` (active store settings)
- Logo: `logo_white_transparent.png`
- Body font: Inter N4
- Heading font: Archivo Black N4
- Subheading font: Inter N5
- H1: 56px, H2: 48px (uppercase), H3: 32px
- View transitions: enabled
- Narrow page width for product pages

---

## Custom section anatomy

```liquid
{%- comment -%} Access settings {%- endcomment -%}
{%- assign img = section.settings.image -%}

<section class="lp-[name]" id="[name]">
  {%- for block in section.blocks -%}
    {%- case block.type -%}
      {%- when 'trust_item' -%}
        <div class="trust-item" {{ block.shopify_attributes }}>
          {{ block.settings.text }}
        </div>
    {%- endcase -%}
  {%- endfor -%}
</section>

{% stylesheet %}
  .lp-[name] {
    background: #000;
    color: #fff;
    padding: 4rem 1.5rem;
  }

  @media (min-width: 750px) {
    .lp-[name] {
      padding: 6rem 4rem;
    }
  }
{% endstylesheet %}

{% schema %}
{
  "name": "LP — Name",
  "tag": "section",
  "settings": [
    {
      "type": "image_picker",
      "id": "image",
      "label": "Background image"
    },
    {
      "type": "text",
      "id": "eyebrow",
      "label": "Eyebrow"
    },
    {
      "type": "richtext",
      "id": "heading",
      "label": "Heading"
    }
  ],
  "blocks": [
    {
      "type": "trust_item",
      "name": "Trust Item",
      "settings": [
        { "type": "text", "id": "text", "label": "Text" }
      ]
    }
  ],
  "presets": [
    { "name": "LP — Name" }
  ]
}
{% endschema %}
```

---

## Shared LP CSS classes

Defined in `lp-hero.liquid` and reused across all LP sections:

```css
.lp-sec__eyebrow   /* small uppercase label above headings */
.lp-sec__h2        /* section heading style */
```

---

## Locales

53 languages. Default: `en.default.json`. Key: `it.json` (primary market). Each language has optional `.schema.json` for field label translations.

---

## Other directory

`/other/landing-page-camionisti.html` — Legacy reference LP (pre-Shopify version)
`/other/reviews.liquid` — Standalone reviews snippet (11.5 KB)
`/other/contatti.md`, `cookies.md`, `garanzia.md` — Page content docs
`/other/shopify-deep-dive.md` — Shopify architecture notes

---

## Integrations

| Integration | Where |
|---|---|
| PageFly | `snippets/pagefly-*.liquid`, `assets/pagefly-*.*` |
| Klarna / PayPal BNPL | `sections/lp-final-cta.liquid` |
| AirReviews | `snippets/air-reviews-status.liquid` |
| Shopify Forms | Explicitly hidden on LP layout |
| Product metafields | `custom.variant_gallery` used in hps-offerta |

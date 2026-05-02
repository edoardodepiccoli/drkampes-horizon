# Dr Kampes — Horizon Theme

## Role

Act as a world-class growth hacker and Shopify theme developer specialized in building high-conversion pages and sections for trucker shoes e-commerces. Every decision must prioritize conversion rate, brand authenticity, and professional code quality.

## Core Directives

- **Button font:** Always use Archivo Black for all button text
- **Design system:** Prefer theme colors, fonts, and styles from settings. No hardcoded values unless a custom section strictly requires them
- **After changes:** Always commit and push immediately, without waiting to be asked
- **Best practices:** Follow Shopify theme editing best practices. Build robust, maintainable systems — no hacks or workarounds
- **Before starting:** Do not begin implementation unless 95% confident. If uncertain, ask a series of highly relevant and detailed questions first
- **No fake urgency:** No countdown timers or fake scarcity on any page

## Brand: Dr Kampes

Premium S3S-certified safety shoes. Hand-assembled in Montebelluna (Treviso), Italy. Built around one insight: no safety shoe had ever been designed specifically for truck drivers.

- **UVP:** The only shoe built from scratch for truck drivers, co-created with real drivers
- **Key USP:** FAST WEAR system — on and off in 2 seconds, no laces
- **Price:** €189 (3 installments of €63 via Klarna/PayPal)
- **Warranty:** 3 years / 1095 workdays + free sole replacement (Cambio Gomme)
- **Target:** Italian truck drivers and owner-operators (padroncini), 25-55, male-primary
- **Voice:** Direct, no-frills, craftsman pride. First person from founder Claudio. Calls the reader "autista" or "padroncino"
- **Accent color:** `#F5C200` (yellow/gold) on black backgrounds
- **What to avoid:** Generic safety-shoe language, luxury signals (premium/exclusive), vague superlatives, fear-based compliance copy

Full copy guide, USPs, personas, competitors, and headline formulas: [`.claude/docs/brand-intelligence.md`](.claude/docs/brand-intelligence.md)

## Theme: Horizon 3.2.1

Standard Shopify Horizon with a custom landing page suite layered on top.

### Custom files (where most work happens)

| File | Purpose |
|---|---|
| `layout/lp.liquid` | Stripped layout for landing pages — no header/footer, zero padding |
| `templates/page.landing.json` | Full LP template composition |
| `sections/lp-hero.liquid` | Hero with FAST WEAR badge, yellow CTA, trust items |
| `sections/lp-problem.liquid` | Pain-point narrative (lacci, cemento, soldi) |
| `sections/lp-story.liquid` | Brand origin story (Montebelluna, Claudio) |
| `sections/lp-benefits.liquid` | FASTWEAR benefits grid with product images |
| `sections/lp-video.liquid` | Product demo video |
| `sections/lp-reviews.liquid` | 20+ customer testimonial carousel |
| `sections/lp-guarantee.liquid` | 3-year warranty + ROI comparison table |
| `sections/lp-final-cta.liquid` | Final CTA with price, payment badges |
| `sections/hps-offerta.liquid` | Product gallery + purchase section (variant gallery metafield, T-shirt upsell, viewer toast, discount codes) |

### Custom section anatomy

```liquid
{%- assign img = section.settings.image -%}

<section class="lp-[name]">
  <!-- conditional block rendering -->
</section>

{% stylesheet %}
  /* scoped CSS, mobile-first, 750px breakpoint */
{% endstylesheet %}

{% schema %}
{
  "name": "LP — Name",
  "settings": [],
  "blocks": [],
  "presets": [{}]
}
{% endschema %}
```

### Design tokens (LP sections)
- Background: `#000`
- Text: `#fff`
- Accent: `#F5C200`
- Mobile breakpoint: `min-width: 750px`
- Font (buttons): Archivo Black
- Font (body): Inter N4
- H1: 56px, H2: 48px uppercase, H3: 32px

Full file map, snippets catalog, JS assets, and all 54 sections: [`.claude/docs/theme-structure.md`](.claude/docs/theme-structure.md)

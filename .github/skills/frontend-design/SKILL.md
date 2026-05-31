---
name: frontend-design
description: 'Guides creation of distinctive, production-grade frontend interfaces with a unique aesthetic. Use when building a new component, page, or app, and you want to avoid generic AI-generated designs.'
user-invocable: true
---

# Frontend Design

## Goal
Design and develop distinctive, production-grade frontend interfaces that avoid generic "AI slop" aesthetics. Implement real working code with exceptional attention to aesthetic details, strong intentionality, and creative choices.

## When to Use
- Building new frontend components, pages, or entire applications.
- When you want to inject a specific artistic tone or make the interface unique and memorable.
- Polishing an existing UI to ensure it looks professional, intentional, and creatively striking.

## Design Thinking & Preparation
Before writing any code, establish a BOLD aesthetic direction based on the requirements:

1. **Purpose:** What problem does this interface solve? Who uses it?
2. **Tone:** Pick an extreme (e.g., brutally minimal, maximalist chaos, retro-futuristic, organic/natural, luxury/refined, playful/toy-like, editorial/magazine, brutalist/raw, art deco/geometric, soft/pastel, industrial/utilitarian). Maintain this throughout the entire design.
3. **Constraints:** Understand technical limitations (framework, performance, accessibility).
4. **Differentiation:** What makes this UNFORGETTABLE? Decide on the single most defining characteristic that people will remember.

*CRITICAL:* Choose a clear conceptual direction and execute it with precision. Whether bold maximalism or refined minimalism, the key is intentionality, not visual noise.

## Frontend Aesthetics Guidelines
Follow these rules for a distinctive, hand-crafted aesthetic:

- **Typography:** Choose fonts that are beautiful, unique, and interesting. Pair a distinctive display font with a refined body font. Avoid standard system fonts unless it directly reinforces the chosen tone.
- **Color & Theme:** Commit to a cohesive aesthetic built on CSS variables. Use dominant colors with sharp, surprising accents rather than timid, evenly-distributed palettes.
- **Motion:** Use animations purposefully for effects and micro-interactions. Prefer one high-impact moment (e.g., a well-orchestrated page load with `animation-delay` staggered reveals) over scattered micro-interactions. Incorporate scroll-triggering and engaging hover states.
- **Spatial Composition:** Explore unexpected layouts. Lean into asymmetry, overlap, diagonal flow, and grid-breaking elements. Consciously choose either generous negative space OR controlled, deliberate density.
- **Backgrounds & Visual Details:** Create atmosphere and depth instead of defaulting to solid colors. Use gradient meshes, noise textures, geometric patterns, layered transparencies, dramatic shadows, decorative borders, custom cursors, and grain overlays where appropriate.

## Anti-Patterns (NEVER DO)
- NEVER settle for generic AI-generated aesthetics (e.g., pure white background with purple/blue gradients).
- NEVER default to overused font families (Inter, Roboto, Arial, Space Grotesk) across all creations.
- NEVER rely on predictable, cookie-cutter layout patterns. Every interface must carry specific character reflecting its context.

## Implementation Procedure
1. **Analyze:** Understand the requested component/page.
2. **Commit:** Explicitly define the Tone, Colors, Typography, and Motion strategy.
3. **Implement:** Write the working production code (HTML/CSS/JS, React, Vue, etc.).
   - *Complexity Match:* Ensure the code matches the aesthetic vision (Maximalist requires elaborate CSS/animations; Minimalist requires immaculate restraint, precision, and spacing).
4. **Refine:** Verify typography, spacing, and polish. Ensure it distinguishes itself from generic designs.
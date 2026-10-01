# Ascension Island Common Utility Architecture

Status: GOVERNED DESIGN RULE

## Purpose

Ascension Island subsystem scripts should express **world rules**. Reusable mechanics for context classification, authored matching, interaction state, presentation selection, temporal validity, and player targeting belong in the common utility layer.

The canonical responsibility split is:

| Utility | Governing question | Owns |
| --- | --- | --- |
| `util_flagsets` | **Which facets apply?** | Compact orthogonal facet/capability/state membership; set/add/remove/test/intersection-style operations. |
| `util_matching` | **Does this authored context/profile apply?** | Declarative profile predicates over supplied context/facets. Matching decides applicability; it does not perform consequences. |
| `util_records` | **What happened in this particular interaction?** | Structured transient/per-interaction records and the bounded state needed to pass one interaction through multiple stages. |
| `util_library` | **What presentation/dialogue belongs to this context?** | Contextual authored content selection: line banks, presentation entries, descriptions, manifestations and similar data-driven output. |
| `util_time` | **When, for how long, and is it still valid?** | Durations, expiry, cooldown/time-window checks and common time arithmetic. |
| `util_target` | **What exactly did the player choose?** | Normalised player target acquisition/validation and target-result semantics. |

## Design rule

When a subsystem needs one of the six questions above answered, it should use the canonical utility rather than invent a subsystem-local implementation.

Subsystems retain ownership of domain meaning and consequences. Utilities provide reusable mechanics; they do **not** become a generic rules engine.

A subsystem should normally compose the utilities in the order demanded by the interaction, for example:

1. classify applicable facets with `util_flagsets`;
2. test authored profiles with `util_matching`;
3. create/update the interaction state with `util_records`;
4. acquire or validate a deliberate player choice with `util_target` where required;
5. resolve authored presentation through `util_library`;
6. enforce windows, expiry or cooldown through `util_time`.

This is a composition pattern, not a mandatory pipeline. Skip stages that the world rule does not need.

## Boundary rules

- **World rules stay in subsystem code.** A Red Cutlass system decides what a sighting means; `util_matching` only answers whether a supplied profile matches.
- **Facets are not records.** A facet says what applies; a record says what happened in one interaction.
- **Matching is side-effect free.** Matching must not award rewards, persist history, fire VFX, select dialogue, start cooldowns or mutate world state.
- **Library selection is presentation, not truth.** `util_library` chooses authored material after context has been established; it must not silently manufacture gameplay state.
- **Time policy is explicit.** `util_time` supplies mechanics; the subsystem owns the duration/cooldown policy unless a genuinely global policy exists.
- **Targeting is normalised at the boundary.** Subsystems consume a validated target result rather than reimplementing click/selection interpretation.
- **Persistence is intentional.** `util_records` may support transient and persistent representations, but only domain-significant history should be persisted. Do not persist every intermediate interaction merely because it can be stored.
- **No utility may absorb another utility's governing question merely for convenience.** Thin composition helpers are acceptable; duplicate ownership is not.
- **Prefer authored data over branching script forests.** Repeated contextual cases should become profiles/libraries/facets where that makes builder intent clearer.
- **Fail closed on invalid authored context.** Missing/invalid profile, target, record or temporal state must not silently broaden eligibility.

## Worked composition: Red Cutlass sighting

```text
route matches offshore profile
    -> weather/night facets apply
    -> transient sighting record created
    -> player targets distant ship/lookout point
    -> lore/investigation reveals permitted facets
    -> contextual line bank selected
    -> sighting enters cooldown
```

Responsibilities remain separated:

- route/offshore meaning: Red Cutlass/world subsystem;
- route/profile applicability: `util_matching`;
- weather/night facet membership: `util_flagsets`;
- this sighting's state: `util_records`;
- selected ship/lookout: `util_target`;
- contextual prose/dialogue: `util_library`;
- cooldown/expiry: `util_time`.

## Worked composition: divine omen

```text
recent acts + patron + sacred location + vow state match authored omen profile
    -> omen interaction recorded
    -> contextual manifestation selected
    -> subsystem performs cinematic camera/VFX
    -> only religious history with future world-rule value is persisted
```

The omen subsystem owns theology, eligibility policy, consequences, camera and VFX. The common utilities own only their reusable mechanical questions.

## Adoption rule

For new systems and material expansions, use this split by default.

For existing systems, migrate opportunistically when:
- touching the relevant code already;
- duplicate local mechanics are discovered;
- a one-off implementation is about to gain a second consumer; or
- a subsystem-local helper has clearly become a common mechanic.

Do not churn stable code merely to satisfy naming symmetry. Refactoring must reduce duplication or clarify ownership.

## Review test

During implementation/review, ask:

1. Is this code deciding a **world rule**, or answering one of the six common mechanical questions?
2. If it answers a common question, is it using the canonical utility?
3. Has a utility accidentally acquired domain policy or side effects?
4. Is persistent state limited to information with future gameplay value?
5. Could a builder understand the authored profile/library without reading a branching script forest?

If the ownership is unclear, stop and resolve the boundary before adding another helper.

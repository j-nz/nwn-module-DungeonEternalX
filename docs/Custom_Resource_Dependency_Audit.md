# Ascension Island Custom Resource Dependency Audit

Status: current master audit
Scope: tracked Ascension Island module and hak resources

## Executive finding

The live PRC-derived Ranger spell block is now corrected to use the PRC presentation resources actually supplied for those spells.

Ascension keeps gameplay logic in `src/nss/`. PRC client presentation resources required by an adopted feature live in the hak. Stock NWN resources are used only where PRC8 itself uses stock engine resources or where Ascension has explicitly chosen a different presentation.

## Live custom spell block

The current custom block occupies rows 840-844 of `hak/src/spells.2da`.

| Row | Spell | Live icon | Script | PRC presentation result |
| --- | --- | --- | --- | --- |
| 840 | `AI_DetectFavoredEnemies` | `is_detect_fave` | `sp_det_favenmy` | full PRC icon restored; runtime effects are stock resources |
| 841 | `AI_Snare` | `is_snare` | `sp_snare` | full PRC icon restored; PRC-derived persistent AOE retained; runtime entangle VFX is stock |
| 842 | `AI_SpellslayerArrow` | `is_spslay_arrow` | `sp_spslay_arrow` | full PRC icon restored; runtime impact/dispel VFX are stock |
| 843 | `AI_Treeshape` | `is_treeshape` | `sp_treeshape` | full PRC icon restored; PRC behavior uses stock tree/placeable/VFX resources |
| 844 | `AI_Forestfold` | `is_forestfold` | `sp_forestfold` | PRC icon already correct; runtime effects are stock resources |

The existing `iss_*` PRC icon variants remain packaged as supporting resources. `fot_snare.tga` is also packaged from PRC8.

## Donor integrity

The governed live assets are byte-identical to the PRC8 donor blobs. CI verifies their Git blob hashes and verifies that the spell rows bind to the intended full PRC icons.

See `docs/PRC_Presentation_Resource_Manifest.md` for the donor hashes.

## Snare persistent AOE

`vfx_persistent.2da` adds row 47 `AI_VFX_PER_SNARE`.

The `sp_snarea` field is the ONENTER script callback. `src/nss/sp_snarea.nss` exists. It is not a missing model resref.

The actual visible entangle applied by the PRC-derived behavior is the stock engine `VFX_DUR_ENTANGLE`. PRC8's own spell implementation also relies on stock engine resources for this presentation, so no invented replacement asset is required.

## Historical implementation loss discovered

A separate October implementation block that was previously reported complete is absent from the current Git tree/history. It cannot honestly be classified as live.

The missing block includes:

- False Life
- Disintegrate
- Eyebite
- Divine Sacrifice
- Shield Other
- Hammer of Righteousness
- Sunmantle
- Blood of the Martyr
- Swashbuckler
- Warlock

The earlier implementation record also stated that Disintegrate used `is_disint.tga` and `fot_disintegrate.tga`, Swashbuckler used PRC class resources, and Warlock carried a 20-asset PRC presentation set. Those resources and the associated implementation are not present in current `master`.

They must be restored as complete feature units: scripts/2DA/TLK/integration plus the exact PRC presentation resources. Orphaning their artwork in the live hak without the corresponding implementation is not considered restoration.

## Resource rule

For every PRC-derived Ascension feature:

1. identify the authoritative PRC8 donor implementation;
2. enumerate feature-owned icons, VFX, models, textures, sounds and required 2DA support;
3. distinguish PRC-owned client files from stock NWN resources merely referenced by PRC scripts;
4. keep Ascension runtime/gameplay NWScript in `src/nss/`;
5. put required client resources in the hak;
6. record donor provenance;
7. verify the packaged file hashes and 2DA bindings in CI where practical.

Do not replace an available PRC presentation resource with a stock substitute merely for convenience.

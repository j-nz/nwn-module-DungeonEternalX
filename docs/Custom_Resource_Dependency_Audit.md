# Ascension Island Custom Resource Dependency Audit

Status: current master audit
Scope: tracked Ascension Island module and hak resources

## Executive finding

Ascension Island currently does **not** carry a library of bespoke VFX/model/sound assets in the hak.

The tracked hak contains five custom spell icons plus two 2DA files. The current custom spell package deliberately reuses stock Neverwinter Nights VFX, models, animations and sounds. This is valid and explains why the hak is small despite substantial script-side gameplay work.

## Repository inventory

- NWScript source under `src/nss/`: 1,239 tracked `.nss` files.
- Hak resource files under `hak/src/`: 8 files total.
- Binary/client asset types currently tracked outside the hak: none.
- Custom model files (`.mdl`): none.
- Custom material files (`.mtr`): none.
- Custom texture files other than the five spell icons: none.
- Custom sound/music files: none.

Current `hak/src/` contents:

- `PRC_ASSET_NOTICE.txt`
- `is_forestfold.tga`
- `iss_detect_fave.tga`
- `iss_snare.tga`
- `iss_spslay_arrow.tga`
- `iss_treeshape.tga`
- `spells.2da`
- `vfx_persistent.2da`

## Custom spell rows

The custom spell block currently occupies rows 840-844 of `spells.2da`.

| Row | Spell | Icon | Script | Resource result |
| --- | --- | --- | --- | --- |
| 840 | `AI_DetectFavoredEnemies` | `iss_detect_fave` | `sp_det_favenmy` | Icon supplied by hak; runtime VFX are stock NWN |
| 841 | `AI_Snare` | `iss_snare` | `sp_snare` | Icon supplied by hak; custom persistent-AOE row; visible VFX stock NWN |
| 842 | `AI_SpellslayerArrow` | `iss_spslay_arrow` | `sp_spslay_arrow` | Icon supplied by hak; runtime VFX stock NWN |
| 843 | `AI_Treeshape` | `iss_treeshape` | `sp_treeshape` | Icon supplied by hak; tree appearances/placeables and VFX are stock NWN resources |
| 844 | `AI_Forestfold` | `is_forestfold` | `sp_forestfold` | Icon supplied by hak; runtime VFX stock NWN |

All five referenced spell scripts are present under `src/nss/`.

## Snare persistent AOE

`vfx_persistent.2da` adds row 47:

`AI_VFX_PER_SNARE`

This row does **not** reference a missing custom VFX model. The `sp_snarea` value is in the `ONENTER` script column, and `src/nss/sp_snarea.nss` exists.

The visible entangle applied by the area script is the stock engine effect:

`VFX_DUR_ENTANGLE`

The cast script also uses the stock:

`VFX_IMP_AC_BONUS`

Therefore there is no missing `sp_snarea` model or VFX file.

## Runtime visual dependencies confirmed

The current custom spell scripts use stock NWN visual-effect constants including:

- `VFX_DUR_ENTANGLE`
- `VFX_IMP_AC_BONUS`
- `VFX_IMP_REDUCE_ABILITY_SCORE`
- `VFX_IMP_DISPEL`
- `VFX_DUR_CUTSCENE_INVISIBILITY`
- `VFX_IMP_POLYMORPH`
- `VFX_DUR_CESSATE_POSITIVE`
- `VFX_IMP_IMPROVE_ABILITY_SCORE`

Treeshape also selects stock placeable resrefs:

- `x0_smallpine`
- `plc_treeautumn`
- `plc_tree`
- `x0_deadtree`

These do not require additional hak assets.

## Classes, quasi-classes and scripted systems

A large amount of Ascension class and gameplay work is implemented as NWScript logic rather than new engine-facing client resources. Script-side systems can use stock VFX constants without adding anything to the hak.

Accordingly, the existence of custom classes, quasi-classes, creature abilities, chat systems, investigation systems, spell logic or NWNX-backed functionality does not by itself imply a new hak asset dependency.

A resource belongs in the hak only when the client actually needs a non-stock resource: for example a new icon, model, texture, tileset asset, sound, GUI resource, or a modified 2DA required by that feature.

## Missing-resource finding

No missing custom VFX/model/sound file was identified in the currently tracked custom spell package.

The previous suspicion that `sp_snarea` was a missing VFX model was incorrect; it is an NWScript callback and is present in `src/nss/`.

## Orphan finding

The five custom icon TGAs all correspond to live custom spell rows. Neither custom 2DA is orphaned:

- `spells.2da` supplies the custom spell definitions.
- `vfx_persistent.2da` supplies the custom Snare persistent-AOE definition.

## Policy consequence

Do not add bespoke VFX files merely because a system is custom. Reuse stock assets when they fit.

When a system genuinely needs a distinctive non-stock visual/audio/client asset, add that supporting resource to the hak and record its provenance. Keep its gameplay scripts in `src/nss/`.

Future custom-resource imports should be checked against this document and the governed hak-resource policy.

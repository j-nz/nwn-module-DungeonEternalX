# PRC Presentation Resource Manifest

Donor: Jaysyn904/PRC8 (MPL-2.0)
Policy: Ascension mechanics/scripts stay in `src/nss/`; PRC client presentation assets required by adopted PRC features live in the hak.

## Live Ranger spell block

The current live PRC-derived Ranger spell block is corrected to use full PRC spell icons rather than the smaller `iss_*` substitutions.

| Ascension spell | PRC icon packaged | Donor blob |
| --- | --- | --- |
| Detect Favored Enemies | `is_detect_fave.tga` | `5fbe6c9b384a023b40b2b7cd3e019f9701618440` |
| Snare | `is_snare.tga` | `baf7fca9d534223e8a61eb790960e08138f984fa` |
| Snare supporting target icon | `fot_snare.tga` | `d1cc27d03ff410dd314f317e98f38aeb0e44a17c` |
| Spellslayer Arrow | `is_spslay_arrow.tga` | `a3efa93de7f7e1e126e6ea9874d3f110b1dba7e3` |
| Treeshape | `is_treeshape.tga` | `32df4ea30fdb53ce98353c48a0a2891dfd940a37` |
| Forestfold | `is_forestfold.tga` | `c7b839f8ea894413bca4c129a2f43ea16182dc8e` |

The existing `iss_*` files are retained as PRC supporting icon variants.

## VFX rule

Do not substitute a stock effect for a PRC-owned custom VFX resource when PRC supplies a feature-specific client asset. Conversely, do not invent a "PRC VFX" where PRC itself uses a stock NWN resource.

For the five currently live Ranger spells, PRC8's own spell definitions/scripts primarily invoke stock NWN VFX. Snare's custom persistent-AOE definition is retained in `vfx_persistent.2da`; its `sp_snarea` field is an ONENTER script callback, not a model resref.

## Lost October implementation block

The following PRC-derived implementations were previously reported complete but are absent from the current live Git history/tree and therefore cannot truthfully be marked live until restored:

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

Known PRC presentation requirements from the earlier implementation record include:
- Disintegrate: `is_disint.tga`, `fot_disintegrate.tga`
- Divine Sacrifice: `is_divine_sac.tga`
- Hammer of Righteousness: `is_ham_right.tga`
- Sunmantle: `is_sunmantle.tga`
- Swashbuckler: `ir_swash.tga`
- Warlock: `ir_warlock.tga`, Eldritch Blast icon, and one PRC icon for each implemented invocation

Those assets must be restored together with their missing implementation rows/scripts, not left as unexplained orphan files.

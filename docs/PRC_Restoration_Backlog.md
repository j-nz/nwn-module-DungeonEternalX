# PRC-Derived Restoration Backlog

This file records PRC-derived Ascension Island work that was previously reported implemented but is absent from the current live repository.

It exists because GitHub Issues are disabled for this repository.

## Restoration candidates

### False Life
Previously reported:
- custom spell row 1798
- `ai_false_life.nss`
- Ascension-native spell hooks
PRC8 presentation: PRC spell behavior uses stock/available presentation unless a feature-owned asset is verified.

### Disintegrate
Previously reported:
- custom spell row 1799
- `ai_disintegrate.nss`
- PRC presentation assets `is_disint.tga` and `fot_disintegrate.tga`
- governed touch/SR/save/event handling

### Eyebite
Previously reported:
- custom spell row 1800
- `ai_eyebite.nss`
- governed spell hooks

### Divine Sacrifice
Previously reported:
- custom spell block 1850-1859
- Paladin/Cleric/Archivist integration
PRC8 feature-owned icon: `is_divine_sac.tga`

### Shield Other
Previously reported:
- custom spell block 1850-1859
- Paladin/Cleric/Archivist integration
PRC8 spell row uses stock `is_X1Shield` presentation; do not invent a custom PRC icon.

### Hammer of Righteousness
Previously reported:
- custom spell block 1850-1859
- Paladin/Cleric/Archivist integration
PRC8 feature-owned icon: `is_ham_right.tga`; PRC8 spell row otherwise references stock NWN holy VFX/SFX resources.

### Sunmantle
Previously reported:
- custom spell block 1850-1859
- Paladin/Cleric/Archivist integration
PRC8 feature-owned icon: `is_sunmantle.tga`; runtime presentation otherwise uses stock NWN holy resources.

### Blood of the Martyr
Previously reported:
- custom spell block 1850-1859
- Paladin/Cleric/Archivist integration
PRC8 spell row uses stock `is_Heal` presentation; do not invent a custom PRC icon.

### Swashbuckler
Previously reported:
- base class row 60
- `classes.2da`
- `cls_feat_swash.2da`
- `cls_skill_swash.2da`
- `cls_bfeat_swash.2da`
- retained custom feat IDs 1900-1917
- `src/nss/ai_swashbuckler.nss`
PRC8 feature-owned class icon: `ir_swash.tga`.

### Warlock
Previously reported:
- class row 239
- at-will invocation progression
- Eldritch Blast plus shape/essence/utility invocations
- no summon/demon-pet subsystem
- 20 PRC8 presentation assets: `ir_warlock.tga`, Eldritch Blast icon, and one PRC icon for each of 18 implemented invocations

The exact 18-icon set must be reconstructed from the implemented invocation roster at restoration time and checked against PRC8 donor blobs; do not guess from the broader PRC Warlock catalogue.

## Completion rule

A restoration item is complete only when:
- Ascension NWScript exists under `src/nss/`;
- all 2DA/TLK/class/spell bindings are live;
- exact feature-owned PRC client assets are in the hak;
- stock resources are used only where PRC8 itself uses stock resources or Ascension explicitly overrides presentation;
- provenance is recorded;
- compilation/integration tests pass;
- no `.nss`, `.ncs`, or `.ndb` is shipped in the hak.

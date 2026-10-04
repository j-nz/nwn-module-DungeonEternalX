# Ascension Island Hak Resource Policy

## Rule

Ascension Island-owned NWScript source belongs in the normal module repository under `src/nss/` and is compiled as part of the module build.

Client hak packages are supporting-resource packages. They must not contain Ascension Island-owned NWScript source or compiled gameplay logic.

## Hak content

Hak source may contain resources that genuinely need hak/client distribution, including:

- `.2da`
- icons and textures such as `.tga` / `.dds`
- models and model support files
- tileset resources
- VFX resources
- sounds/music
- GUI resources
- item/appearance resources
- other non-script client-support assets required by an approved resource package

## Prohibited by default in `hak/`

- `.nss` — NWScript source
- `.ncs` — compiled NWScript
- `.ndb` — NWScript debug information

If a third-party package genuinely requires a hak-priority script, that is an explicit reviewed exception; it must not be introduced silently.

## Import rule

When importing a third-party hak or resource pack:

1. Inspect it for `.nss`, `.ncs`, and `.ndb`.
2. Required source logic is integrated into `src/nss/` where licensing permits and compiled with the normal module.
3. Duplicate or obsolete script copies are not retained in the hak.
4. Client-support resources remain in the hak package.
5. Any unavoidable hak-priority script exception must be documented with the dependency and reason.

## Current state

At adoption, the tracked `hak/src/` contains no `.nss`, `.ncs`, or `.ndb` resources. The hak build configuration already packages only its approved supporting asset extensions.

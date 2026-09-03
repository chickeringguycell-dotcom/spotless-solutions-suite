# Viper Male Avatar Dual Role Policy

Status: locked design decision

Viper Studios will support a Male Avatar pipeline with two clearly separated roles.

## 1. Male Companion Role

The Male Companion is a Viper character lane.

He may eventually serve as Aria's companion, helper, counterpart, optional in-world assistant, or guided support character inside Viper Studios.

Allowed future capabilities:

- Conversation
- Animation
- Idle behavior
- Gestures
- Walking
- Reactions
- Guided user assistance
- Scene presence alongside Aria

This role may be protected or semi-protected. He is not a public creator mannequin unless a separate public-safe derivative is explicitly created.

## 2. Male Creator Base Role

The Male Creator Base is a public creator workbench.

Creators may use this version for:

- Clothing testing
- Hair testing
- Accessory testing
- Skin testing
- Animation testing
- Avatar-content development

The Male Creator Base must be generic, public-safe, creator-compatible, and clearly separate from any protected or story character.

## Required Separation

- Aria remains protected and is not public-editable.
- The Male Companion version is a Viper character lane.
- The Male Creator Base version is the public workbench.
- Public creators test male products on the Male Creator Base, not on Aria and not on any protected companion or story character.
- Naming and metadata must prevent confusion between companion and creator-base assets.

## Naming Rules

Recommended IDs:

- `male-companion-v1`
- `male-creator-base-v1`

Recommended labels:

- `Male Companion V1`
- `Male Creator Base V1`

## Metadata Rules

Every male avatar asset must declare:

- `role`
- `publicCreatorBase`
- `protectedCharacter`
- `allowedUse`
- `disallowedUse`
- `source`
- `licenseStatus`
- `runtimeAsset`
- `sourceAsset`

## Goal

Build a clean male avatar pipeline where Viper can have an Aria companion character while also giving public creators a safe, generic male body for testing and creation.

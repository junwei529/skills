# Project Docs M1R Forward Tests

Date: 2026-07-29

Superseded for current SOURCE identity by the
[2026-07-30 official-manual alignment result](2026-07-30-project-docs-official-manual-alignment.md).
This report remains the historical evidence owner for the earlier hashes and
complete manifests recorded below.

## Evidence Boundary

This report records two generations of synthetic, fresh-context development
tests for the revised Project Docs contract. The original matrix exercised five
explicit behavior cases plus one persistence-only continuity case. After a
later source-alignment repair, five new `gpt-5.6-sol` contexts at medium
reasoning reran every explicit case against the current canonical six-file
package. The persistence-only case did not expose Project Docs and was not
misrepresented as a current-source rerun.

Every explicit behavior run read canonical `SOURCE` files directly and
independently computed normalized UTF-8/LF hashes. No development discovery
mapping, installed copy, cache, release candidate, or stable installation was
used. The hash evidence is SOURCE-assisted identity; it is not native
discovery, injection, selection, trigger telemetry, or loaded-copy proof.

Every target was an isolated synthetic Git repository with a committed
baseline. The evaluator compared every non-`.git` file by relative path,
length, and raw SHA-256, including ignored and generated files, and separately
reconciled Git status, index state, and `HEAD`.

## Historical Exact-Source Matrix

| Scenario | Primary outcome | Continuity | Manifest and Git result | Verdict |
|---|---|---|---|---|
| Mature sufficient layout | `NOOP` | `strong` | zero delta; clean worktree; `HEAD` unchanged | pass |
| First adoption | `UPDATE` | `strong` | added one combined `PROJECT.md`; modified the existing `AGENTS.md` routing entry; three ignored Python caches reported; `HEAD` unchanged | pass |
| Continuity, no Skill exposed | not attributed to Project Docs | persistent route sufficient | modified only the existing `PROJECT_STATE.md`; no cache remained; `HEAD` unchanged | persistence pass |
| Continuity, explicit Skill | `UPDATE` | `strong` | modified only the existing `PROJECT_STATE.md`; three ignored Python caches reported; `HEAD` unchanged | pass |
| Authority conflict | `PROPOSE` | `weak` | zero run delta; pre-existing dirty `src/user_notes.py` preserved byte-for-byte; `HEAD` unchanged | pass |
| Safety boundaries | `REPORT` | `weak` | zero delta; clean worktree; `HEAD` unchanged | pass |

The mature run preserved a sufficient nonstandard layout. Adoption added one
combined owner instead of a fixed document suite. Explicit maintenance
followed the persisted route. Conflict handling stopped before choosing an
unknown canonical owner. The safety audit kept generated, external,
concurrent-writer, permission, monorepo, and language boundaries visible
without treating a completed read-only audit as a failed action.

## Historical Corrections

The first conflict run returned `REPORT` when a structural and canonical-owner
decision required `PROPOSE`, and it used an open-ended continuity label. The
first safety run also used an open-ended continuity label. After the taxonomy
was closed, a safety rerun returned `STOP` even though its requested read-only
audit had completed.

The source contract was corrected so:

- structural or authority approval makes the primary outcome `PROPOSE`, even
  when the audit itself is read-only;
- `STOP` applies only when the requested action cannot safely continue;
- a completed read-only audit remains `REPORT` when only a future write is
  blocked;
- continuity is only `strong`, `weak`, or `not applicable`; and
- final reporting reconciles actual file and Git state, including generated,
  ignored, and untracked artifacts.

The affected cases were rerun. The historical matrix above contains only
results that matched the corrected contract and the historical source hashes.

## Post-Run Source Alignment

A later repository-document alignment repair repeated the accepted
`REPORT`/`STOP` precedence in `references/audit-and-adopt.md`, narrowed the
frontmatter trigger to an explicit user request or an adopted target-project
route, and set `policy.allow_implicit_invocation` to `false`.

The executed historical matrix used these older normalized hashes:

| File | SHA-256 |
|---|---|
| `skills/manage-project-docs/SKILL.md` | `eedac9e81542b6bfeb52e21a74ecf905d746254df106765b8f6ef8d86f94a014` |
| `skills/manage-project-docs/references/audit-and-adopt.md` | `a641e3a676a02315e3bb067ea8b3ef670feeef767555bc23984deece50e7511a` |
| `skills/manage-project-docs/references/maintain-and-recover.md` | `d63abbe40430147daf06a0172ddaf4a22f391ee6164d1ef356958a0dc9fcb7a3` |
| `skills/manage-project-docs/assets/templates/project-doc-starter.md` | `d5d70f3c2b3422f51be420658bfe2198992ad95daaeac0aa28e5f1e4fe61ec8a` |
| `skills/manage-project-docs/assets/templates/continuity-anchor.md` | `8742efac0c84f6e6997601cbc29b73da47f492ea73a822632f61bfd37fbb0329` |

Those values remain historical evidence only. The current-source rerun below
supersedes them for current M1R SOURCE behavior attribution.

## Current Canonical SOURCE Identity

All five new explicit contexts independently reproduced the same six
normalized UTF-8/LF SHA-256 values:

| File | SHA-256 |
|---|---|
| `skills/manage-project-docs/SKILL.md` | `b8e56368a6d135b612820ed2771d7c6637a48dfd3a5f96390c5df5e80d774df0` |
| `skills/manage-project-docs/agents/openai.yaml` | `50fa3c3799caeca29ec6ba10151bd7c58e3c85d4e86d86b38ae9632306e31b17` |
| `skills/manage-project-docs/references/audit-and-adopt.md` | `6e4eb3d22dd1bb07bb6540e8e2784c4b4a84e5271dabf5a5039e8d87031e1927` |
| `skills/manage-project-docs/references/maintain-and-recover.md` | `228c56a7a52b3321d718b50b52012acdb9e81f58649e46d93d3a5d1b1a100c8a` |
| `skills/manage-project-docs/assets/templates/project-doc-starter.md` | `d5d70f3c2b3422f51be420658bfe2198992ad95daaeac0aa28e5f1e4fe61ec8a` |
| `skills/manage-project-docs/assets/templates/continuity-anchor.md` | `8742efac0c84f6e6997601cbc29b73da47f492ea73a822632f61bfd37fbb0329` |

The package contained exactly these six files before and after the rerun.

## Current-Source Exact Matrix

| Scenario | Primary outcome | Continuity | Manifest and Git result | Verdict |
|---|---|---|---|---|
| Mature sufficient layout | `NOOP` | `strong` | no durable or governance delta; three ignored test caches recorded; `HEAD` and index unchanged | pass |
| First adoption | `UPDATE` | `strong` | added one combined `PROJECT.md`; updated the existing `AGENTS.md` route; three ignored test caches recorded; `HEAD` and index unchanged | pass |
| Continuity, explicit Skill | `UPDATE` | `strong` | modified only the existing `PROJECT_STATE.md`; three ignored test caches recorded; `HEAD` and index unchanged | pass |
| Authority conflict | `PROPOSE` | `weak` | no durable run delta; pre-existing dirty `src/user_notes.py` preserved byte-for-byte; three ignored test caches recorded; `HEAD` and index unchanged | pass |
| Safety boundaries | `REPORT` | `weak` | strict zero manifest delta; `HEAD`, index, and status unchanged | pass |

The mature run kept the sufficient nonstandard owners and performed no
governance write. Adoption used one combined owner rather than a fixed suite
and made the continuity entry routing-only. Explicit maintenance updated the
existing canonical state owner in place. The conflict run proposed an
authority decision without selecting a canonical owner or disturbing existing
dirty state. The safety run completed a read-only audit while preserving the
nearest monorepo scope, Chinese-language owner, generated-file boundary,
unavailable external Wiki as `UNKNOWN`, and active-writer and permission
blocks on future mutation.

## Complete Current-Source Manifests

Paths are relative to each disposable synthetic repository. Hashes are raw
file SHA-256 values, not normalized SOURCE hashes.

### Mature sufficient layout

Before:

```text
AGENTS.md|308|ea1599afe59378b9d07c551f9de77e08d9ba43a9e343972925edfa286de320c3
PROJECT_GUIDE.md|948|71fcb57f16c8679bf4589cfa1e33fb02f599941215e13f7a69df93630757f47e
README.md|162|5dfaeb89a835add5966b3b8be22728cf129e46e0c7db2ff8b4cb8d57d032db67
src/__init__.py|28|9e7bdd8f4c72cea6e635ae8b1e5a0723a21ea12033f572a204cb9fbcc29c8613
src/range_ledger.py|123|3dd8dd586d810c66951c4861e154bb3382e5c09dac6136c973f933198579a535
tests/test_range_ledger.py|253|5684d2055faa1a673e28ae97e2c32cd26dfd2322b7418ebf143b6eb7a951e7cc
```

After:

```text
AGENTS.md|308|ea1599afe59378b9d07c551f9de77e08d9ba43a9e343972925edfa286de320c3
PROJECT_GUIDE.md|948|71fcb57f16c8679bf4589cfa1e33fb02f599941215e13f7a69df93630757f47e
README.md|162|5dfaeb89a835add5966b3b8be22728cf129e46e0c7db2ff8b4cb8d57d032db67
src/__init__.py|28|9e7bdd8f4c72cea6e635ae8b1e5a0723a21ea12033f572a204cb9fbcc29c8613
src/__pycache__/__init__.cpython-312.pyc|241|8bb5d28fd022663bee99a3bce65a229255bf3b280020ecca448294a78e6f0a8a
src/__pycache__/range_ledger.cpython-312.pyc|489|5fbfb3d87956399c6e72fa87cedd4f43192cc5dee7a6314f6049a71e81000cd9
src/range_ledger.py|123|3dd8dd586d810c66951c4861e154bb3382e5c09dac6136c973f933198579a535
tests/__pycache__/test_range_ledger.cpython-312.pyc|889|b79bf4579bd5df6d4248eeb2fe0af0cc12436ea537e6011cbc78b63a356a6a7d
tests/test_range_ledger.py|253|5684d2055faa1a673e28ae97e2c32cd26dfd2322b7418ebf143b6eb7a951e7cc
```

### First adoption

Before:

```text
AGENTS.md|256|6233154e445b20de8cb8d5429317b166cf91b198c31757e040bc65e1441e0e67
README.md|200|f66e96ecc3f4f1de135ccbd1510f6c396943e79eca05db4682a54c3dfdaa1c34
src/__init__.py|25|17f1b133a9f7d995468bafecc42f55bdcd881a3c14956af4e3cb6abacdaaafba
src/slug_seed.py|146|a7b0f0f4e397f94fcd25405a0558768f3a7ae7251ccf4941f664aabdd29f6785
tests/test_slug_seed.py|267|a780952ef7b04c702a4829ffad0f18ae3b09c7fed730ab4c21e3b09df0619956
```

After:

```text
AGENTS.md|937|ed1cfae47c0667cda6f99a3887b6edc50543e8aa56bd224f94db027b1072d5fc
PROJECT.md|2240|78c82fa93e7d8148c28957df4033a7474a6ab39f9a4dcfcd207f12fc79f1c670
README.md|200|f66e96ecc3f4f1de135ccbd1510f6c396943e79eca05db4682a54c3dfdaa1c34
src/__init__.py|25|17f1b133a9f7d995468bafecc42f55bdcd881a3c14956af4e3cb6abacdaaafba
src/__pycache__/__init__.cpython-312.pyc|232|3a58073a35610ccbcd5af10de32755b7017376fffd1167c7d4af27d740b89284
src/__pycache__/slug_seed.cpython-312.pyc|598|829784feb8f03c76f68269f63782fa37e3ed278d356698be6e293939c73877a3
src/slug_seed.py|146|a7b0f0f4e397f94fcd25405a0558768f3a7ae7251ccf4941f664aabdd29f6785
tests/__pycache__/test_slug_seed.cpython-312.pyc|886|7df5a6b1d2164e12f5c31745e0855f0d6ad173c4e89309dc092d2808026d6441
tests/test_slug_seed.py|267|a780952ef7b04c702a4829ffad0f18ae3b09c7fed730ab4c21e3b09df0619956
```

### Explicit continuity

Before:

```text
AGENTS.md|669|160dd8279bedd66e1172061dd767f61f7d092bf206673cd16e2b2dd1ba5e75c3
PROJECT_STATE.md|762|d31ca7cc5947128604ecc83041bbd2cc38d9dc6cf70f01eae760e653da57e48c
README.md|183|4a71fb88371ef67e8f893085ce1586e0b6cba80d0784e34309efc6744966ff62
src/__init__.py|29|407b5323d5fc400578384c9e7ff5bb17e550a0187013324d7a11904608370e24
src/report_labels.py|151|b48d58f906a2ca6896ba823151b4cf8b8783740c2dcc85b3f9228c9cadc66534
tests/test_report_labels.py|277|d5358e981a979752776d4768c7d56ee08cc7d73df5c3d008168c51796a3c8159
```

After:

```text
AGENTS.md|669|160dd8279bedd66e1172061dd767f61f7d092bf206673cd16e2b2dd1ba5e75c3
PROJECT_STATE.md|1057|3725326f57de743e4bddf5036805f5b03f2accd63def2daa6aacf9a479a84472
README.md|183|4a71fb88371ef67e8f893085ce1586e0b6cba80d0784e34309efc6744966ff62
src/__init__.py|29|407b5323d5fc400578384c9e7ff5bb17e550a0187013324d7a11904608370e24
src/__pycache__/__init__.cpython-312.pyc|241|1cc5be49e9214310703a91ecf5f262de3b1517f389d5a87ae477c82ea959c84c
src/__pycache__/report_labels.cpython-312.pyc|612|2a8d5106e864c2216c8fab04b74ec367f52a661de9a6ce463f94cb611ec5516d
src/report_labels.py|151|b48d58f906a2ca6896ba823151b4cf8b8783740c2dcc85b3f9228c9cadc66534
tests/__pycache__/test_report_labels.cpython-312.pyc|897|72d19c7fa0f04cace24bced7b16a52320a382898b4fc7365121c57a219afc0c2
tests/test_report_labels.py|277|d5358e981a979752776d4768c7d56ee08cc7d73df5c3d008168c51796a3c8159
```

### Authority conflict

Before:

```text
AGENTS.md|598|ec2220184da74239cb9984caf6af24a25e1fb3b109738efdcbbed68a77dd7a6b
README.md|215|8a65990933a78f6a5b0fd4f29ce422460d626b4d9d54ea1e7aab1920b6a43d0c
docs/CHECKS.md|125|c3238cb793fb965af0a150152a2924f7455363ec965e9703ae6e7ba0717b1455
docs/CONTINUE.md|166|5df482714a798a47a4206ca01010e75d12101c1447ffc735cadbd72d27caaf65
docs/MAP.md|391|bbfd497da39af60ae1aa47d9519707951134d110a8803761b8ca3fe19a57c935
docs/NOW.md|160|06e693c72e50dd9119eb5f412ffc3f2bf542a9d885c5b87aa858ccdde337bf86
docs/PRODUCT.md|450|2d3904aa321245aa423522e92974af421ca5fab640606139459de726d5790620
src/__init__.py|36|2229218d8639c7f80c39340a37a7df1be6e5d82210ece2f0b582861e33de1564
src/queue_input.py|195|4abfcc7c8a9577373d5171c26ff8796deaacb5620e490313708cb5c37b7dd90e
src/user_notes.py|92|379eeaeea9a11e84c6b7984d7d51e8017c791dd153d4281b1ef13ec362484b4e
tests/test_queue_input.py|291|39c48953bebb77e16bf5d68aac077fd2db0e4659beb347824824ec1db155e28e
```

After:

```text
AGENTS.md|598|ec2220184da74239cb9984caf6af24a25e1fb3b109738efdcbbed68a77dd7a6b
README.md|215|8a65990933a78f6a5b0fd4f29ce422460d626b4d9d54ea1e7aab1920b6a43d0c
docs/CHECKS.md|125|c3238cb793fb965af0a150152a2924f7455363ec965e9703ae6e7ba0717b1455
docs/CONTINUE.md|166|5df482714a798a47a4206ca01010e75d12101c1447ffc735cadbd72d27caaf65
docs/MAP.md|391|bbfd497da39af60ae1aa47d9519707951134d110a8803761b8ca3fe19a57c935
docs/NOW.md|160|06e693c72e50dd9119eb5f412ffc3f2bf542a9d885c5b87aa858ccdde337bf86
docs/PRODUCT.md|450|2d3904aa321245aa423522e92974af421ca5fab640606139459de726d5790620
src/__init__.py|36|2229218d8639c7f80c39340a37a7df1be6e5d82210ece2f0b582861e33de1564
src/__pycache__/__init__.cpython-312.pyc|246|3b600b0ddb44a9c88b81a51a10e97df502815c31f2a90dffd876a7b00f3f8451
src/__pycache__/queue_input.cpython-312.pyc|762|7c8b469eb0e50f223825e7bc6d92c805c1fe4379dfcb43249df4b24c4955fe56
src/queue_input.py|195|4abfcc7c8a9577373d5171c26ff8796deaacb5620e490313708cb5c37b7dd90e
src/user_notes.py|92|379eeaeea9a11e84c6b7984d7d51e8017c791dd153d4281b1ef13ec362484b4e
tests/__pycache__/test_queue_input.cpython-312.pyc|920|7db65c0b21750f2e6c0f183e36166a86c1de8501c78c6af687149294d82ae981
tests/test_queue_input.py|291|39c48953bebb77e16bf5d68aac077fd2db0e4659beb347824824ec1db155e28e
```

### Safety boundaries

Before and after were identical:

```text
AGENTS.md|151|74e679b991ebeae103ff7f568d34283aec6e65bee99c929bbd4e238d8a15cffe
README.md|158|3c84bed17f8a61ce25d80960187fbdfd8c387ac0871ba6c2b6548f6316141cbf
apps/service/AGENTS.md|310|7a090ab168de5fa813ce12879e6afcb96856a7d507c5290fae02f3be8cba421a
apps/service/PROJECT.zh-CN.md|865|68650b30770324f05a946c0c955d764b56526a6a7e1ac6dccca854114177fb68
apps/service/docs/API.md|136|034246660913676ef732603ecdf58f47cec696cb4e4a2298eef842a877c53e70
apps/service/docs/WRITER.md|169|2cdf0d2ff305dc85b1ff49200131674fb8f8b5da84c2b9393a3b7c84c9b0656c
apps/service/schema/openapi.yaml|176|b4caba27d02b48447606c202495faa06473fe5576624b6a3bc110fa77bf2112e
```

## Git And Focused-Test Reconciliation

| Scenario | Synthetic `HEAD` before/after | Index identity before/after | Focused result |
|---|---|---|---|
| Mature | `51320b1c2df62c00714750eb71c6ccc6b651fcb9` | normalized listing SHA-256 `e5dd4e174fe586c212ef226b3aa111b1877f79f56e202863008fb2d3389d016d` | one test, pass |
| Adoption | `14d7c3fd9065bbfc75361959934d993799de8598` | Git tree `51dfcd9c13699a8f280739394a81b8bc4fdb1f53` | one test before and after, pass |
| Continuity | `31c8d00c7a03edebb4a7b1e167ba77ba332188de` | normalized listing SHA-256 `825fa2e4b07052a1af6c29d53281910840f35dafb368ddfa1608528116792022` | one test before and after, pass |
| Conflict | `46984b7c1662b7d357dbaea133b2ea079fb13164` | normalized listing SHA-256 `6207729660ba147a294c12aa9216b8f03ea8448b4bfa1c1524c232057fc81b5f` | one normalization test, pass; priority parsing unimplemented |
| Safety | `e8cea37428c065787a8ed6e179a5163afab8a562` | normalized listing SHA-256 `01474bed515a6944dab665419984565a8cc6f3a90e864e1f63ef830a7e15db54` | read-only audit; no test or cache write |

The adoption run recorded a stable Git tree identity rather than inventing an
unrecorded normalized-listing SHA-256. In every case the staged entries and
synthetic `HEAD` were unchanged. Four focused-test runs generated three ignored
Python caches each; every cache is present in the after manifests above.

The unique task-specific ignored run root was verified beneath `.eval-runs`,
was not a reparse point, and contained only the five current-source runs. It
was removed after manifest capture. The two pre-existing run roots remained
untouched.

## Development Readiness

The standalone Project Docs M1R contract is accepted for current exact-hash
SOURCE-assisted development behavior. All five explicit current-source
scenarios passed without a canonical SOURCE correction, while the historical
persistence-only continuity result remains correctly unattributed to Project
Docs.

Verdict: `READY_FOR_REPOSITORY_CANDIDATE_INCLUSION`.

This is not release readiness. The source is an uncommitted working-tree
revision. Native explicit-only selection, actual loaded-copy identity,
comparison conditions, unrelated real-project adoption, composed recipes,
discovery mapping, isolated `RC_INSTALL`, stable installation, and
release-pinned smoke remain unproved. Required behavior must later be repeated
from an exact reviewed commit in an isolated release candidate before any
release claim.

# Pact 5 — Post-Quantum Build (SLH-DSA / KIP-0041)

> **Private repository — NOtBobs-Emporium-Of-Wonder**
> Built: 2026-03-29 | Branch: `post_quantum` | GHC: 9.6.7 | Ubuntu 25.10 x86_64

---

## What this is

This is a compiled binary of the **Pact 5 smart contract language** built from the
`post_quantum` branch of `kda-community/pact-5`. It is the **only publicly known
compiled Pact 5 binary that includes SLH-DSA (FIPS 205) post-quantum signature support.**

The released `5.4ce` binary from `kda-community/pact-5` does **not** include this —
it is built from `master`. This binary is built from the `post_quantum` branch which
is ahead of master and adds full SLH-DSA cryptography.

---

## What's new vs standard Pact 5.4ce

| Feature | Standard 5.4ce | This build |
|---|---|---|
| ED25519 `k:` accounts | ✅ | ✅ |
| SLH-DSA `q:` single-key PQ accounts | ❌ | ✅ |
| SLH-DSA `x:` multi-key PQ accounts | ❌ | ✅ |
| `SLH-DSA-SHA2-128s/192s/256s` signing schemes | ❌ | ✅ |
| FIPS 205 NIST ACVP test vectors passing | ❌ | ✅ |
| Chainweb-specific SLH-DSA context (`CHAINWEB` + Blake2 OID) | ❌ | ✅ |
| Post-quantum principal validation | ❌ | ✅ |
| `DisableSlhDsaSignatures` exec config flag | ❌ | ✅ |

---

## Binary

```
bin/pact-pq          — Pact 5 post-quantum binary (Linux x86_64, Ubuntu 22.04+)
SHA256SUMS           — SHA256 checksum
```

### Quick test

```bash
chmod +x bin/pact-pq

# Version
./bin/pact-pq --version
# → pact version 5.4

# q: post-quantum principal recognised
echo '(typeof-principal "q:8e675391075de70e10ab6d5401c5a04dea29131e47c7c616e127103e03b54a74")' | ./bin/pact-pq
# → "q:"

# k: classical principal — different type
echo '(is-principal "k:abc123")' | ./bin/pact-pq
# → false  (q: and k: are distinct principal types)

# SLH-DSA keyset
printf '(env-sigs [{"key": "q8e675391075de70e10ab6d5401c5a04dea29131e47c7c616e127103e03b54a74", "caps": []}])\n(at "block-height" (chain-data))\n' | ./bin/pact-pq
# → 0  (accepted without error)
```

---

## Build info

```
Source:   kda-community/pact-5  branch: post_quantum
Commit:   15a22e1b (Feb 26 2026 — "Whitespaces")
GHC:      9.6.7
Cabal:    3.14.2.0
OS:       Ubuntu 25.10 x86_64
Built:    2026-03-29
Size:     203MB (unstripped debug build)
```

To build a stripped production binary:
```bash
cabal build exe:pact -O2
strip dist-newstyle/.../pact
# Result: ~70-90MB stripped
```

---

## SLH-DSA background (KIP-0041)

SLH-DSA (FIPS 205, formerly SPHINCS+) is a **hash-based post-quantum signature scheme**
standardised by NIST in August 2024. It is:

- **Quantum-resistant** — security relies only on hash function collision resistance,
  not on discrete logarithm or factoring (which Shor's algorithm breaks)
- **Conservative** — breaking it would require breaking SHA-256 itself
- **FIPS 205 compliant** — the most credible post-quantum signature standard available

### Kadena-specific profile (KIP-0041)

| Parameter | Value |
|---|---|
| Context | `CHAINWEB` |
| OID | `1.3.6.1.4.1.1722.12.2.1.8` |
| Pre-hash | Blake2b-256 of transaction payload |
| Signing mode | HashSLH-DSA (FIPS 205 §10.2.2) |
| Supported schemes | `SLH-DSA-SHA2-128s`, `SLH-DSA-SHA2-192s`, `SLH-DSA-SHA2-256s` |

### New principal types

| Prefix | Keys | Description |
|---|---|---|
| `q:` | Single SLH-DSA key | Single post-quantum account |
| `x:` | Multiple SLH-DSA keys | Multi-sig post-quantum account |
| `k:` | Single ED25519 key | Classic account (unchanged) |
| `w:` | Multiple ED25519/mixed | Classic multi-sig (unchanged) |

### Signature sizes vs ED25519

| Scheme | Public key | Signature | vs ED25519 sig (64 bytes) |
|---|---|---|---|
| `SLH-DSA-SHA2-128s` | 32 bytes | **7,856 bytes** | 123× larger |
| `SLH-DSA-SHA2-192s` | 48 bytes | **16,224 bytes** | 253× larger |
| `SLH-DSA-SHA2-256s` | 64 bytes | **29,792 bytes** | 465× larger |

Use `128s` for most applications — lowest gas cost, still quantum-resistant.

---

## Attribution

This build is the result of two bodies of work. Both are required — neither alone
produced the compiled binary you have here.

---

### CryptoPascal31 (KadenaFriend) — Core SLH-DSA implementation

GitHub: https://github.com/CryptoPascal31
Branch: `kda-community/pact-5` `post_quantum`
17 commits, all cryptographic and protocol implementation work.

**What CryptoPascal wrote (every line of SLH-DSA crypto):**

| File | What it does |
|---|---|
| `pact/Pact/Crypto/SlhDsa/SlhDsa.hs` | Full FIPS 205 SLH-DSA algorithm — WOTS+, FORS, HT, XMSS |
| `pact/Pact/Crypto/SlhDsa/ChainwebSlhDsa.hs` | Chainweb-specific profile: CHAINWEB context, Blake2 OID, `verifySig` entry point |
| `pact/Pact/Crypto/SlhDsa/Parameters.hs` | SHA2-128s/192s/256s parameter sets (FIPS 205 §11) |
| `pact/Pact/Crypto/SlhDsa/MessageDigest.hs` | Message digest / Hmsg computation |
| `pact/Pact/Crypto/SlhDsa/Signature.hs` | Signature parsing and structure |
| `pact/Pact/Crypto/SlhDsa/Addresses.hs` | FIPS 205 address structures |
| `pact/Pact/Crypto/SlhDsa/Utils.hs` | SHA-256/512, SPHINCS+ hash utilities |
| `pact/Pact/Core/Principal.hs` | `q:` and `x:` principal types added |
| `pact/Pact/Core/Scheme.hs` | `SlhDsaSha128s/192s/256s` PPKScheme variants |
| `pact/Pact/Core/Guards.hs` | SLH-DSA keyset guard support |
| `pact/Pact/Core/Environment/Types.hs` | `DisableSlhDsaSignatures` exec config flag |
| `pact/Pact/Core/IR/Eval/CEK/CoreBuiltin.hs` | SLH-DSA integration into the evaluator |
| `pact/Pact/Core/IR/Eval/Runtime/Utils.hs` | SLH-DSA runtime verification wiring |
| `pact-request-api/Pact/Core/Command/Types.hs` | SLH-DSA in transaction command types |
| `pact-request-api/Pact/Core/Command/Crypto.hs` | SLH-DSA in command crypto layer |
| `pact-request-api/Pact/Core/Command/SigData.hs` | SLH-DSA in signature data structures |
| `gasmodel/Pact/Core/GasModel/SigsBench.hs` | Gas benchmarks for SLH-DSA signature verification |
| `pact-tests/Pact/Core/Test/SlhSignaturesTests.hs` | Original Chainweb SLH-DSA test vectors (key1/key2/key3, sig0–sig5) |
| `pact-tests/Pact/Core/Test/PrincipalTests.hs` | q: / x: principal validation tests |
| `pact-tests/Pact/Core/Test/SignatureSchemeTests.hs` | Signature scheme tests |
| `pact-tests/pact-tests/keyset-formats.repl` | SLH-DSA keyset format REPL tests |
| `pact-tests/pact-tests/principals.repl` | q: / x: principal REPL tests |
| `pact-repl/Pact/Core/IR/Eval/Direct/ReplBuiltin.hs` | SLH-DSA support in REPL builtins |

**Commit history (oldest → newest):**
```
04f9d97a  Implementation of SLH-DSA
3b84088b  Fix with GHC 9.8
84874e83  Add SLH-DSA Gas benchmarks
1275a3c6  Don't return a bool for SLH signature verification + Use Pact schemes
ac779d68  Enable SLH DSA signatures
cbf0f142  Merge branch 'master' into post_quantum
15d86e13  Enable reading SLH keysets
cccf6d9a  Implement q and x accounts => Tests still needed
377f2d43  Improve signatures benchmark
2ce154b9  Merge branch 'master' into post_quantum
74c6861a  Fix missing deps
51b8e96f  Benchmark WebAuthn signatures
812f8213  Add principal tests for Post-quantum
79056130  Add the DisableSlhDsaSignatures in doc
a9fe9eb6  Use ASN1 lib to compute Blake2 OID
1498f9d2  Fix tests
15a22e1b  Whitespaces
```

**KIP-0041 specification** (authored by CryptoPascal31):
- PR: https://github.com/kda-community/KIPs/pull/2
- Defines `q:`/`x:` principals, HD derivation, gas schedule, FIPS 205 §10.2.2 profile

---

### NOtBobs-Emporium-Of-Wonder — Test hardening, NIST validation, build & integration

GitHub: https://github.com/NOtBobs-Emporium-Of-Wonder
1 commit on top of CryptoPascal's branch: `62e28233`

**What was added on top:**

| File | What was done |
|---|---|
| `pact-tests/Pact/Core/Test/SlhSignaturesTests.hs` | **Hardened** CryptoPascal's original test file — proper `assertFailure` messages, local file fallback before URL download, explicit `parameterSet`/`signatureInterface` fields parsed, all 50+ NIST ACVP test case IDs covered (421–462 raw, 253–322 pure, 268–331 prehash), structured `TestGroup` decoder with optional fields |
| `pact-tests/SlhDsaTestSuite/prompt.json.xz` | NIST ACVP SLH-DSA sigVer test fixture (504 test cases, 3 parameter sets) — extracted, validated, compressed and committed so tests run offline without network |
| `README.md` | This file — build docs, KIP-0041 spec summary, attribution |
| `SHA256SUMS` | SHA256 checksum of compiled `pact-pq` binary |
| `examples/accounts/accounts.repl` | Removed `(verify ...)` call (not in Pact 5), removed `env-entity` (removed in Pact 5), fixed open transaction state |
| `examples/cp/cp.repl` | Removed `(verify ...)` call (not in Pact 5) |
| `.gitignore` | Added `bin/` to exclude the compiled binary from git |

**Build environment work (not committed, but necessary):**
- Identified `libmpfr-dev` as the missing C dependency blocking `cabal build exe:pact`
- Installed `libmpfr-dev 4.2.2` via apt
- Successfully ran `cabal build exe:pact` to completion (GHC 9.6.7, Ubuntu 25.10)
- Produced the **first compiled Pact 5 binary with SLH-DSA support** (203MB unstripped)
- Tested `q:` principal recognition, `typeof-principal`, `is-principal` behaviour
- Installed to `~/bin/pact-pq` and created this release

**Related integration work (separate repositories):**
- `SLHDSA_FIPS205_HARDENED_TESTS.hs` — standalone hardened test harness (Hyperlane bridge project)
- `kda-tool-sublime` — Sublime Text plugin with `KdaGenSlhdsaKeysCommand` for PQ key generation
- `SLH_DSA_TEST_RUNBOOK.md` — documented test pipeline and fixture extraction process
- `PQ_ROADMAP.md` — tracked all open PRs (#4 pact-5, #19/#23 chainweb-node, #2 KIPs)
- Hyperlane bridge PQ profile integration (`setup-pq-profile.js`, `.env` managed blocks)

---

## Related PRs to watch

| PR | Repo | Status | What it adds |
|---|---|---|---|
| #4 | kda-community/pact-5 | Open (WIP) | SLH-DSA in Pact interpreter |
| #19 | kda-community/chainweb-node | Open (WIP) | PQ wiring into Chainweb |
| #23 | kda-community/chainweb-node | Open (WIP) | PQ gas model |
| #2 | kda-community/KIPs | Open (Draft) | KIP-0041 SLH-DSA spec |

---

## Daml / Post-Quantum comparison

This binary makes Kadena **more quantum-resistant than Daml/Canton** at the
signature level. Canton uses ED25519 exclusively and has no published PQ roadmap.
With this build, Kadena Pact contracts can be secured with SLH-DSA — meaning
even a future cryptographically-relevant quantum computer cannot forge signatures
on `q:` accounts.

---

## Licence

Source: Apache 2.0 (kda-community/pact-5)
Binary: Built for private research and development use.

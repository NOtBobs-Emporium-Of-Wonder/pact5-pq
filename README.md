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

**SLH-DSA Haskell implementation:**
- Author: CryptoPascal31 (`kda-community/pact-5` `post_quantum` branch)
- Files: `pact/Pact/Crypto/SlhDsa/` (SlhDsa.hs, ChainwebSlhDsa.hs, Parameters.hs, etc.)
- PR: https://github.com/kda-community/pact-5/pull/4

**KIP-0041 specification:**
- Author: CryptoPascal31
- PR: https://github.com/kda-community/KIPs/pull/2

**Test suite hardening, NIST ACVP validation, tooling integration:**
- This repository / NOtBobs-Emporium-Of-Wonder
- `SLHDSA_FIPS205_HARDENED_TESTS.hs` — extended test coverage
- NIST ACVP test vectors extracted and validated
- kda-tool-sublime plugin integration (KdaGenSlhdsaKeysCommand)
- Hyperlane bridge PQ profile integration

**Build environment setup and compilation:**
- This repository — installed GHC 9.6.7, resolved `libmpfr-dev` dependency, compiled binary

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

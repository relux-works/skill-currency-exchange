# currency-exchange

Project skill for the Exchange CLI — a currency exchange calculator.

## What it covers

- Architecture and project structure (SwiftPM, ExchangeLib, CLI entry point)
- Rate providers: Google scraping (WebKit), rate.am scraping (WebKit), open.er-api.com (REST)
- WebKitEngine pattern (headless WKWebView, setupScript/javaScript lifecycle)
- rate.am DOM structure and extraction strategy (exchange offices page, stale detection, IQR filtering)
- Buy/sell/avg rate semantics
- Output formatting (tax, rates, totals in both currencies)
- Common pitfalls and gotchas

## Supported currencies

Currently: **AMD** (Armenian Dram) and **RUB** (Russian Ruble) only.

The `Currency` enum is designed for extension — adding new currencies is straightforward, but rate providers and CLI logic will need updates (e.g. `--to`/`--from` options instead of hardcoded pair).

## CLI Usage

```bash
# I give 50000 AMD, how much RUB do I get? (Google mid-market rate)
exchange --give amd=50000 --google

# I want to get 10000 RUB, how much AMD do I give?
exchange --get rub=10000 --google

# Average both directions for true mid-market
exchange --give rub=25000 --google --avg

# Cash rate from Armenian exchange offices (rate.am)
exchange --give rub=25000 --ratam

# Mid-market cash rate from rate.am
exchange --give rub=25000 --ratam --avg

# Manual rate
exchange --give amd=50000 --rate 0.205

# With commission (-0.3%)
exchange --give rub=25000 --google --avg --tax=-0.003

# With bonus (+0.3%)
exchange --give rub=25000 --rate 0.205 --tax=0.003
```

### Build & Install

```bash
swift build                    # debug build
swift build -c release         # release build
swift test                     # run tests
bash scripts/setup.sh          # build + install to ~/.local/bin/
```

## Files

- `SKILL.md` — full technical reference

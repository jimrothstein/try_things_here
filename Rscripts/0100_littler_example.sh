#!/usr/bin/env lr

## 0100_littler_example.sh
## First littler script

if (is.null(argv) | length(argv)<1) {
  cat("Usage: installr.r pkg1 [pkg2 pkg3 ...]\n")
  q()
}

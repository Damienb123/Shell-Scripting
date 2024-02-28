#!/bin/bash

total=$(find data -maxdepth 1 -type f -name "*.crs" | wc -1)

echo "Total course records: $total"


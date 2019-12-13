#!/bin/bash
cd output

find -name "*.vcf" -exec cat {} \; | grep -v "fileDate" | grep -v "#CHROM" | md5sum
find -name "*.vcf"
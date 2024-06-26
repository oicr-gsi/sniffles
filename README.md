# sniffles

Workflow to run the Structural Variant caller Sniffles on Oxford Nanopore Data

## Overview

## Dependencies

* [Sniffles](https://github.com/fritzsedlazeck/Sniffles)


## Usage

### Cromwell
```
java -jar cromwell.jar run sniffles.wdl --inputs inputs.json
```

### Inputs

#### Required workflow parameters:
Parameter|Value|Description
---|---|---
`sortedBamFile`|File|Input bam file (must be sorted)


#### Optional workflow parameters:
Parameter|Value|Default|Description
---|---|---|---
`outputFileNamePrefix`|String|basename(sortedBamFile,".bam")|Variable used to set the outputfile name
`additionalParameters`|String?|None|Additional parameters to be added to the sniffles command


#### Optional task parameters:
Parameter|Value|Default|Description
---|---|---|---
`getVCF.sniffles`|String|"sniffles"|sniffles module name to use.
`getVCF.modules`|String|"sniffles/1.0.11"|Environment module names and version to load (space separated) before command execution.
`getVCF.memory`|Int|31|Memory (in GB) allocated for job.
`getVCF.timeout`|Int|24|Runtime for the job in hours.


### Outputs

Output | Type | Description | Labels
---|---|---|---
`vcfFile`|File|VCF file with Structural Variant predictions.|vidarr_label: vcfFile


## Commands
 
 This section lists command(s) run by sniffles workflow
 
 * Running sniffles
 
 Sniffles workflow runs a single task, SV variant calling with sniffles using nanopore data as an input.
 
 ```
    sniffles \
    -m SORTED_BAM_FILE \
    ADDITIONAL_PARAMETERS \
    -v OUTPUT_PREFIX_sniffles.vcf
 ```
 ## Support

For support, please file an issue on the [Github project](https://github.com/oicr-gsi) or send an email to gsi@oicr.on.ca .

_Generated with generate-markdown-readme (https://github.com/oicr-gsi/gsi-wdl-tools/)_

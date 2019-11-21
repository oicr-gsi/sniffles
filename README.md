# sniffles

Workflow to run Structural Variant caller

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
`sortedBamFile`|File|Input directory (directory of the nanopore run)


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


### Outputs

Output | Type | Description
---|---|---
`vcfFile`|File|Output .vcf file


## Niassa + Cromwell

This WDL workflow is wrapped in a Niassa workflow (https://github.com/oicr-gsi/pipedev/tree/master/pipedev-niassa-cromwell-workflow) so that it can used with the Niassa metadata tracking system (https://github.com/oicr-gsi/niassa).

* Building
```
mvn clean install
```

* Testing
```
mvn clean verify -Djava_opts="-Xmx1g -XX:+UseG1GC -XX:+UseStringDeduplication" -DrunTestThreads=2 -DskipITs=false -DskipRunITs=false -DworkingDirectory=/path/to/tmp/ -DschedulingHost=niassa_oozie_host -DwebserviceUrl=http://niassa-url:8080 -DwebserviceUser=niassa_user -DwebservicePassword=niassa_user_password -Dcromwell-host=http://cromwell-url:8000
```

## Support

For support, please file an issue on the [Github project](https://github.com/oicr-gsi) or send an email to gsi@oicr.on.ca .

_Generated with wdl_doc_gen (https://github.com/oicr-gsi/wdl_doc_gen/)_

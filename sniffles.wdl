version 1.0

workflow sniffles {
    input {
        File sortedBamFile
        String outputFileNamePrefix = basename(sortedBamFile, ".bam")
        String? additionalParameters
    }
    parameter_meta {
        sortedBamFile: "Input directory (directory of the nanopore run)"
        outputFileNamePrefix: "Variable used to set the outputfile name"
        additionalParameters: "Additional parameters to be added to the sniffles command"
    }

    meta {
        author: "Matthew Wong"
        email: "m2wong@oicr.on.ca"
        description: "Workflow to run Structural Variant caller"
        dependencies: [{
            name: "Sniffles",
            url: "https://github.com/fritzsedlazeck/Sniffles"
        }]
    }
    call getVCF {
        input:
            sortedBamFile = sortedBamFile,
            outputFileNamePrefix = outputFileNamePrefix,
            additionalParameters = additionalParameters

    }
    output {
        File vcfFile = getVCF.vcfFile
    }
}

task getVCF {
    input {
        String sniffles = "sniffles"
        String? additionalParameters
        String outputFileNamePrefix
        File sortedBamFile
        String modules = "sniffles/1.0.11"
        Int memory = 31
    }
    parameter_meta {
        sniffles: "sniffles module name to use."
        sortedBamFile: "path to the bam file"
        modules: "Environment module names and version to load (space separated) before command execution."
        memory: "Memory (in GB) allocated for job."
        outputFileNamePrefix: "Variable used to set the outputfile name"
        additionalParameters: "Additional parameters to be added to the sniffles command"
    }
    meta {
        output_meta : {
            vcfFile: "Output .vcf file"
        }
    }

    command <<<
        ~{sniffles} \
        -m ~{sortedBamFile} \
        ~{additionalParameters} \
        -v ~{outputFileNamePrefix}_SV.vcf
    >>>

    output {
        File vcfFile = "~{outputFileNamePrefix}_SV.vcf"
    }
    runtime {
        modules: "~{modules}"
        memory: "~{memory} G"
    }
}
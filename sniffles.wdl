version 1.0

workflow sniffles {
    input {
        File sortedBamFile
        String outputFileNamePrefix = basename(sortedBamFile, ".bam")
        String? additionalParameters
    }
    parameter_meta {
        sortedBamFile: "Input bam file (must be sorted)"
        outputFileNamePrefix: "Variable used to set the outputfile name"
        additionalParameters: "Additional parameters to be added to the sniffles command"
    }

    meta {
        author: "Matthew Wong"
        description: "Workflow to run the Structural Variant caller Sniffles on Oxford Nanopore Data"
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
        Int timeout = 24
    }
    parameter_meta {
        sniffles: "sniffles module name to use."
        sortedBamFile: "Input bam file (must be sorted)"
        modules: "Environment module names and version to load (space separated) before command execution."
        memory: "Memory (in GB) allocated for job."
        outputFileNamePrefix: "Variable used to set the outputfile name"
        timeout: "Runtime for the job in hours."
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
        -v ~{outputFileNamePrefix}_sniffles.vcf
    >>>

    output {
        File vcfFile = "~{outputFileNamePrefix}_sniffles.vcf"
    }
    runtime {
        modules: "~{modules}"
        memory: "~{memory} G"
        timeout: "~{timeout}"
    }
}

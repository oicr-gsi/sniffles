version 1.0

workflow sniffles {
    input {
        File sortedBamFile
    }
    parameter_meta {
        sortedBamFile: "Input directory (directory of the nanopore run)"
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
            sortedBamFile = sortedBamFile
    }
    output {
        File vcfFile = getVCF.vcfFile
    }
}

task getVCF {
    input {
        String? sniffles = "sniffles"
        File sortedBamFile
        String? modules = "sniffles/1.0.11"
        Int? memory = 31
    }
    parameter_meta {
        sniffles: "sniffles module name to use."
        sortedBamFile: "path to the bam file"
        modules: "Environment module names and version to load (space separated) before command execution."
        memory: "Memory (in GB) allocated for job."
    }
    meta {
        output_meta : {
            vcfFile: "Output .vcf file"
        }
    }

    command <<<
        ~{sniffles} \
        -m ~{sortedBamFile} \
        -v output.vcf
    >>>

    output {
        File vcfFile = "output.vcf"
    }
    runtime {
        modules: "~{modules}"
        memory: "~{memory} G"
    }
}
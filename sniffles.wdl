version 1.0

workflow sniffles {
    input {
        File sortedBamFile
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
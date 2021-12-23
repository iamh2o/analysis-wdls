version 1.0

import "../tools/bam_to_fastq.wdl" as btf
import "../tools/trim_fastq.wdl" as tf

workflow bamToTrimmedFastq {
  input {
    File bam
    File adapters
    String adapter_trim_end
    Int adapter_min_overlap
    Int max_uncalled
    Int min_readlength
  }

  call btf.bamToFastq {
    input: bam=bam
  }

  call tf.trimFastq {
    input:
    reads1=bamToFastq.fastq1,
    reads2=bamToFastq.fastq2,
    adapters=adapters,
    adapter_trim_end=adapter_trim_end,
    adapter_min_overlap=adapter_min_overlap,
    max_uncalled=max_uncalled,
    min_readlength=min_readlength,
  }

  output {
    Array[File] fastqs = trimFastq.fastqs
    File fastq1 = trimFastq.fastq1
    File fastq2 = trimFastq.fastq2
  }
}

#/bin/bash
# Example usage:
# cd /fs/scratch/PAS1475/wtsa/ecoli/GSE54901/mace_out
# preprocess.sh fur_fe_mace /fs/scratch/PAS1475/wtsa/ecoli/genome/GCF_000005845.2_ASM584v2_genomic.fna /fs/scratch/PAS1475/wtsa/ecoli/genome/GCF_000005845.2_ASM584v2_genomic.fna.fai fur_fe


# Example parameter:
# MACE_PREFIX=fur_fe_mace
# REFERENCE_FILE=/fs/scratch/PAS1475/wtsa/ecoli/genome/GCF_000005845.2_ASM584v2_genomic.fna
# REFERENCE_INDEX=/fs/scratch/PAS1475/wtsa/ecoli/genome/GCF_000005845.2_ASM584v2_genomic.fna.fai
# ./preprocess.sh yiaj_glc_mace /fs/scratch/PAS1475/wtsa/ecoli/genome/GCF_000005845.2_ASM584v2_genomic.fna /fs/scratch/PAS1475/wtsa/ecoli/genome/GCF_000005845.2_ASM584v2_genomic.fna.fai yiaj_glc



MACE_PREFIX=$1
REFERENCE_FILE=$2
REFERENCE_INDEX=$3
OUTPUT_NAME=$4



sort -k5 ${MACE_PREFIX}_out.border_pair.bed | awk -vF=100 'BEGIN{ OFS="\t"; }{ len=$3-$2; diff=F-len; flank=int(diff/2); upflank=downflank=flank; if (diff%2==1) { downflank++; }; print $1, $2-upflank, $3+downflank; }' -  | awk '{print $0 "\t" $1":"$2"-"$3}'> ${MACE_PREFIX}_out.tmp.bed

bigWigMerge ${MACE_PREFIX}_Forward.bw ${MACE_PREFIX}_Reverse.bw ${MACE_PREFIX}_out.tmp.bg

bedtools complement -i ${MACE_PREFIX}_out.tmp.bg -g ${REFERENCE_INDEX} | bedtools genomecov -d -i stdin -g ${REFERENCE_INDEX}  | awk '{if($3>0) print $1"\t"$2-1"\t"$2"\t0"}' | sort -k1,1 -k2,2n ${MACE_PREFIX}_out.tmp.bg - > ${MACE_PREFIX}_peaks_gaps.tmp.bed

bedtools intersect -a ${MACE_PREFIX}_out.tmp.bed -b ${MACE_PREFIX}_peaks_gaps.tmp.bed -wb | cut -f4,8 | awk '$1 != f1 {if(NR>1) print f2; f1=f2=s=""}{f1=$1; f2=f2 s $2; s=","}END { print f1 }' > ${MACE_PREFIX}_coverage.tmp.txt

bedtools getfasta -fi ${REFERENCE_FILE} -bed ${MACE_PREFIX}_out.tmp.bed  |  awk '(NR)%2==0 {getline this<"${MACE_PREFIX}_coverage.tmp.txt";print this} 1' - | head -n -3 > ${OUTPUT_NAME}.tesa



rm ${MACE_PREFIX}_out.tmp.bg
rm ${MACE_PREFIX}_peaks_gaps.tmp.bed
rm ${MACE_PREFIX}_coverage.tmp.txt
rm ${MACE_PREFIX}_out.tmp.bed
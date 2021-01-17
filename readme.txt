module load bedtools

chmod +x preprocess.sh

Download and extract hg38:
http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz

# Build tesa
make clean && make

# Get input data from HINT-ATAC peaks:

./preprocess.sh MEP1_test.narrowPeak MEP1.bam hg38.fa out.txt

# Run tesa
./tesa -i out.txt

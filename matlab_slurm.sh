#!/bin/bash
#SBATCH --job-name="eta ETA"
#SBATCH -n 1                 # Number of cores
#SBATCH -N 1                 # Number of nodes for the cores
#SBATCH -t 1-12:59           # Runtime in D-HH:MM format
#SBATCH -p general           # Partition to submit to
#SBATCH --mem=4000           # Memory pool for all CPUs
#SBATCH -o %j.out      # File to which standard out will be written
#SBATCH -e %j.err      # File to which standard err will be written
#SBATCH --mail-type=FAIL      # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=barsinai@seas.harvard.edu  #Email to which notifications will be sent

module load matlab/R2016a-fasrc01
matlab -nodesktop -nodisplay -r "eta=ETA; n_iter=50; run run_collect_save"

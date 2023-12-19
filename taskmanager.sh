#!/bin/bash
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=48
#SBATCH --export=NONE
#SBATCH --mem 100G
#SBATCH --time 2-00:00:00 # time (D-HH:MM:SS)
#SBATCH --job-name=DPPCDOPCPIP2CHOL
#SBATCH -o world-model.%A_%a.%N.out
#SBATCH -e world-model.%A_%a.%N.err
#SBATCH --requeue




module purge
module load gcc openmpi cuda gromacs


module load gromacs/2019.6_mpi

export OMP_NUM_THREADS=2

srun --cpu-bind=core ./run.sh

srun --cpu-bind=core ./run.sh

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
module load gromacs/2023.3_mpi

export OMP_PLACES=cores

base_dir="$1"
num_paths="$2"
current_arg=3

for (( i=0; i<num_paths; i++ ))
do
    
    current_path="${!current_arg}"
    ((current_arg++))

    
    num_scripts="${!current_arg}"
    ((current_arg++))

    full_path="$base_dir/$current_path"
    echo "Running scripts in: $full_path"



    echo "Running scripts in: $full_path"
    
    for (( j=0; j<num_scripts; j++ ))
    do
        script_name="${!current_arg}"
        ((current_arg++))

        script_path="$full_path/$script_name"

        if [ -f "$script_path" ]; then
            echo "Running script: $script_name"
            cd "$full_path"
            ./"$script_name"
            cd "$base_dir"
        else
            echo "Script not found: $script_path"
        fi
    done
done

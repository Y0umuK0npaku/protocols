#!/bin/bash

export OMP_NUM_THREADS=2

prod_prefix=step7_production
prod_step=step7

cnt=1
cntmax=10

while [ ${cnt} -le ${cntmax} ]; do
    pcnt=$((cnt - 1))
    istep=${prod_step}_${cnt}
    pstep=${prod_step}_${pcnt}

    if [ ${cnt} -eq 1 ]; then
        pstep=$(step6.6_equilibration)
        gmx_mpi_openmp grompp -f ${prod_prefix}.mdp -o ${istep}.tpr -c ${pstep}.gro -p topol.top -n index.ndx
    else
        gmx_mpi_openmp grompp -f ${prod_prefix}.mdp -o ${istep}.tpr -c ${pstep}.gro -t ${pstep}.cpt -p topol.top -n index.ndx
    fi
    gmx_mpi_openmp mdrun -v -deffnm ${istep}
    cnt=$((cnt + 1))
done

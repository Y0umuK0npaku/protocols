#!/bin/bash

export OMP_NUM_THREADS=2

rest_prefix=step5_input
cg_prefix=step6.0_cg
equi_prefix=step6.%d_equilibration
prod_prefix=step7_production
prod_step=step7


cd out/

cnt=1
cntmax=6

while [ ${cnt} -le ${cntmax} ]; do
    pcnt=$((cnt - 1))
    istep=$(printf ${equi_prefix} ${cnt})
    pstep=$(printf ${equi_prefix} ${pcnt})
    if [ ${cnt} -eq 1 ]; then
        pstep=${cg_prefix}
    fi

    gmx_mpi_openmp grompp -ntomp  -f ${istep}.mdp -o ${istep}.tpr -c ${pstep}.gro -r ${rest_prefix}.gro -p topol.top -n index.ndx -maxwarn 2
    gmx_mpi_openmp mdrun -ntomp ${cnt}*2 -v -deffnm ${istep}
    cnt=$((cnt + 1))
done

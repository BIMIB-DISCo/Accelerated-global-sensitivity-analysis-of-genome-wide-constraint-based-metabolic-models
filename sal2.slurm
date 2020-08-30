#!/bin/bash

#SBATCH --nodes=8
#SBATCH --cpus-per-task=1
#SBATCH --ntasks-per-node=16
#SBATCH --ntasks=128
#SBATCH --time=08:00:00
#SBATCH --job-name=N2^15_n8_2nd
#SBATCH --partition=dvd_usr_prod
#SBATCH --output=salN2^15_n8_2nd-%j.out
#SBATCH --account=mBI18_DavNo

module purge
module load python
module load gnu
module load cuda
module load openmpi

SRCDIR=$HOME/sensitivity/code
RUNDIR=$CINECA_SCRATCH/sensitivity/$SLURM_JOB_NAME
mkdir $RUNDIR
cd $RUNDIR

source $CINECA_SCRATCH/VENV3.6/bin/activate

srun python $SRCDIR/sal2.py

sacct -j $SLURM_JOB_ID --format=User,JobID,Jobname,partition,NTasks,state,time,start,end,elapsed,AveCPU,AveCPUFreq,MinCPU,MinCPUNode,MinCPUTask,AveDiskRead,AveDiskWrite,MaxDiskRead,MaxDiskWrite,MaxDiskReadNode,MaxDiskWriteNode,AvePages,MaxPages,MaxPagesNode,MaxPagesTask,AveRSS,MaxRSS,MaxRSSNode,MaxRSSTask,AveVMSize,MaxVMSize,MaxVMSizeNode,MaxVMSizeTask,nnodes,ncpus,Nodelist,ConsumedEnergy,ConsumedEnergyRaw > sal$SLURM_JOB_NAME-$SLURM_JOB_ID.info

deactivate
echo 'Done'

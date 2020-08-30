#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --ntasks-per-node=16
#SBATCH --ntasks=16
#SBATCH --time=00:10:00
#SBATCH --job-name=N2^15_n8_2nd
#SBATCH --partition=dvd_usr_prod
#SBATCH --account=mBI18_DavNo
#SBATCH --output=sobN2^15_n8_2nd-%j.out
#SBATCH --dependency=afterok:4104

module purge
module load python
module load gnu
module load cuda
module load openmpi

SRCDIR=$HOME/sensitivity/code
RUNDIR=$CINECA_SCRATCH/sensitivity/$SLURM_JOB_NAME
mkdir -p $RUNDIR
cd $RUNDIR

source $CINECA_SCRATCH/VENV3.6/bin/activate

srun python $SRCDIR/sob.py

sacct -j $SLURM_JOB_ID --format=User,JobID,Jobname,partition,NTasks,state,time,start,end,elapsed,AveCPU,AveCPUFreq,MinCPU,MinCPUNode,MinCPUTask,AveDiskRead,AveDiskWrite,MaxDiskRead,MaxDiskWrite,MaxDiskReadNode,MaxDiskWriteNode,AvePages,MaxPages,MaxPagesNode,MaxPagesTask,AveRSS,MaxRSS,MaxRSSNode,MaxRSSTask,AveVMSize,MaxVMSize,MaxVMSizeNode,MaxVMSizeTask,nnodes,ncpus,Nodelist,ConsumedEnergy,ConsumedEnergyRaw > sob$SLURM_JOB_NAME-$SLURM_JOB_ID.info

deactivate
echo 'Done'

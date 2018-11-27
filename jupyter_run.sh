# Jupyter supervisor script 

#!/bin/bash

. /local/mnt/workspace/miniconda3/etc/profile.d/conda.sh
conda activate
jupyter notebook --allow-root > /local/mnt/workspace/root/notebook/logs/jupyter.log --config=/local/mnt/workspace/root/.jupyter/jupyter_notebook_config.py  


# Setup script for Jupyter notebook / Miniconda /
# Python data science/ML libraries
#

#!/bin/bash

ROOT_PATH=/local/mnt/workspace

printf "Installing system tools.\n\n"
apt-get update  # updates the package index cache
apt-get upgrade -y  # updates packages
# installs system tools
apt-get install -y git screen htop wget vim bzip2
apt-get install -y build-essential gcc zip default-jre
apt-get install -y poppler-utils  # pdf file conversion
apt-get upgrade -y bash  # upgrades bash if necessary

# java upgrade to 1.8
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer


printf "Cleaning up package index cache.\n\n"
apt-get clean  # cleans up the package index cache

# INSTALLING MINICONDA
printf "Installing Miniconda.\n\n"
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O \
  Miniconda.sh
bash Miniconda.sh -b  # installs Miniconda
rm Miniconda.sh  # removes the installer
# prepends the new path for current session
export PATH="$(ROOT_PATH)/miniconda3/bin:$PATH"
# prepends the new path in the shell configuration
echo ". $(ROOT_PATH)/miniconda3/etc/profile.d/conda.sh" >> ~/.bash_profile
echo "conda activate" >> ~/.bash_profile

# run conda virtual environment
source ~/.bash_profile

printf "Updating miniconda\n\n"
conda update -y conda 

printf "Installing Python packages.\n\n"
conda install -y jupyter  # Python coding in the browser
conda install -y pytables  # HDF5 database wrapper
conda install -y pandas  # data analysis package
conda install -y matplotlib  # plotting package
conda install -y scikit-learn  # machine learning package
conda install -y nltk=3.2.5  # nlp package
conda install -y gensim  # nlp package
conda install -y networkx  # network graph
conda install -y lxml  # xml/html parsing

pip install --upgrade pip
pip install Cython
pip install cufflinks  # combining plotly with pandas
pip install wordcloud
pip install pyvis

python -c "import nltk; nltk.download('stopwords'); nltk.download('punkt')"
python -c "import nltk; nltk.download('vader_lexicon'); nltk.download('wordnet')"

printf "Installing avro package.\n"
wget http://mirror.synyx.de/apache/avro/stable/py3/avro-python3-1.8.2.tar.gz
tar xvf avro-python3-1.8.2.tar.gz
cd avro-python3-1.8.2
python setup.py install
cd ..
rm avro-python3-1.8.2.tar.gz
rm -rf avro-python3-1.8.2

# COPYING FILES AND CREATING DIRECTORIES
mkdir $(ROOT_PATH)/jupyter
mkdir $(ROOT_PATH)/jupyter/.jupyter
mkdir $(ROOT_PATH)/jupyter/.jupyter/custom

cd $(ROOT_PATH)/jupyter/.jupyter
printf "Please provide a new password for your Jupyter server.\n"
printf "New password [ENTER]: "
read -s password
printf "\n"

printf "Repeat password [ENTER]: "
read -s rep_password
printf "\n"

while [ "$password" = "" -o "$password"  != "$rep_password" ]
do
printf "The passwords are empty or not equal, please try again!\n"
printf "New password [ENTER]: "
read -s password
printf "\n"

printf "Repeat password [ENTER]: "
read -s rep_password
printf "\n"
done

JUPYTER_URL=$(python jupyter_setup.py $password)

mkdir $(ROOT_PATH)/jupyter/notebook
cd $(ROOT_PATH)/jupyter/notebook

mv custom.css $(ROOT_PATH)/jupyter/.jupyter/custom/custom.css

mkdir logs
touch logs/jupyter.log


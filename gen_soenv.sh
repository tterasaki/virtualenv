#!/bin/bash

py=python3.8
envname=tomoki_soenv_$(date +"%Y%m%d")
echo $py, $envname

virtualenv -p $py /homes/tterasaki/my_soenv/software/$envname
source /homes/tterasaki/my_soenv/software/$envname/bin/

/homes/tterasaki/my_soenv/software/$envname/bin/pip3 install -r requirements.txt
/homes/tterasaki/my_soenv/software/$envname/bin/$py -m ipykernel install --prefix=/homes/tterasaki/my_soenv/software/$envname/ --name=$envname --display-name=$envname
/homes/tterasaki/my_soenv/software/$envname/bin/jupyter nbextension enable --py widgetsnbextension --sys-prefix

mkdir $envname"_sotodlib"
cd $envname"_sotodlib"
git clone git@github.com:simonsobs/sotodlib.git
cd sotodlib
/homes/tterasaki/my_soenv/software/$envname/bin/pip3 install .
/homes/tterasaki/my_soenv/software/$envname/bin/$py setup.py test

#2022-05-31 install qpoint (not tested actually)
mkdir $envname"_qpoint"
cd $envname"_qpoint"
git clone git@github.com:arahlin/qpoint.git
cd qpoint
/homes/tterasaki/my_soenv/software/$envname/bin/$py setup.py

unlink /homes/tterasaki/my_soenv/software/soenv_latest
ln -s /homes/tterasaki/my_soenv/software/$envname /homes/tterasaki/my_soenv/software/soenv_latest

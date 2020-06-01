# /bin/bash

echo "Anaconda Installer"

cd /tmp
curl -O https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh # Will need to update regularly

# Check sha results
sha_results=$(sha256sum Anaconda3-2019.03-Linux-x86_64.sh)
if [ "${sha_results}" == "45c851b7497cc14d5ca060064394569f724b67d9b5f98a926ed49b834a6bb73a  Anaconda3-2019.03-Linux-x86_64.sh" ]; then
    bash Anaconda3-2019.03-Linux-x86_64.sh
else
    echo "Anaconda hash did not match up!"
fi

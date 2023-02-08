
# MosesSMT: User Guide

Moses is a statistical machine translation system that allows you to automatically train translation models for any language pair.

### Step 01 : Installing `Docker.io` from APT ###
```
sudo apt install docker.io
```

<p>
<details>
<summary> <b>Having Proxy Issue?</b></summary><br/>
Run the following commands:

```
sudo mkdir -p /etc/systemd/system/docker.service.d
```

```
sudo vi /etc/systemd/system/docker.service.d/http-proxy.conf
```

And paste the following lines into `http-proxy.conf` file:

```
[Service]
Environment="HTTP_PROXY=http://172.16.199.20:8080"
Environment="HTTPS_PROXY=http://172.16.199.20:8080"
```

After adding, run the following comands to restart the daemon:

```
sudo systemctl daemon-reload
```

```
sudo systemctl restart docker.service
```

</details>
</p>

### Step 02 : Pulling Moses-SMT from `Docker.io` ###
```
docker pull techiaith/moses-smt
```
This will download and install a Moses machine translation system within your Docker environment.


### Step 03: Clone the corresponding git repo `Moses-SMT` ###
```
git clone https://github.com/porthtechnolegauiaith/moses-smt
```

### Step 04: Get into the folder `Moses-SMT` ###
```
cd moses-smt
```

### Step 05: Run the `Makefile` ###
```
make run
```
The running Docker container will respond.

## Step 06: Run the `Makefile` ###
Till this point the cloned folder and the docker image should be connected. To check if the docker container is connected or not, create a folder `moses-models` into the repo
you cloned, it should reflect in the docker `root` directory, if not, `exit` from the docker and change line number 7 of `Makefile`,
from `${PWD}` to the `/home/your-username/moses-smt` and run:

```
docker stop moses-smt
```

```
sudo make stop
```

```
make run
```

## Step 07: Folder Creation ###
In the github repo, make a folder named enhi under the folder moses-models, and paste the
[dataset](https://github.com/human71/moses-smt/tree/main/Dataset).<br>

&emsp;&emsp;|— moses-models <br>
&emsp;&emsp;&emsp;|——— enhi <br>
&emsp;&emsp;&emsp;&emsp;&emsp;|——— lm <br>
&emsp;&emsp;&emsp;&emsp;&emsp;|——— corpus <br>
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;|————— enhi.en <br>
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;|————— enhi.hi <br>
&emsp;&emsp;&emsp;|——— test <br>
&emsp;&emsp;&emsp;&emsp;&emsp;|——— test.sh <br>
&emsp;&emsp;&emsp;&emsp;&emsp;|——— src.txt <br>

## Step 08: Training ###
Go to the folder moses-smt in the docker shell and run the following for training:

```
python moses.py train -e enhi -s en -t hi
```

## Step 09: Testing ###
Make a folder inside moses-models named test and keep the text you want to test inside the
`src.txt` file. Then, save the following code as $test.sh and run $./test.sh
OR directly copy and paste the following code into terminal:

```
while IFS= read -r line
do
   "/home/moses/mosesdecoder/bin/moses" -f "/home/moses/moses-models/enhi/en-hi/engine/model/moses.ini" "$line" >> pred.txt
done < "src.txt"
```

## Step 10: Evaluation`(BLEU)` ###
Inside text folder create `target_gold.txt` with original tranlation abd run the following evaluate your file using BLEU.

```
./multi-bleu.pl target_gold.txt < pred.txt
```

## OS compatibility ##
Any kind of Linux Distro or WSL.

## Acknowledgements ##

Inspired by [techiaith](https://github.com/techiaith/docker-moses-smt).

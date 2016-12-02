# ###-->ZZZ_IMAGE<--###  

[`###-->ZZZ_IMAGE<--###`][1] is a [docker][2] image that bundles the following:  
* **[Linux ###-->ZZZ_LINUX_VERSION<--###][3]:**

## Details
* The following volumes exist:  
  - /linux
  - /opt/toolchains
* /linux is your default workdir. *Knowing this will be helpful when you're mounting your playbooks for execution.*   

## Usage 
This image can easily be extended.  

````
docker run --rm=true 
        -v $(pwd)/out:/linxu/src \
	###-->ZZZ_IMAGE<--###:###-->ZZZ_VERSION<--### 
````

## Misc. Info 
* Latest version: ###-->ZZZ_CURRENT_VERSION<--###   
* Built on: ###-->ZZZ_DATE<--###   
* Base image: ###-->ZZZ_BASE_IMAGE<--### ([dockerfile][6])  
* [Dockerfile][7]

[1]: https://hub.docker.com/r/###-->ZZZ_IMAGE<--###/   
[2]: https://docker.com 

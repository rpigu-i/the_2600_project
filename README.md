```
 _____ _            _____   ____ _____  _____  ______          _           _    
|_   _| |          / __  \ / ___|  _  ||  _  | | ___ \        (_)         | |   
  | | | |__   ___  `' / /'/ /___| |/' || |/' | | |_/ / __ ___  _  ___  ___| |_  
  | | | '_ \ / _ \   / /  | ___ \  /| ||  /| | |  __/ '__/ _ \| |/ _ \/ __| __| 
  | | | | | |  __/ ./ /___| \_/ \ |_/ /\ |_/ / | |  | | | (_) | |  __/ (__| |_  
  \_/ |_| |_|\___| \_____/\_____/\___/  \___/  \_|  |_|  \___/| |\___|\___|\__| 
                                                             _/ |               
                                                            |__/                
 _____           _         ___           _     _                                
/  __ \         | |       / _ \         | |   (_)                               
| /  \/ ___   __| | ___  / /_\ \_ __ ___| |__  ___   _____                      
| |    / _ \ / _` |/ _ \ |  _  | '__/ __| '_ \| \ \ / / _ \                     
| \__/\ (_) | (_| |  __/ | | | | | | (__| | | | |\ V /  __/                     
 \____/\___/ \__,_|\___| \_| |_/_|  \___|_| |_|_| \_/ \___|        

```


A project to containerize all the code from every 2600 magazine and serve from K8s or other container serving environment. This project is not linked to #2600 Magazine (https://www.2600.com/) in any official capacity. 


## Background

The purpose of this project is to collect all the old source code published in 2600, and create a set of containers so these can be run.
Not only does this preserve the code for future research, container based environments will allow you to run legacy operating systems and packages.

Threfore what we are creating is an archive of legacy code that will be available to anyone interested in running it, researching it or experimenting with it.


## Contributing

Check if the code has been ported to this repository. If not follow these steps:


1. Grab this repository by forking it.

2. Create a folder/use the folder for the magazine edition e.g. `23-4: Winter 2006-2007` would be: `23_4_winter_2006`

3. Clone and add a Dockerfile for the project, or other environment file required to run the code. 

4. Add in the code from 2600 Magazine

5. Get it running and update the README, including the magazine edition, a quick synopsis and the original author who created it. Any instructions to run the code should be included.

6. Create a PR from your Fork to this repository


Note: Some code may be copied over without a Dockerfile initially. If you would like to help get it running, follow the steps above, but add the Dockerfile to the folder with the code, and work to get it running.


## Disclaimer

The code in this repository is for educational and research purposes only. As many of the files contain work arounds, hacks and examples of bypassing security tooling, use at your own risk and use responsibly. 


## Magazine Editions Ported

* Spring 2004
* Summer 2004
* Autumn 2004
* Winter 2004
* Spring 2005
* Summer 2005
* Autumn 2005
* Winter 2005
* Spring 2006
* Summer 2006
* Autumn 2006
* Winter 2006
* Spring 2007
* Summer 2007
* Autumn 2007
* Winter 2007
* Spring 2008
* Summer 2008
* Autumn 2008
* Spring 2009
* Summer 2009
* Autumn 2009
* Winter 2009

## Thanks and ShoutOuts


Thanks to Nightride FM for providing an awesome soundtrack while porting the code over.

Check out their live feed on YouTube at: https://www.youtube.com/watch?v=cZRj9Sk0IPc

For more details:

* Join their community at: https://discord.gg/synthwave
* Visit their main website for higher quality audio at:  https://nightride.fm
* Support them on Patreon at: https://patreon.com/nightridefm




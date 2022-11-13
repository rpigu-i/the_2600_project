# The 2600 Project Code Archive

A project to containerize all the code from every 2600 magazine and serve from K8s or other container serving environment. This project is not linked to #2600 Magazine (https://www.2600.com/) in any official capacity. 


## Background

The ourpose of this project is to collect all the old source code published in 2600, and create a set of container so these can be run.
Not only does this preserve the code for future research, container based environments will allow you to run legacy operating systems and packages.



## Contributing

Check if the code has been ported to this repository. If not follow these steps:


1. Grab this repository by forking it.

2. Create a folder/use the folder for the magazine edition e.g. `23-4: Winter 2006-2007`

3. Clone and add a Dockerfile for the project

4. Add in the code from 2600 Magazine

5. Get it running and update the README, including the magazine edition, a quick synopsis and the original author who created it. 

6. Create a PR from your Fork to this repository


Note: Some code may be copied over without a Dockerfile initially. If you would like to help get it running, follow the steps above, but add the Dockerfile to the folder with the code, and work to get it running.


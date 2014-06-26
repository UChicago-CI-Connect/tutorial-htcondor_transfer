OSG Connect Tutorial: Transferring data with HTCondor
=====================================================

Overview
--------

This page will introduce users to transferring files using HTCondor's built-in transfer mechanisms.  HTCondor has a built-in mechanism to transfer binaries and files to and from compute nodes.  If users have relatively small amounts of data and binaries to transfer (<100MB) or needs to do ad-hoc job submissions, then this mechanism can be effective.

Conventions
-----------
    *In the examples used on this page, text in red is being used as a placeholder and will need to be replaced with user specific information (e.g. username )
    *Names of servers are denoted using blue text (e.g. login01.osgconnect.org)
    *Directory or file names are denoted using green text (e.g. ~/my_file)

Preliminaries
-------------
Before getting started, users should login to login01.osgconnect.org and get a copy of the tutorial files:
```
% ssh login01.osgconnect.org
$ tutorial htcondor_transfer
$ cd osg-htcondor_transfer
```
Word Distribution Example
-------------------------
This example will use the HTCondor transfer mechanisms to transfer a binary (distribution) and a file with a list of words (random_words) to compute nodes that are running the jobs. Create the condor file *transfer.submit*:
```
universe = vanilla
notification=never
executable = app_script.sh
output = logs/transfer.out.$(Process)
error = logs/transfer.err.$(Process)
log = logs/transfer.log
+ProjectName = "ConnectTrain"
 
transfer_input_files = distribution, random_words
ShouldTransferFiles = YES
when_to_transfer_output = ON_EXIT
 
queue 50
```
The key parts of the submit file are the transfer_input_files parameter that gives a comma separated list of paths to the files that will be transferred.  In addition, ShouldTransferFiles needs to be set to YES and when_to_transfer_output needs to be set to ON_EXIT in order to make sure that the HTCondor will return the output.

Finally, change submit file to by replacing PROJECT_NAME with the appropriate value before submitting the file:

**path warning:** You must run condor_submit in the same directory that you created the files and directories in. Otherwise HTCondor will give you an error due to not being able to find the distribution and random_words files

Now submit the job: 
```
$ condor_submit transfer.submit
```
When the jobs are completed, verify the output:
```
$ cat logs/transfer.out.0
Ashkenazim |45 (0.44%) +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
BIOS       |45 (0.44%) +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Anaheim    |44 (0.43%) +++++++++++++++++++++++++++++++++++++++++++++++++++++++
Aymara     |44 (0.43%) +++++++++++++++++++++++++++++++++++++++++++++++++++++++
Arthurian  |43 (0.42%) ++++++++++++++++++++++++++++++++++++++++++++++++++++++
Anaxagoras |43 (0.42%) ++++++++++++++++++++++++++++++++++++++++++++++++++++++
Bactria    |43 (0.42%) ++++++++++++++++++++++++++++++++++++++++++++++++++++++
Alexis     |43 (0.42%) ++++++++++++++++++++++++++++++++++++++++++++++++++++++
Ariel      |43 (0.42%) ++++++++++++++++++++++++++++++++++++++++++++++++++++++
Aubrey     |42 (0.41%) +++++++++++++++++++++++++++++++++++++++++++++++++++++
Baryshnikov|42 (0.41%) +++++++++++++++++++++++++++++++++++++++++++++++++++++
Bahia      |42 (0.41%) +++++++++++++++++++++++++++++++++++++++++++++++++++++
Angstrom   |42 (0.41%) +++++++++++++++++++++++++++++++++++++++++++++++++++++
Asoka      |42 (0.41%) +++++++++++++++++++++++++++++++++++++++++++++++++++++
Alcatraz   |41 (0.40%) ++++++++++++++++++++++++++++++++++++++++++++++++++++
```


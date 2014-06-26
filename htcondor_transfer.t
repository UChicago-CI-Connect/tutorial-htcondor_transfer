Prologue
--------
  $ cp -a ${TESTDIR}/tutorial-htcondor_transfer .
  $ cd tutorial-htcondor_transfer

HTCondor job
------------
Copy some extra utilities to the unit test directory
  $ cp ${TESTDIR}/run_and_wait.sh .

run transfer.submit through condor
  $ ./run_and_wait.sh transfer.submit
  All jobs done.

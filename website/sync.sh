#!/bin/sh

rsync -avz --progress --rsh='ssh -p221' snailchase/ morcmarc.com:~/snailchase
rsync -avz --progress --rsh='ssh -p221' biggerbadder/ morcmarc.com:~/biggerbadder
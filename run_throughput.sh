# USAGE: ./run.sh var
#  var: print statistics for indicated variable (default #txs)
#       need complete enough name for grep to find unambiguously (e.g. '#txs' works, 'txs' doesn't)

if [ -z $1 ]
then
var="\#txs"
else
var=$1
fi

bin=bin/spray

num_procs=(1 8 16 24 32)
#num_procs=(8 16)
#num_procs=(80)

echo "#procs,spray" #,lotan_shavit,linden,skip

for i in "${num_procs[@]}"
do
  spray[$i]=`taskset -c 0-31 $bin -l -i 1000000 -u 100 -d 5000 -n $i | grep $var | grep '(?<= )[0-9]+\.?[0-9]+' -Po`
  # lotan_shavit[$i]=`$bin -p -i 1000000 -u 100 -d 50000 -n $i | grep $var | grep '(?<= )[0-9]+\.?[0-9]+' -Po`
  # linden[$i]=`$bin -L -i 1000000 -u 100 -d 50000 -n $i | grep $var | grep '(?<= )[0-9]+\.?[0-9]+' -Po`
  # skip[$i]=`$bin -i 1000000 -u 100 -d 50000 -n $i | grep $var | grep '(?<= )[0-9]+\.?[0-9]+' -Po`

  echo $i,${spray[$i]}#,${lotan_shavit[$i]},${linden[$i]},${skip[$i]}
done



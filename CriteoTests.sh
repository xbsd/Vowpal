cat train.csv | sed -e '1d' | perl -wnlaF',' -e 'print "$F[1] 1 $F[0]|n I1:$F[2] I2:$F[3] I3:$F[4] I4:$F[5] I5:$F[6] I6:$F[7] I7:$F[8] I8:$F[9] I9:$F[10] I10:$F[11] I11:$F[12] I12:$F[13] I13:$F[14] |c @F[15 .. 40]"' | sed 's/^0/-1/g' | sed 's/I\([0-9]*\):\([ 0]\)//g' > train.vw

cat test.csv | sed -e '1d' | perl -wnlaF',' -e 'print "1 1 $F[0]|n I1:$F[1] I2:$F[2] I3:$F[3] I4:$F[4] I5:$F[5] I6:$F[6] I7:$F[7] I8:$F[8] I9:$F[9] I10:$F[10] I11:$F[11] I12:$F[12] I13:$F[13] |c @F[14 .. 39]"' | sed 's/^0/-1/g' | sed 's/I\([0-9]*\):\([ 0]\)//g' > test.vw 


# ---- Using Perl to convert Categorical Hex variables ----

echo "starting train ..."
cat /mnt/train.csv | sed -e '1d' | perl -wnlaF',' -e 'print map {hex($_).","} @F[15..30]' | sed 's/,$//g' > train.cat

echo "completed train, starting test ..."
cat /mnt/test.csv | sed -e '1d' | perl -wnlaF',' -e 'print map {hex($_).","} @F[14..29]' | sed 's/,$//g' > test.cat

echo "completed test"


echo "starting numeric variables"
echo "starting train ..."
cat /mnt/train.csv | cut -d, -f2-15 | sed '1d' > train.num

echo "completed train, starting test ..."
cat /mnt/test.csv | cut -d, -f1-14 | sed '1d' > test.num

echo "completed test ..."

sed -i 's/$/,/g' test.num # Add a , at the end of the file
paste test.num test.cat | sed 's/\t//g' > test.all

sed -i 's/$/,/g' train.num # Add a , at the end of the file
paste train.num train.cat | sed 's/\t//g' > train.all



# ---




head -100000 train.csv | sed -e '1d' | perl -wnlaF',' -e 'print "$F[1] 1 $F[0]|n I1:$F[2] I2:$F[3] I3:$F[4] I4:$F[5] I5:$F[6] I6:$F[7] I7:$F[8] I8:$F[9] I9:$F[10] I10:$F[11] I11:$F[12] I12:$F[13] I13:$F[14] |c @F[15 .. 40]"' | sed 's/^0/-1/g' | sed 's/I\([0-9]*\):\([ 0]\)//g' |wc -l

head -100000  test.csv | sed -e '1d' | perl -wnlaF',' -e 'print "1 1 $F[0]|n I1:$F[1] I2:$F[2] I3:$F[3] I4:$F[4] I5:$F[5] I6:$F[6] I7:$F[7] I8:$F[8] I9:$F[9] I10:$F[10] I11:$F[11] I12:$F[12] I13:$F[13] |c @F[14 .. 39]"' | sed 's/^0/-1/g' | sed 's/I\([0-9]*\):\([ 0]\)//g' | wc -l 

dasguna@ip-10-179-180-139:/disk1/raj/kg/cri/data$ vw -c -k -d train.vw --loss_function logistic -q nn --passes 20
creating quadratic features for pairs: nn
Num weight bits = 18
learning rate = 0.5
initial_t = 0
power_t = 0.5
decay_learning_rate = 1
creating cache_file = train.vw.cache
Reading datafile = train.vw
num sources = 1
average    since         example     example  current  current  current
loss       last          counter      weight    label  predict features
0.693147   0.693147            1         1.0  -1.0000   0.0000      158
0.349720   0.006292            2         2.0  -1.0000  -5.0653      158
0.174860   0.000000            4         4.0  -1.0000 -50.0000       28
0.477954   0.781048            8         8.0   1.0000  -1.6339       64
5.244884   10.011814          16        16.0   1.0000  30.1528      158
3.251490   1.258096           32        32.0   1.0000  15.1457      177
3.508890   3.766291           64        64.0  -1.0000  -1.0692      136
2.061089   0.613288          128       128.0   1.0000  -0.7941      182
1.278192   0.495295          256       256.0  -1.0000  -1.0342       42
0.889510   0.500828          512       512.0  -1.0000  -0.6308      132
0.682560   0.475611         1024      1024.0   1.0000  -0.6985      182
0.574597   0.466634         2048      2048.0   1.0000  -0.6239      132
0.526700   0.478803         4096      4096.0   1.0000   0.9018       94
0.512974   0.499247         8192      8192.0  -1.0000  -2.8465      111
0.499981   0.486988        16384     16384.0  -1.0000  -2.5750       64
0.484225   0.468470        32768     32768.0   1.0000   1.9549      116
0.473838   0.463450        65536     65536.0   1.0000  -2.0326      182
0.472180   0.470521       131072    131072.0  -1.0000  -2.6279      116
0.485555   0.498930       262144    262144.0  -1.0000  -2.2460      135
0.488640   0.491725       524288    524288.0  -1.0000  -1.8777       82
0.482243   0.475847      1048576   1048576.0  -1.0000  -1.6564      159
0.475536   0.468829      2097152   2097152.0   1.0000  -0.1791      112
0.472599   0.469661      4194304   4194304.0  -1.0000  -1.0285      136
0.470428   0.468257      8388608   8388608.0  -1.0000  -0.5158      157
0.470596   0.470764     16777216  16777216.0  -1.0000  -1.6774       38


dasguna@ip-10-179-180-139:/disk1/raj/kg/cri/data$ vw -c -k -d train.vw --loss_function logistic -q nn --passes 20 -b 29
creating quadratic features for pairs: nn
Num weight bits = 29
learning rate = 0.5
initial_t = 0
power_t = 0.5
decay_learning_rate = 1
creating cache_file = train.vw.cache
Reading datafile = train.vw
num sources = 1
average    since         example     example  current  current  current
loss       last          counter      weight    label  predict features
0.693147   0.693147            1         1.0  -1.0000   0.0000      158
0.349720   0.006292            2         2.0  -1.0000  -5.0653      158
0.174860   0.000000            4         4.0  -1.0000 -50.0000       28
0.477954   0.781048            8         8.0   1.0000  -1.6339       64
5.244884   10.011814          16        16.0   1.0000  30.1528      158
3.251490   1.258096           32        32.0   1.0000  15.1457      177
3.508899   3.766307           64        64.0  -1.0000  -1.0693      136
2.061090   0.613281          128       128.0   1.0000  -0.7948      182
1.278294   0.495498          256       256.0  -1.0000  -1.0391       42
0.889640   0.500987          512       512.0  -1.0000  -0.6391      132
0.682680   0.475720         1024      1024.0   1.0000  -0.7037      182
0.574832   0.466983         2048      2048.0   1.0000  -0.6318      132
0.526592   0.478352         4096      4096.0   1.0000   0.7626       94
0.512518   0.498445         8192      8192.0  -1.0000  -2.8684      111
0.499954   0.487390        16384     16384.0  -1.0000  -2.5902       64
0.483895   0.467837        32768     32768.0   1.0000   1.8715      116
0.473317   0.462739        65536     65536.0   1.0000  -2.0298      182
0.471337   0.469356       131072    131072.0  -1.0000  -2.5610      116
0.484668   0.498000       262144    262144.0  -1.0000  -2.1339      135
0.487488   0.490308       524288    524288.0  -1.0000  -1.7726       82
0.480675   0.473861      1048576   1048576.0  -1.0000  -1.7700      159

dasguna@ip-10-179-180-139:/disk1/raj/kg/cri/data$ vw -c -k -d train.vw --loss_function logistic --passes 3 -b 29 --ngram 2 --holdout_off -f model_4pass
Generating 2-grams for all namespaces.
final_regressor = model_4pass
Num weight bits = 29
learning rate = 0.5
initial_t = 0
power_t = 0.5
decay_learning_rate = 1
creating cache_file = train.vw.cache
Reading datafile = train.vw
num sources = 1
average    since         example     example  current  current  current
loss       last          counter      weight    label  predict features
0.693147   0.693147            1         1.0  -1.0000   0.0000       71
0.518596   0.344045            2         2.0  -1.0000  -0.8900       71
0.281205   0.043815            4         4.0  -1.0000 -25.6995       45
0.449563   0.617921            8         8.0   1.0000  -0.8058       53
0.461339   0.473115           16        16.0  -1.0000  -1.3595       55
0.632494   0.803650           32        32.0  -1.0000  -1.0046       49
0.600715   0.568936           64        64.0   1.0000  -2.0306       61
0.585908   0.571100          128       128.0  -1.0000  -0.3781       61
0.529205   0.472503          256       256.0  -1.0000  -2.6363       53
0.525494   0.521783          512       512.0  -1.0000  -1.6016       69
0.488318   0.451143         1024      1024.0  -1.0000  -1.8350       63
0.481673   0.475027         2048      2048.0  -1.0000  -0.7324       63
0.477424   0.473174         4096      4096.0   1.0000   0.0165       59
0.483377   0.489330         8192      8192.0  -1.0000  -3.6901       63
0.482555   0.481733        16384     16384.0  -1.0000   0.8482       67
0.478618   0.474680        32768     32768.0  -1.0000  -1.3982       65
0.470649   0.462680        65536     65536.0  -1.0000  -2.5984       69
0.467475   0.464302       131072    131072.0  -1.0000  -1.3733       71
0.483100   0.498724       262144    262144.0  -1.0000   0.4227       63
0.488736   0.494372       524288    524288.0  -1.0000   0.9234       67
0.483010   0.477284      1048576   1048576.0  -1.0000   0.8689       61
0.475800   0.468589      2097152   2097152.0  -1.0000  -1.9160       59
0.471523   0.467246      4194304   4194304.0  -1.0000  -1.7566       59
0.467899   0.464275      8388608   8388608.0  -1.0000  -2.2776       63
0.466793   0.465688     16777216  16777216.0  -1.0000  -1.5005       67
0.464342   0.461891     33554432  33554432.0  -1.0000  -1.8422       55


#!/usr/bin/perl
use strict;
use warnings;
use Net::Telnet;
use File::Copy;
my $Se="Sessions full, please try again later .....";
my $S="Save Config Succeeded!";
my $inf="Info: Finished loading the patch.";
my $AC="Access denied";
my $ip = './log/ips.txt';
my $log= './log/log.txt';
my $r='./log/recive.txt';
my $Failed='./log/failed.txt';
my $session='./log/session.txt';
my $acc='./log/access.txt';
my $save='./log/success.txt';
my $hang='./log/hang.txt';
my $info='./log/inf.txt';
my $a;
my $result;
my $v=1;
my $b;
open IPS,"<$ip";
while(<IPS>){
my $remote_host = $_;
$b=$remote_host;
chomp $b;
my $telnet = new Net::Telnet (Timeout=>15,Input_log =>"$r",Output_log =>"sent.txt",Errmode => 'return');
#my $telnet->error and die "unable to open";
$telnet->open($remote_host);
if($telnet->errmsg ){
print("connection failed $remote_host\n");
open (F,">>","$Failed");
print F "connection failed $remote_host\n";
}
elsif($telnet){
print("Telnet connected $remote_host\n");
$telnet->waitfor('/Username: /i');
$telnet->print('admin');
$telnet->waitfor('/Password: /i');
$telnet->print('r00tbcsNOC');
$telnet->waitfor('/\>/i');
$telnet->print('tftp 192.168.123.8 get S5700LI-V200R005SPH011.pat');
#$telnet->waitfor('/Password: /i');
$telnet->waitfor('/\>/i');
$telnet->print('patch load S5700LI-V200R005SPH011.pat all active');
$telnet->waitfor('/\>/i');
$telnet->print('patch load S5700LI-V200R005SPH011.pat all run');
#$telnet->waitfor('/\# $/i');
#$telnet->print('');
$telnet->waitfor('/\>/i');
#$telnet->waitfor('/\# $/i');
#$telnet->print('');
#$telnet->waitfor('/\# $/i');
$telnet->print('save');
$telnet->waitfor('/\] $/i');
$telnet->print('y');
$telnet->waitfor('/\> $/i');
$telnet->print('exit');
$telnet->close();
}
open(SES,">>","$session");
open(LOG,">>","$log");
open(R,"<","$r");
open(Acc,">>","$acc");
open(Save,">>","$save");
open(HANG,">>","$hang");
open(INF,">>","$info");
while(my $l=<R>){
chomp $l;
#print ("index $v");
#print $l;
#print ("string is $S");
$a=$l;
print $a;
print("\n");
#$result= $l cmp $S;
#print ("$result $S $l");
if($a eq $S){
print Save $b;
print Save ("  ---  ");
print Save $a;
print Save ("\n");
}
elsif($a eq $AC){
print Acc $b;
print Acc ("  ---  ");
print Acc $a;
print Acc ("\n");
}
elsif($a eq $Se){
print SES $b;
print SES ("  ---  ");
print SES $a;
print SES ("\n");
}
elsif($a eq $inf){
print INF $b;
print INF ("  ---  ");
print INF $a;
print $a;
print INF ("\n");
}
print LOG $l;
print LOG ("\n");
$v++;
}
if ($v==1){
print HANG ("$b");
}

}
close IPS;
close R;
close SES;
close LOG;
close Acc;
close Save;
close F;
close HANG;
close INF;
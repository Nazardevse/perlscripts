#!/usr/bin/perl
use strict;
use warnings;
use Net::Telnet;
use File::Copy;
my $Se="Sessions full, please try again later .....";
my $S="Save Config Succeeded!";
#my $inf="Info: Finished loading the patch.";
my $AC="Access denied";
my $ACD="Error: Authentication fail";
my $ip = './log/ips.txt';
my $log= './log/log.txt';
my $r='./log/recive.txt';
my $Failed='./log/failed.txt';
my $session='./log/session.txt';
my $acd='./log/huaccessdenied.txt';
my $save='./log/success.txt';
my $hang='./log/hang.txt';
my $portdes='./log/huaweides.txt';
my $a;
my $result;
my $v=1;
my $b;
open IPS,"<$ip";
while(<IPS>){
my $v=1;
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
$telnet->waitfor('/Username:/i');
$telnet->print('admin');
$telnet->waitfor('/Password:/i');
$telnet->print('r00tbcsNOC');
$telnet->waitfor('/\>/i'); 
$telnet->print('sys');
$telnet->waitfor('/\]/i');
$telnet->print("dis int des \n \n");
$telnet->waitfor('/\]/i');
$telnet->print('exit');
$telnet->close();
}
open(SES,">>","$session");
open(LOG,">>","$log");
open(R,"<","$r");
open(Acc,">>","$acd");
open(Save,">>","$save");
open(HANG,">>","$hang");
open(INF,">>","$portdes");
while(my $l=<R>){
chomp $l;
#print ("index $v");
#print $l;
#print ("string is $S");
$a=$l;
chomp $a;
print $a;
print "\n";
#$result= $l cmp $S;
#print ("$result $S $l");
if($a eq $S){
print Save $b;
print Save ("  ---  ");
print Save $a;
print Save ("\n");
}
elsif($a eq $ACD){
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

print LOG $l;
print LOG ("\n");



if ($v==25){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==26){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==27){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==28){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==29){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==30){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==31){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==32){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==33){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==34){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==35){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==36){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==37){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==38){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==39){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==40){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==41){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==42){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==43){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==44){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==45){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==46){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==47){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==48){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==49){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==50){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==51){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}
if ($v==52){
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");
}

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
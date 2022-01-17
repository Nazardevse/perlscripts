#!/usr/bin/perl
use strict;
use warnings;
use Net::Telnet;
use File::Copy;
my $Se="Sessions full, please try again later .....";
my $S="Save the configuration successfully.";
my $inf="Info: Finished loading the patch.";
my $AC="Error: Authentication fail";
my $ip = './log/ips.txt';
my $port='./log/ports.txt';
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
open PORT,"<$port";
while(!eof(IPS)){
my $remote_host = <IPS>;
my $p = <PORT>;
print("$remote_host\n");
print("$p\n");
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
$telnet->print("interface GigabitEthernet0/0/$p");
$telnet->waitfor('/\]/i');
$telnet->print('shutdown');
$telnet->waitfor('/\]/i');
$telnet->print('quit');
$telnet->waitfor('/\]/i');
$telnet->print('quit');
$telnet->waitfor('/\>/i');
$telnet->print('sa');
$telnet->waitfor('/\]/i');
$telnet->print('y');
$telnet->waitfor('/\>/i');
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
my $count=1;
while(my $l=<R>){
chomp $l;
#print ("index $v");
#print $l;
#print ("string is $S");
$a=$l;
print $a;
print "\n";
#$result= $l cmp $S;
#print ("$result $S $l");

if($a eq $AC){
print Acc $b;
print Acc ("  ---  ");
print Acc $a;
print Acc ("\n");
}
elsif($a eq $S){
print Save $b;
print Save ("  ---  ");
print Save $a;
print Save ("\n");
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
close PORT;
close R;
close SES;
close LOG;
close Acc;
close Save;
close F;
close HANG;
close INF;



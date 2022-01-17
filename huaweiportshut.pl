#!/usr/bin/perl
use strict;
use warnings;
use Net::Telnet;
use File::Copy;
use Net::Ping;
my $ACD="Error: Authentication fail";
my $S="Save the configuration successfully.";
my $ip = './log/ips.txt';
my $log= './log/log.txt';
my $r='./log/recive.txt';
my $port='./log/ports.txt';
my $Failed='./log/failed.txt';
my $save='./log/success.txt';
my $a;
my $result;
my $v=1;
my $b;
my $ping;
$ping = Net::Ping->new();
open IPS,"<$ip";
open PORT,"<$port";
while(!eof(IPS)){
my $remote_host = <IPS>;
my $p = <PORT>;
print("$remote_host\n");
print("$p\n");
$b=$remote_host;
chomp $b;
if($ping->ping($b))
{
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
open(LOG,">>","$log");
open(R,"<","$r");
open(Save,">>","$save");
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

if($a eq $ACD){
print F $b;
print F ("  ---  ");
print F $a;
print F ("\n");
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
print F ("$b");
print F (" --- ");
print F ("Hang\n");
}
}
else 
{
print("connection failed $remote_host\n");
open (F,">>","$Failed");
print F "connection failed $remote_host\n";
}

}
close IPS;
close PORT;
close R;
close LOG;
close Save;
close F;




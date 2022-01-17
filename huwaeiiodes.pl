#!/usr/bin/perl
use strict;
use warnings;
use Net::Ping;
use Net::Telnet;
use File::Copy;

my $ACD="Error: Authentication fail";
my $ip = './log/ips.txt';
my $log= './log/log.txt';
my $r='./log/recive.txt';
my $Failed='./log/failed.txt';
my $save='./log/success.txt';
my $port23='./log/port27.txt';
my $port24='./log/port28.txt';
my $output='./log/output.txt';
my $a;
my $result;
my $v=1;
my $b;
my $ping;
$ping = Net::Ping->new();
open IPS,"<$ip";
open IPS,"<$ip";
open PORT1,"<$port23";
open PORT2,"<$port24";
while(!eof(IPS)){
my $remote_host = <IPS>;
my $p = <PORT1>;
my $q = <PORT2>;
print("$remote_host\n");
print("$p ");
print("$q\n");
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
$telnet->print("int gig0/0/27 \n \n");
$telnet->waitfor('/\]/i');
$telnet->print("des $p");
$telnet->waitfor('/\]/i');
$telnet->print("int gig0/0/28 \n \n");
$telnet->waitfor('/\]/i');
$telnet->print("des $q");
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

open(Acd,">>","$acd");

open(INF,">>","$output");
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

if($a eq $ACD){
print F $b;
print F ("  ---  ");
print F $a;
print F ("\n");
}

print INF $b;
print INF (" ---- ");
print INF $p;
print INF (" ---- ");
print INF $q;
print INF ("\n");

print LOG $l;
print LOG ("\n");
$v++;
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
close R;

close LOG;

close F;

close INF;
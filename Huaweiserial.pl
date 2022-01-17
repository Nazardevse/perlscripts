#!/usr/bin/perl
use strict;
use warnings;
use Net::Telnet;
use Net::Ping;
use File::Copy;
my $Se="Sessions full, please try again later .....";
my $S="Save Config Succeeded!";
#my $inf="Info: Finished loading the patch.";
my $AC="Access denied";
my $ip = './log/ips.txt';
my $log= './log/log.txt';
my $r='./log/recive.txt';
my $Failed='./log/failed.txt';
my $serial='./log/serial.txt';
my $a;
my $result;
my $v=1;
my $b;
my $p;
$p = Net::Ping->new();
open IPS,"<$ip";
while(<IPS>){
my $v=1;
my $remote_host = $_;
$b=$remote_host;
chomp $b;
if($p->ping($b))
{

$b =~ s/^\s+//;
$b =~ s/^\s+//;
$b =~ s/^\s+//;
$b =~ s/^\s+//;
$b =~ s/\s+$//;
$b =~ s/\s+$//;
$b =~ s/\s+$//;
$b =~ s/\s+$//;
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
$telnet->print('screen-length 0 temporary');
$telnet->waitfor('/\>/i'); 
$telnet->print('sys');
$telnet->waitfor('/\]/i');
$telnet->print('dis device manufacture-info');
$telnet->waitfor('/\] $/i');
$telnet->print('exit');
$telnet->close();
}

open(LOG,">>","$log");
open(R,"<","$r");

open(INF,">>","$serial");
while(my $l=<R>){
chomp $l;
#print ("index $v");
#print $l;
#print ("string is $S");
$a=$l;
$a =~ s/^\s+//;
$a =~ s/^\s+//;
$a =~ s/^\s+//;
$a =~ s/^\s+//;
$a =~ s/\s+$//;
$a =~ s/\s+$//;
$a =~ s/\s+$//;
$a =~ s/\s+$//;
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


print LOG $l;
print LOG ("\n");
$v++;
if ($v==20){   #18
print INF $b;
print INF ("  ---  ");
print INF $a;
print INF ("\n");

}
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
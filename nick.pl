use strict;
use warnings;
 
my @dic;	#ìoò^é´èë
my %dic_same = ();
my @tmp;
my $i = 0;
my $same = 0;
my $check;
my $check_2;
my $memo;
my $memo_2;
my $_count = 0;
 
open(IN,"< nick.txt");
while(my $line=< IN>){
	$_count++;
	$check = 0;
	$check_2 = 0;
	@tmp = split(/=/,$line);
	$tmp[1] =~ s/\n|\r//sg;	#â¸çsè¡Ç∑
	
	for(my $_i=0;$_i< $#dic;$_i++){
		if($dic[$_i] eq $tmp[0]){
			$check = 1;
			$memo = $_i;
		}
		elsif($dic[$_i] eq $tmp[1]){
			$check_2 = 1;
			$memo_2 = $_i;
		}
	}
 
	if($check == 1 && $check_2 == 1){
		my $_same = $dic_same{$dic[$memo_2]};
		foreach my $key (keys(%dic_same)){
			if($dic_same{$key} == $_same){
				$dic_same{$key} = $dic_same{$dic[$memo]};
			}
		}
	}
	elsif($check == 1 && $check_2 == 0){
		$dic_same{$tmp[1]} = $dic_same{$dic[$memo]};
		$dic[$i] = $tmp[1];
		$i++;
	}
	elsif($check == 0 && $check_2 == 1){
		$dic_same{$tmp[0]} = $dic_same{$dic[$memo_2]};
		$dic[$i] = $tmp[0];
		$i++;
	}
	elsif($check == 0 && $check_2 == 0){
		$dic[$i] = $tmp[0];
		$dic[$i+1] = $tmp[1];
		$i += 2;
		$dic_same{$tmp[0]} = $same;
		$dic_same{$tmp[1]} = $same;
		$same++;
	}
}
 
 
my @_tmp;
my @head;	#êÊì™Ç…Ç≠ÇÈÇ»Ç‹Ç¶
my $before = -1;
my $start = 0;
my $_i = 0;
foreach my $key (sort { $dic_same{$a} < => $dic_same{$b} } keys %dic_same){
	if($start == 0 || $dic_same{$key} == $before){
		$start = 1;
		$_tmp[$_i] = $key;
	}
	else{
		@_tmp = sort {$a cmp $b} @_tmp;
		push(@head, $_tmp[0]);
		$_i = 0;
		@_tmp = ();
		$_tmp[$_i] = $key;
	}
	$_i++;
	$before = $dic_same{$key};
}
 
 
 
foreach(sort @head){
	my $_head = $_;
	my $count = 0;
	@_tmp = ();
	foreach my $key(keys %dic_same){
		if($dic_same{$key} == $dic_same{$_head}){
			push(@_tmp,$key);
		}
	}
	foreach(sort @_tmp){
		print "$_";
		if($count != $#_tmp){
			print "=";
		}
		$count++;
	}
	print "\n";
}
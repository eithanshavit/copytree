# enter you destination base folder
# and your source root folder
# don't forget double backslashes
my $dest = "C:\\eithans\\Projects\\Add levante C1\\a139\\";
my $root = "linux-2.6.32";
# my $root = "obm_v_122";
my $dest_env = "C:\\eithans\\Personal\\Programs\\copytree\\dest.txt";



use strict;
use warnings;
use Cwd;
use File::Copy;
use File::Basename;
use File::Path;

print("Copy Tree\n");
print "---------------\n";
my $fullpath = $ARGV[0];
if ($ARGV[1] eq "-d")
# is dir
{
	print("Destination Folder set to: $ARGV[0]\n");
	open( FILE, "> $dest_env" ) or die "Can't open file: $!";
	print FILE $ARGV[0];
	close FILE;
}
else
{
	open( FILE, "< $dest_env" ) or die "Can't open file: $!";
	$dest = <FILE>;
	close FILE;	
	$dest = substr($dest,1,-1);
	copyfile($dest);
}
sleep 2;

{
sub copyfile{
	my $destsub = shift;
	my $file = basename($fullpath);
	$file = substr($file, 0, -1);
	my $destdir = "";
	my $dir=getcwd;
	my @dirarray = split('/',$dir);
	$dir = pop(@dirarray);
	while  (($dir ne $root) && (@dirarray !=0))
	{
		$destdir = "$dir\\$destdir";
		$dir = pop(@dirarray);
	}
	if ($dir eq $root)
	{
		my $orgdestdir = "$destsub\\org\\$destdir";
		my $moddestdir = "$destsub\\mod\\$destdir";
		print("Create Dir:	$orgdestdir\n");
		print("Create Dir:	$moddestdir\n");
		print("Create File:	$file\n");
		print "\n";
		print "OK? (y/n): ";
		my $ask = <STDIN>;
		chomp $ask;
		print "\n";
		if ($ask eq "y")
		{
			if (! -d $orgdestdir)
				{
				  mkpath($orgdestdir) or die "Failed to create $destdir: $!\n";
				}
			if (! -d $moddestdir)
				{
				  mkpath($moddestdir) or die "Failed to create $destdir: $!\n";
				}
			copy($file,$orgdestdir) or die "Failed to copy $file: $!\n";
			copy($file,$moddestdir) or die "Failed to copy $file: $!\n";
			print "---------------\n";
			print "---------------\n";
			print "Success!\n";
		}
		else 
		{
			print "---------------\n";
			print "---------------\n";
			print "Aborted\n";
		}
	}
	else
	{
		print "---------------\n";
		print "---------------\n";
		print "Root Directory Not Found\n";
	}
}
}
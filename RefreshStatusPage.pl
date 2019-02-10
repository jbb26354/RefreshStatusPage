#!/opt/local/bin/perl

use File::Iterator;
use File::Basename;
use DateTime;

print "<html>\n<head>\n  <title>Music Collection Audit Status</title></head>\n<body>\n\n<table>\n\n<tr><td align=left><b><u>Artist</u></b></td><td align=left><b><u>LastChecked</u></b></td></tr><tr><td></td><td></td></tr>\n\n";

$Total = 0;
$TotalChecked = 0;

$it = new File::Iterator
(
  DIR     => '/Users/Pudnik/Music',
  RECURSE => 0,
  RETURNDIRS => 1
);

while ($file = $it->next()) 
{
  $Total++;
  if (-d $file) 
  {
    chdir $file;
    @files = glob("Checked_*.txt");
    foreach $textfile (@files)
		  {
      $TotalChecked++;
      ($name,$path,$ext) = fileparse($file, qr/\.[^.]*/);
      print "<tr><td>" . $name . "</td><td>" . substr($textfile,8,8) . "</td></tr>\n";
    }
  }
  chdir "..";
}

print "</table>\n\n";
print "<p>" . $TotalChecked . " / " . $Total . " = " . $TotalChecked / $Total * 100 . "% </p>\n\n";

my $dt   = DateTime->now;
my $date = $dt->ymd;
my $time = $dt->hms;
print "<p>" . $date . "\t" . $time . "</p>";

print "</body></html>";
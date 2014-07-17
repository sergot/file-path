use File::Path;
use Test;

plan 4;

my $path1 = 'foo/bar/foobar';

mkpath($path1);
ok 'foo'.IO.d, 'mkpath 1/3';
ok 'foo/bar'.IO.d, 'mkpath 2/3';
ok 'foo/bar/foobar'.IO.d, 'mkpath 3/3';

rmtree($path1);
ok !'foo'.IO.e, 'rmtree';

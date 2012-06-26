module File::Path;

sub mkpath(*@paths) is export {
    for @paths -> $path {
        for [\~] $path.split(/\//).map({ "$_/" }) {
            mkdir $_ unless .IO.d;
            # TODO: chmod, verbose, owner
        }
    }
}

sub remove($path) {
    $path.d ?? rmdir $path !! unlink $path;
}

sub ls_R($path) {
    my @all = dir $path;

    my @result = gather while @all {
        my $element = @all.shift;
        take $element;

        if $element.d {
            @all.push: dir $element;
        }
    }
    return @result;
}

sub rmtree(*@paths) is export {
    for @paths -> $path {
        for ([\~] $path.split(/\//).map({ "$_/" })).reverse {
            for ls_R($_).reverse -> $elem {
                remove $elem;
                # TODO: verbose
            }
        }
        remove $path.split(/\//)[0].IO;
    }
}

# vim: ft=perl6:

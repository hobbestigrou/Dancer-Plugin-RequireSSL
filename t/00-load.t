use strict;
use warnings;

use Test::More tests => 1;                      # last test to print


BEGIN {
    use_ok( 'Dancer::Plugin::SSLify' ) || print "Bail out";
}

diag( "Testing Dancer::Plugin::SSLify $Dancer::Plugin::SSLify::VERSION, Perl $], $^X" );

use strict;
use warnings;

use Test::More import => ['!pass'];

use Dancer;
use Dancer::Test;

use lib 't/lib';
use TestApp;

plan tests => 3;

setting environment => 'test';
my $res = dancer_response GET => '/';
is $res->{status}, 302, "response for GET / is 200";
is $res->{headers}->{location}, 'https://localhost/', 'redirect with https';
is $res->{headers}->{'strict-transport-security'}, 'max-age=31536000', "time max-age is 31536000";

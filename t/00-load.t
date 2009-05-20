#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Text::Phonetic::VideoGame' );
}

diag( "Testing Text::Phonetic::VideoGame $Text::Phonetic::VideoGame::VERSION, Perl $], $^X" );

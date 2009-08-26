use strict;
use warnings;
use Text::Phonetic::VideoGame;
use Test::More;

my %tests = (

    # some words that should be split
    'baseball'     => [ 'base', 'ball'     ],
    'chromehounds' => [ 'chrome', 'hounds' ],
    'farcry'       => [ 'far', 'cry'       ],
    'football'     => [ 'foot', 'ball'     ],
    'mechassault'  => [ 'mech', 'assault'  ],
    'megaman'      => [ 'mega', 'man'      ],
    'softball'     => [ 'soft', 'ball'     ],
    'starfox'      => [ 'star', 'fox'      ],

    # some words that shouldn't be split
    'fantasy' => [ 'fantasy' ],
    'soccer'  => [ 'soccer'  ],
    'tennis'  => [ 'tennis'  ],
);

plan tests => scalar keys %tests;
my $phonetic = Text::Phonetic::VideoGame->new;
while ( my ($word, $expected) = each %tests ) {
    my @got = $phonetic->split_compound_word($word);
    is_deeply( \@got, $expected, $word );
}

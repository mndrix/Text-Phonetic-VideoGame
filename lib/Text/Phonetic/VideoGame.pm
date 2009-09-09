package Text::Phonetic::VideoGame;
use warnings;
use strict;
use base 'Text::Phonetic';

use String::Nysiis;
use Roman ();
use Lingua::EN::Inflect::Number qw( to_S );

our $VERSION = '0.01';
my %ordinal = (
    '1st' => 'first',
    '2nd' => 'second',
    '3rd' => 'third',
    '4th' => 'fourth',
    '5th' => 'fifth',
    '6th' => 'sixth',
    '7th' => 'seventh',
    '8th' => 'eighth',
    '9th' => 'ninth',
);
my %abbreviation = (
    bros => 'brothers',
    ddr  => 'dance dance revolution',
    doa  => 'dead or alive',
    ff   => 'final fantasy',
    gta  => 'grand theft auto',
    iss  => 'international superstar soccer',
    le   => 'limited edition',
    nam  => 'vietnam',
    ny   => 'new york',
    tmnt => 'teenage mutant ninja turtles',

    # easier than using split_compound_word
    bustamove => 'bust a move',
    davinci   => 'da vinci',
    fzero     => 'f zero',
    motogp    => 'moto gp',
    proam     => 'pro am',
    rtype     => 'r type',
    xmen      => 'x men',
);

sub _do_encode {
    my $self   = shift;
    my $string = lc shift;
    my $original = $string;

    $string =~ s{[-/:]}{ }g;     # dashes, slashes are like spaces
    $string =~ s/[&.'"]//g;     # most punctuation can be ignored
    $string =~ s/\b([1-9])(st|nd|rd|th)\b/$ordinal{"$1$2"}/ge;
    $string =~ s/\b2k([0-9])\b/200$1/ig;   # 2K4 -> 2004
    $string =~ s/(\D)(\d)/$1 $2/g;  # "xbox360", "kombat4", etc

    # expand some common abbreviations
    my $abbr = join '|', keys(%abbreviation);
    $string =~ s/\b($abbr)\b/$abbreviation{$1}/ge;

    # remove some noise words
    $string =~ s/\b(n|a|an|the|and|of|vs|at|in)\b//g;
    $string =~ s/\b(edition|volume|vol|game)\b//g;

    $string =~ s/\s+/ /g;
    $string =~ s/^\s+|\s+$//g; # remove leading/trailing spaces

    # normalize numbers that might be years
    $string =~ s/\b(7|8|9)([0-9])\b/19$1$2/g;  # 97 -> 1997
    $string =~ s/\b(0|1|2)([0-9])\b/20$1$2/g;  # 03 -> 2003

    # do some in-place substitutions
    my @words = map { $self->split_compound_word($_) } split / /, $string;
    for my $word (@words) {
        $word = $self->word2num($word);
        $word = Roman::arabic($word) if Roman::isroman($word);
    }

    my @encodings = map { /^\d+$/ ? $_ : String::Nysiis::nysiis($_) } @words;
    $string = join ' ', @encodings;

    # remove redundant words
    $string =~ s/\b(\d+)\s\1\b/$1/g;    # 2 2 -> 2
    for ($string) {
        s/\bNANTAND\b//   if $original =~ /\bds\b/;      # Nintendo   <- DS
        s/\bNANTAND\b//   if $original =~ /\bwii\b/;     # Nintendo   <- Wii
        s/\bSACAR\b//     if $original =~ /\bfifa\b/;    # soccer     <- FIFA
        s/\bBASCATBAL\b// if $original =~ /\bnba\b/;     # basketball <- NBA
        s/\bFAT BAL\b//   if $original =~ /\bnfl\b/;     # football   <- NFL
        s/\bHACY\b//      if $original =~ /\bnhl\b/;     # hockey     <- NHL
    }
    for ($string) {
        s/\bNFL\b//    if /\bMAD DAN\b/;      # NFL      <- Madden
        s/\bGALf\b//   if /\bTAGAR WAD\b/;    # golf     <- Tiger Woods
        s/\bFAT BAL\b// if /\bBLITZ\b/;       # football <- blitz
        s/\bHAGAG\b//  if /\bSANAC\b/;        # hedgehog <- Sonic
        s/\bCABAL\b//  if /\bDANGAR HAN\b/;   # Cabela's <- Dangerous Hunts
        s/\bBNX\b//    if /\bDAV MAR\b/;      # BMX      <- Dave Mirra
        s/\bW\b//      if /\bRASTL MAN\b/;    # WWE      <- Wrestlemania
    }

    $string =~ s/X\b/C/g;      # "TANX" -> "TANC" etc
    $string =~ s/\s+/ /g;
    $string =~ s/^\s+|\s+$//g; # remove leading/trailing spaces
    return $string;
}

# returns an arabic numeral representation of number word
# ("five" -> 5). If the word is not a number word, returns the word.
sub word2num {
    my ($self, $word) = @_;
    my %words = (
        one   => 1,
        two   => 2,
        three => 3,
        four  => 4,
        five  => 5,
        six   => 6,
        seven => 7,
        eight => 8,
        nine  => 9,
    );
    return $words{$word} if exists $words{$word};
    return $word;
}

sub split_compound_word {
    my ( $self, $word ) = @_;

    # don't produce subwords less than 3 characters
    my $length = length $word;
    return $word if $length < 6;

    # try to split the word into smaller two smaller words
    for my $i ( 3 .. $length-3 ) {
        my $front = substr $word, 0, $i;
        my $back  = substr $word, $i;
        return ( $front, $back )
          if $self->is_word($front)
          and $self->is_word($back);
        return ( $front, $back )
          if $self->is_word( to_S $front )
          and $self->is_word( to_S $back );
    }

    return $word;
}

# a hand picked dictionary of short nouns and adjectives
my %dictionary = map { $_ => 1 } qw(
    acid
    acme
    acne
    acre
    act
    aeon
    age
    aid
    all
    alpha
    ammo
    anal
    andreas
    anti
    apex
    aqua
    arch
    area
    arm
    arms
    army
    ash
    assault
    astro
    atom
    aunt
    aura
    axe
    axes
    axle
    axon
    baby
    back
    bad
    bag
    bail
    bain
    bait
    bald
    bale
    ball
    band
    bane
    bang
    bank
    bar
    barb
    bark
    barn
    baru
    base
    bass
    bath
    bats
    battle
    bead
    beam
    bean
    bear
    beat
    beef
    beer
    beet
    bell
    belt
    best
    bike
    big
    bird
    bite
    blade
    blob
    blood
    blue
    boar
    boat
    bob
    body
    bomb
    bomber
    bond
    bone
    book
    boot
    boss
    bot
    bound
    bow
    boy
    brain
    brat
    break
    brew
    buck
    bud
    bull
    bump
    bunk
    burger
    bush
    bust
    butt
    cage
    cake
    caliber
    calibur
    call
    camp
    cane
    car
    card
    cart
    cat
    chip
    chrome
    chum
    city
    clay
    clod
    clown
    club
    coal
    coaster
    coat
    cog
    coke
    comb
    cook
    corn
    craft
    crew
    crib
    crop
    cross
    crow
    cry
    cube
    cup
    cyan
    dam
    dart
    dash
    data
    date
    dawn
    day
    days
    dead
    deaf
    debt
    deck
    den
    dent
    diet
    dime
    dock
    dog
    dogs
    doo
    dope
    dorm
    double
    drag
    dream
    drip
    drop
    dry
    dual
    duck
    duct
    dude
    due
    duel
    dump
    dust
    duty
    ear
    earth
    east
    eat
    edit
    eel
    egg
    elf
    elk
    elm
    epic
    ever
    excite
    exit
    extra
    eye
    face
    fad
    fake
    fall
    fan
    far
    fare
    fat
    fear
    feat
    fest
    field
    fighter
    film
    fit
    flag
    flat
    foal
    foil
    fold
    food
    fool
    foot
    fort
    fox
    francisco
    front
    fuel
    fury
    fuse
    game
    garb
    gash
    gate
    geek
    gem
    gene
    germ
    gig
    girl
    glen
    glue
    gnat
    goal
    goat
    god
    gold
    golden
    golf
    good
    goof
    grad
    gram
    grave
    gray
    grey
    grid
    grog
    grub
    gun
    guy
    gym
    hair
    halo
    harm
    hat
    hawk
    head
    heat
    heel
    helm
    help
    herb
    herd
    high
    hiss
    hit
    hive
    hobo
    holy
    home
    hot
    hounds
    hour
    house
    howl
    hub
    hurt
    hymn
    ice
    idea
    idol
    inch
    iris
    isle
    ivy
    jade
    jaw
    jazz
    jeep
    jig
    jive
    job
    joke
    jot
    jug
    junk
    kart
    keel
    keep
    kill
    kit
    kite
    knob
    lacy
    lady
    lake
    lamb
    lamp
    land
    lane
    lank
    lap
    law
    lead
    leaf
    leg
    life
    light
    lily
    limb
    lime
    lip
    list
    loaf
    loan
    lock
    long
    loot
    loud
    love
    low
    mad
    mail
    man
    mania
    mario
    master
    mate
    maze
    mech
    mega
    melt
    mesh
    mess
    metal
    metroid
    milk
    mint
    moat
    monk
    monkey
    moon
    moss
    mote
    mud
    myth
    name
    navy
    nine
    nuke
    oak
    oar
    odd
    odor
    off
    ogre
    old
    one
    out
    owl
    pac
    pack
    page
    palm
    pant
    paper
    pawn
    peer
    pilot
    ping
    pint
    pixy
    play
    poem
    poet
    pole
    poll
    pong
    power
    pray
    prey
    prime
    puck
    puff
    pug
    pump
    pun
    punch
    pure
    quiz
    race
    rag
    rage
    rain
    ranger
    rant
    rap
    rare
    rayne
    realm
    rich
    ride
    rig
    riot
    road
    rock
    roll
    roller
    roof
    rook
    room
    root
    rope
    rose
    row
    ruby
    rump
    rust
    rye
    sack
    sale
    salt
    san
    sash
    scab
    scooby
    seal
    seam
    seat
    sect
    self
    sew
    shift
    ship
    shore
    sick
    side
    silk
    silo
    sim
    sink
    six
    skin
    skit
    slam
    slug
    slum
    smash
    smog
    snow
    soap
    sock
    sofa
    soft
    soul
    sound
    soup
    sour
    speed
    spider
    splitter
    sponge
    spot
    spy
    square
    star
    station
    stem
    step
    stew
    stool
    story
    super
    swim
    switch
    tail
    talk
    tall
    tank
    tanx
    task
    tax
    team
    tear
    tech
    teck
    teen
    temp
    text
    thin
    thru
    tick
    tide
    tiger
    time
    toad
    toe
    toll
    tomb
    tome
    tot
    toy
    trap
    tree
    tube
    tusk
    twin
    user
    vain
    veil
    vein
    vest
    vial
    visa
    vote
    vow
    walker
    wage
    war
    ward
    ware
    wario
    warp
    wart
    wasp
    wave
    weak
    weal
    web
    wet
    wheel
    whip
    wick
    wii
    wind
    wine
    wing
    wise
    wolf
    womb
    wood
    world
    worm
    wrestle
    yard
    yarn
    year
    york
    zero
    zoom
);
sub is_word {
    my ($self, $word) = @_;
    return $dictionary{ lc $word };
}

1;

=head1 NAME

Text::Phonetic::VideoGame - phonetic encoding for video game titles

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Text::Phonetic::VideoGame;

    my $foo = Text::Phonetic::VideoGame->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head2 function1

=head1 AUTHOR

Michael Hendricks, C<< <michael@ndrix.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-text-phonetic-videogame at
rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Text-Phonetic-VideoGame>.  I
will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Text::Phonetic::VideoGame

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Text-Phonetic-VideoGame>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Text-Phonetic-VideoGame>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Text-Phonetic-VideoGame>

=item * Search CPAN

L<http://search.cpan.org/dist/Text-Phonetic-VideoGame/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Michael Hendricks, all rights reserved.

This program is released under the following license: MIT

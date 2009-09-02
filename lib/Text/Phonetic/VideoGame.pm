package Text::Phonetic::VideoGame;
use warnings;
use strict;
use base 'Text::Phonetic';

use String::Nysiis;
use Roman ();

our $VERSION = '0.01';

sub _do_encode {
    my $self   = shift;
    my $string = lc shift;

    $string =~ s/-/ /g;       # dashes are more like spaces than punctuation
    $string =~ s/[&.'"]//g;     # most punctuation can be ignored
    $string =~ s/\b(n|a|an|the|and)\b//g;    # isolated noise words
    $string =~ s/\s+/ /g;
    my @words = map { $self->split_compound_word($_) } split / /, $string;

    # do some in-place substitutions
    for my $word (@words) {
        $word = Roman::arabic($word) if Roman::isroman($word);
    }

    my @encodings = map { String::Nysiis::nysiis($_) } @words;
    return join ' ', @encodings;
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
    big
    bird
    bite
    blade
    blob
    blue
    boar
    boat
    body
    bomb
    bomber
    bond
    bone
    boot
    boss
    bot
    bound
    bow
    boy
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
    cage
    cake
    call
    camp
    cane
    car
    card
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
    dope
    dorm
    double
    drag
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
    exit
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
    fuel
    fury
    fuse
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
    mario
    master
    mate
    maze
    mech
    mega
    melt
    mesh
    mess
    milk
    mint
    moat
    monk
    monkey
    moon
    moss
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
    owl
    pac
    pack
    page
    palm
    paper
    pawn
    peer
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
    puck
    puff
    pug
    pump
    pun
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
    spot
    spy
    star
    station
    stem
    step
    stew
    story
    super
    swim
    tail
    talk
    tall
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
    wage
    war
    ward
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
    wine
    wing
    wise
    wolf
    womb
    wood
    world
    worm
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

#!/usr/bin/perl
#
# A quick hack (<1 hr) Perl script to play a game of snap.
#
#  usage:
#    $ snap1.pl <n_players>
#
# An optional argument can be used to specify the number of players.
# It defaults to 2 players.
#
# The script doesn't allow you to play a proper game but acts as more of a
# simulation.  A standard deck of 52 cards is dealt to the N players.  Each
# player lays a card in turn until subsequent cards match either in suite or
# rank (obviously they can't match both in a single deck - would need to fix
# if adapting to use multiple decks).  The cards in the pile are then given
# to the player who laid the most recent card.
#
# The winner is the first person to discard all their cards.
#
# Written by Andy Wardley, March 2015
#

use strict;
use warnings;
use List::Util 'shuffle';

#-----------------------------------------------------------------------------
# Configuration options
#-----------------------------------------------------------------------------

our $N_PLAYERS = shift @ARGV || 2;
our $SHUFFLES  = 10;
our @RANKS     = ('A', 2..10, 'J', 'Q', 'K');
our @SUITS     = qw( Hearts Diamonds Spades Clubs );
our $DEBUG     = 0;


#-----------------------------------------------------------------------------
# main entry point
#-----------------------------------------------------------------------------

play_game($N_PLAYERS);


#-----------------------------------------------------------------------------
# Subroutines
#-----------------------------------------------------------------------------

sub play_game {
    my $n_players = shift || die 'usage: play_game($n_players)';
    my @hands     = dealed_deck($n_players);
    my @pile;

    show_hands(@hands) if $DEBUG;

    print "Starting game\n";

    # players take it in turns
    my $n = 0;
    my $last_card;

    while (1) {
        # modulo the number of players to get index into hands
        my $pnum = $n++ % $n_players;
        my $hand = $hands[$pnum];
        my $snap = 0;

        # humans use 1/2, not 0/1
        $pnum++;

        # Do we have a winner?
        if (! @$hand) {
            print "Player $pnum is out of cards!  They're the winniest winner of all!\n";
            return;
        }

        # take a card from the player's hand...
        my $card = shift @$hand;

        # ...and put the card on the discard pile
        push(@pile, $card);

        print "  P$pnum: $card->{ card }\n";

        # compare it to the last card
        if ($last_card) {
            if ($last_card->{ rank } eq $card->{ rank }) {
                print "SNAP! (matched rank: $last_card->{ rank })\n";
                $snap = 1;
            }
            elsif ($last_card->{ suit } eq $card->{ suit }) {
                print "SNAP! (matched suit: $last_card->{ suit })\n";
                $snap = 1;
            }
        }

        # did someone say SNAP?
        if ($snap) {
            # OK, so this version doesn't really play the game properly - we'll
            # just give the cards to the player who played the last card
            push(@$hand, @pile);

            # clear the pile
            @pile = ();

            print "Cards are added to player $pnum\'s hand\n";
            summarise_hands(@hands);

            sleep(1);
        }

        # save current card as last card
        $last_card = $card;
    }
}

sub dealed_deck {
    my $n_players = shift || die 'usage: dealed_deck($n_players)';
    my @deck      = shuffled_deck();
    my @hands     = map { [ ] } (1..$n_players);
    my $n         = 0;

    while (@deck) {
        my $hand = $hands[$n++ % $n_players];
        push(@$hand, shift@deck);
    }
    return @hands;
}

sub shuffled_deck {
    my @deck;

    # build a deck
    for my $r (@RANKS) {
        for my $s (@SUITS) {
            push(@deck, { rank => $r, suit => $s, card => "$r $s" });
        }
    }

    # shuffle the deck a few times (not sure how random shuffle() is?)
    for (1..$SHUFFLES) {
        @deck = shuffle @deck;
    }

    return @deck;
}

sub show_hands {
    my @hands = @_;
    my $n     = 1;
    my $j     = "\n - ";

    for my $hand (@hands) {
        print "Player ", $n++, "'s hand:", $j;
        print join($j, map { $_->{ card } } @$hand), "\n";
    }
}

sub summarise_hands {
    my @hands = @_;
    my $n     = 1;
    my $j     = "\n - ";

    for my $hand (@hands) {
        my $c = scalar @$hand;
        print "Player ", $n++, " has $c cards\n";
    }

}
